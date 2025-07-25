//===- ProfileCommon.h - Common profiling APIs. -----------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains data structures and functions common to both instrumented
// and sample profiling.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_PROFILEDATA_PROFILECOMMON_H
#define LLVM_PROFILEDATA_PROFILECOMMON_H

#include "llvm/ADT/ArrayRef.h"
#include "llvm/IR/ProfileSummary.h"
#include "llvm/ProfileData/InstrProf.h"
#include "llvm/ProfileData/SampleProf.h"
#include "llvm/Support/Compiler.h"
#include "llvm/Support/Error.h"
#include <algorithm>
#include <cstdint>
#include <functional>
#include <map>
#include <memory>
#include <vector>

namespace llvm {

LLVM_ABI extern cl::opt<bool> UseContextLessSummary;
LLVM_ABI extern cl::opt<int> ProfileSummaryCutoffHot;
LLVM_ABI extern cl::opt<int> ProfileSummaryCutoffCold;
LLVM_ABI extern cl::opt<unsigned> ProfileSummaryHugeWorkingSetSizeThreshold;
LLVM_ABI extern cl::opt<unsigned> ProfileSummaryLargeWorkingSetSizeThreshold;
LLVM_ABI extern cl::opt<uint64_t> ProfileSummaryHotCount;
LLVM_ABI extern cl::opt<uint64_t> ProfileSummaryColdCount;

namespace sampleprof {

class FunctionSamples;

} // end namespace sampleprof

class ProfileSummaryBuilder {
private:
  /// We keep track of the number of times a count (block count or samples)
  /// appears in the profile. The map is kept sorted in the descending order of
  /// counts.
  std::map<uint64_t, uint32_t, std::greater<uint64_t>> CountFrequencies;
  std::vector<uint32_t> DetailedSummaryCutoffs;

protected:
  SummaryEntryVector DetailedSummary;
  uint64_t TotalCount = 0;
  uint64_t MaxCount = 0;
  uint64_t MaxFunctionCount = 0;
  uint32_t NumCounts = 0;
  uint32_t NumFunctions = 0;

  ProfileSummaryBuilder(std::vector<uint32_t> Cutoffs)
      : DetailedSummaryCutoffs(std::move(Cutoffs)) {}
  ~ProfileSummaryBuilder() = default;

  inline void addCount(uint64_t Count);
  LLVM_ABI void computeDetailedSummary();

public:
  /// A vector of useful cutoff values for detailed summary.
  LLVM_ABI static const ArrayRef<uint32_t> DefaultCutoffs;

  /// Find the summary entry for a desired percentile of counts.
  LLVM_ABI static const ProfileSummaryEntry &
  getEntryForPercentile(const SummaryEntryVector &DS, uint64_t Percentile);
  LLVM_ABI static uint64_t getHotCountThreshold(const SummaryEntryVector &DS);
  LLVM_ABI static uint64_t getColdCountThreshold(const SummaryEntryVector &DS);
};

class InstrProfSummaryBuilder final : public ProfileSummaryBuilder {
  uint64_t MaxInternalBlockCount = 0;

public:
  InstrProfSummaryBuilder(std::vector<uint32_t> Cutoffs)
      : ProfileSummaryBuilder(std::move(Cutoffs)) {}

  LLVM_ABI void addEntryCount(uint64_t Count);
  LLVM_ABI void addInternalCount(uint64_t Count);

  LLVM_ABI void addRecord(const InstrProfRecord &);
  LLVM_ABI std::unique_ptr<ProfileSummary> getSummary();
};

class SampleProfileSummaryBuilder final : public ProfileSummaryBuilder {
public:
  SampleProfileSummaryBuilder(std::vector<uint32_t> Cutoffs)
      : ProfileSummaryBuilder(std::move(Cutoffs)) {}

  LLVM_ABI void addRecord(const sampleprof::FunctionSamples &FS,
                          bool isCallsiteSample = false);
  LLVM_ABI std::unique_ptr<ProfileSummary>
  computeSummaryForProfiles(const sampleprof::SampleProfileMap &Profiles);
  LLVM_ABI std::unique_ptr<ProfileSummary> getSummary();
};

/// This is called when a count is seen in the profile.
void ProfileSummaryBuilder::addCount(uint64_t Count) {
  TotalCount += Count;
  if (Count > MaxCount)
    MaxCount = Count;
  NumCounts++;
  CountFrequencies[Count]++;
}

} // end namespace llvm

#endif // LLVM_PROFILEDATA_PROFILECOMMON_H
