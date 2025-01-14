; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc < %s -mtriple=riscv32 -mattr=+v -verify-machineinstrs | FileCheck %s
; RUN: llc < %s -mtriple=riscv64 -mattr=+v -verify-machineinstrs | FileCheck %s

define <8 x i32> @concat_2xv4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: concat_2xv4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v10, v9
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 4
; CHECK-NEXT:    ret
  %ab = shufflevector <4 x i32> %a, <4 x i32> %b, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i32> %ab
}

define <8 x i32> @concat_4xv2i32(<2 x i32> %a, <2 x i32> %b, <2 x i32> %c, <2 x i32> %d) {
; CHECK-LABEL: concat_4xv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v12, v11
; CHECK-NEXT:    vmv1r.v v14, v9
; CHECK-NEXT:    vsetivli zero, 4, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v14, 2
; CHECK-NEXT:    vsetivli zero, 6, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 4
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vslideup.vi v8, v12, 6
; CHECK-NEXT:    ret
  %ab = shufflevector <2 x i32> %a, <2 x i32> %b, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %cd = shufflevector <2 x i32> %c, <2 x i32> %d, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %abcd = shufflevector <4 x i32> %ab, <4 x i32> %cd, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i32> %abcd
}

define <8 x i32> @concat_8xv1i32(<1 x i32> %a, <1 x i32> %b, <1 x i32> %c, <1 x i32> %d, <1 x i32> %e, <1 x i32> %f, <1 x i32> %g, <1 x i32> %h) {
; CHECK-LABEL: concat_8xv1i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v16, v15
; CHECK-NEXT:    vmv1r.v v18, v13
; CHECK-NEXT:    vmv1r.v v20, v11
; CHECK-NEXT:    vmv1r.v v22, v9
; CHECK-NEXT:    vsetivli zero, 2, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v22, 1
; CHECK-NEXT:    vsetivli zero, 3, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v10, 2
; CHECK-NEXT:    vsetivli zero, 4, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v20, 3
; CHECK-NEXT:    vsetivli zero, 5, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v12, 4
; CHECK-NEXT:    vsetivli zero, 6, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v18, 5
; CHECK-NEXT:    vsetivli zero, 7, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v14, 6
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vslideup.vi v8, v16, 7
; CHECK-NEXT:    ret
  %ab = shufflevector <1 x i32> %a, <1 x i32> %b, <2 x i32> <i32 0, i32 1>
  %cd = shufflevector <1 x i32> %c, <1 x i32> %d, <2 x i32> <i32 0, i32 1>
  %abcd = shufflevector <2 x i32> %ab, <2 x i32> %cd, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %ef = shufflevector <1 x i32> %e, <1 x i32> %f, <2 x i32> <i32 0, i32 1>
  %gh = shufflevector <1 x i32> %g, <1 x i32> %h, <2 x i32> <i32 0, i32 1>
  %efgh = shufflevector <2 x i32> %ef, <2 x i32> %gh, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %abcdefgh = shufflevector <4 x i32> %abcd, <4 x i32> %efgh, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i32> %abcdefgh
}

define <16 x i32> @concat_2xv8i32(<8 x i32> %a, <8 x i32> %b) {
; CHECK-LABEL: concat_2xv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv2r.v v12, v10
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vslideup.vi v8, v12, 8
; CHECK-NEXT:    ret
  %v = shufflevector <8 x i32> %a, <8 x i32> %b, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  ret <16 x i32> %v
}

define <16 x i32> @concat_4xv4i32(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c, <4 x i32> %d) {
; CHECK-LABEL: concat_4xv4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v12, v11
; CHECK-NEXT:    vmv1r.v v16, v10
; CHECK-NEXT:    vmv1r.v v20, v9
; CHECK-NEXT:    vsetivli zero, 8, e32, m4, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v20, 4
; CHECK-NEXT:    vsetivli zero, 12, e32, m4, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v16, 8
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vslideup.vi v8, v12, 12
; CHECK-NEXT:    ret
  %ab = shufflevector <4 x i32> %a, <4 x i32> %b, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %cd = shufflevector <4 x i32> %c, <4 x i32> %d, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %abcd = shufflevector <8 x i32> %ab, <8 x i32> %cd, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  ret <16 x i32> %abcd
}

define <16 x i32> @concat_8xv2i32(<2 x i32> %a, <2 x i32> %b, <2 x i32> %c, <2 x i32> %d, <2 x i32> %e, <2 x i32> %f, <2 x i32> %g, <2 x i32> %h) {
; CHECK-LABEL: concat_8xv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v16, v15
; CHECK-NEXT:    vmv1r.v v20, v14
; CHECK-NEXT:    vmv1r.v v24, v13
; CHECK-NEXT:    vmv1r.v v28, v11
; CHECK-NEXT:    vmv1r.v v0, v10
; CHECK-NEXT:    vmv1r.v v4, v9
; CHECK-NEXT:    vsetivli zero, 4, e32, m4, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v4, 2
; CHECK-NEXT:    vsetivli zero, 6, e32, m4, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v0, 4
; CHECK-NEXT:    vsetivli zero, 8, e32, m4, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v28, 6
; CHECK-NEXT:    vsetivli zero, 10, e32, m4, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v12, 8
; CHECK-NEXT:    vsetivli zero, 12, e32, m4, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v24, 10
; CHECK-NEXT:    vsetivli zero, 14, e32, m4, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v20, 12
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vslideup.vi v8, v16, 14
; CHECK-NEXT:    ret
  %ab = shufflevector <2 x i32> %a, <2 x i32> %b, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %cd = shufflevector <2 x i32> %c, <2 x i32> %d, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %abcd = shufflevector <4 x i32> %ab, <4 x i32> %cd, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %ef = shufflevector <2 x i32> %e, <2 x i32> %f, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %gh = shufflevector <2 x i32> %g, <2 x i32> %h, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %efgh = shufflevector <4 x i32> %ef, <4 x i32> %gh, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %abcdefgh = shufflevector <8 x i32> %abcd, <8 x i32> %efgh, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  ret <16 x i32> %abcdefgh
}

define <32 x i32> @concat_2xv16i32(<16 x i32> %a, <16 x i32> %b) {
; CHECK-LABEL: concat_2xv16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv4r.v v16, v12
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vslideup.vi v8, v16, 16
; CHECK-NEXT:    ret
  %ab = shufflevector <16 x i32> %a, <16 x i32> %b, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  ret <32 x i32> %ab
}

define <32 x i32> @concat_4xv8i32(<8 x i32> %a, <8 x i32> %b, <8 x i32> %c, <8 x i32> %d) {
; CHECK-LABEL: concat_4xv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv2r.v v16, v14
; CHECK-NEXT:    vmv2r.v v24, v12
; CHECK-NEXT:    vmv2r.v v0, v10
; CHECK-NEXT:    vsetivli zero, 16, e32, m8, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v0, 8
; CHECK-NEXT:    vsetivli zero, 24, e32, m8, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v24, 16
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vslideup.vi v8, v16, 24
; CHECK-NEXT:    ret
  %ab = shufflevector <8 x i32> %a, <8 x i32> %b, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %cd = shufflevector <8 x i32> %c, <8 x i32> %d, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %abcd = shufflevector <16 x i32> %ab, <16 x i32> %cd, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  ret <32 x i32> %abcd
}

define <32 x i32> @concat_8xv4i32(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c, <4 x i32> %d, <4 x i32> %e, <4 x i32> %f, <4 x i32> %g, <4 x i32> %h) {
; CHECK-LABEL: concat_8xv4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 5
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x20, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 32 * vlenb
; CHECK-NEXT:    vmv1r.v v16, v15
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    li a1, 0
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a1, a1, a0
; CHECK-NEXT:    slli a0, a0, 1
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v16, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vmv1r.v v16, v14
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v16, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vmv1r.v v16, v13
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v16, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vmv1r.v v16, v12
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vs8r.v v16, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vmv1r.v v0, v11
; CHECK-NEXT:    vmv1r.v v24, v10
; CHECK-NEXT:    vmv1r.v v16, v9
; CHECK-NEXT:    vsetivli zero, 8, e32, m8, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v16, 4
; CHECK-NEXT:    vsetivli zero, 12, e32, m8, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v24, 8
; CHECK-NEXT:    vsetivli zero, 16, e32, m8, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v0, 12
; CHECK-NEXT:    vsetivli zero, 20, e32, m8, tu, ma
; CHECK-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vslideup.vi v8, v16, 16
; CHECK-NEXT:    vsetivli zero, 24, e32, m8, tu, ma
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vslideup.vi v8, v16, 20
; CHECK-NEXT:    vsetivli zero, 28, e32, m8, tu, ma
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vslideup.vi v8, v16, 24
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    li a1, 0
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a1, a1, a0
; CHECK-NEXT:    slli a0, a0, 1
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vslideup.vi v8, v16, 28
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 5
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %ab = shufflevector <4 x i32> %a, <4 x i32> %b, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %cd = shufflevector <4 x i32> %c, <4 x i32> %d, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %abcd = shufflevector <8 x i32> %ab, <8 x i32> %cd, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %ef = shufflevector <4 x i32> %e, <4 x i32> %f, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %gh = shufflevector <4 x i32> %g, <4 x i32> %h, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %efgh = shufflevector <8 x i32> %ef, <8 x i32> %gh, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %abcdefgh = shufflevector <16 x i32> %abcd, <16 x i32> %efgh, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  ret <32 x i32> %abcdefgh
}
