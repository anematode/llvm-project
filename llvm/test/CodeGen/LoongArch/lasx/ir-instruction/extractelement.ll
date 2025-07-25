; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc --mtriple=loongarch64 --mattr=+lasx < %s | FileCheck %s

define void @extract_32xi8(ptr %src, ptr %dst) nounwind {
; CHECK-LABEL: extract_32xi8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a0, 0
; CHECK-NEXT:    xvstelm.b $xr0, $a1, 0, 1
; CHECK-NEXT:    ret
  %v = load volatile <32 x i8>, ptr %src
  %e = extractelement <32 x i8> %v, i32 1
  store i8 %e, ptr %dst
  ret void
}

define void @extract_16xi16(ptr %src, ptr %dst) nounwind {
; CHECK-LABEL: extract_16xi16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a0, 0
; CHECK-NEXT:    xvstelm.h $xr0, $a1, 0, 1
; CHECK-NEXT:    ret
  %v = load volatile <16 x i16>, ptr %src
  %e = extractelement <16 x i16> %v, i32 1
  store i16 %e, ptr %dst
  ret void
}

define void @extract_8xi32(ptr %src, ptr %dst) nounwind {
; CHECK-LABEL: extract_8xi32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a0, 0
; CHECK-NEXT:    xvstelm.w $xr0, $a1, 0, 1
; CHECK-NEXT:    ret
  %v = load volatile <8 x i32>, ptr %src
  %e = extractelement <8 x i32> %v, i32 1
  store i32 %e, ptr %dst
  ret void
}

define void @extract_4xi64(ptr %src, ptr %dst) nounwind {
; CHECK-LABEL: extract_4xi64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a0, 0
; CHECK-NEXT:    xvstelm.d $xr0, $a1, 0, 1
; CHECK-NEXT:    ret
  %v = load volatile <4 x i64>, ptr %src
  %e = extractelement <4 x i64> %v, i32 1
  store i64 %e, ptr %dst
  ret void
}

define void @extract_8xfloat(ptr %src, ptr %dst) nounwind {
; CHECK-LABEL: extract_8xfloat:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a0, 0
; CHECK-NEXT:    xvstelm.w $xr0, $a1, 0, 7
; CHECK-NEXT:    ret
  %v = load volatile <8 x float>, ptr %src
  %e = extractelement <8 x float> %v, i32 7
  store float %e, ptr %dst
  ret void
}

define void @extract_4xdouble(ptr %src, ptr %dst) nounwind {
; CHECK-LABEL: extract_4xdouble:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a0, 0
; CHECK-NEXT:    xvstelm.d $xr0, $a1, 0, 3
; CHECK-NEXT:    ret
  %v = load volatile <4 x double>, ptr %src
  %e = extractelement <4 x double> %v, i32 3
  store double %e, ptr %dst
  ret void
}

define void @extract_32xi8_idx(ptr %src, ptr %dst, i32 %idx) nounwind {
; CHECK-LABEL: extract_32xi8_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi.d $sp, $sp, -96
; CHECK-NEXT:    st.d $ra, $sp, 88 # 8-byte Folded Spill
; CHECK-NEXT:    st.d $fp, $sp, 80 # 8-byte Folded Spill
; CHECK-NEXT:    addi.d $fp, $sp, 96
; CHECK-NEXT:    bstrins.d $sp, $zero, 4, 0
; CHECK-NEXT:    xvld $xr0, $a0, 0
; CHECK-NEXT:    xvst $xr0, $sp, 32
; CHECK-NEXT:    addi.d $a0, $sp, 32
; CHECK-NEXT:    bstrins.d $a0, $a2, 4, 0
; CHECK-NEXT:    ld.b $a0, $a0, 0
; CHECK-NEXT:    st.b $a0, $a1, 0
; CHECK-NEXT:    addi.d $sp, $fp, -96
; CHECK-NEXT:    ld.d $fp, $sp, 80 # 8-byte Folded Reload
; CHECK-NEXT:    ld.d $ra, $sp, 88 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 96
; CHECK-NEXT:    ret
  %v = load volatile <32 x i8>, ptr %src
  %e = extractelement <32 x i8> %v, i32 %idx
  store i8 %e, ptr %dst
  ret void
}

define void @extract_16xi16_idx(ptr %src, ptr %dst, i32 %idx) nounwind {
; CHECK-LABEL: extract_16xi16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi.d $sp, $sp, -96
; CHECK-NEXT:    st.d $ra, $sp, 88 # 8-byte Folded Spill
; CHECK-NEXT:    st.d $fp, $sp, 80 # 8-byte Folded Spill
; CHECK-NEXT:    addi.d $fp, $sp, 96
; CHECK-NEXT:    bstrins.d $sp, $zero, 4, 0
; CHECK-NEXT:    xvld $xr0, $a0, 0
; CHECK-NEXT:    xvst $xr0, $sp, 32
; CHECK-NEXT:    addi.d $a0, $sp, 32
; CHECK-NEXT:    bstrins.d $a0, $a2, 4, 1
; CHECK-NEXT:    ld.h $a0, $a0, 0
; CHECK-NEXT:    st.h $a0, $a1, 0
; CHECK-NEXT:    addi.d $sp, $fp, -96
; CHECK-NEXT:    ld.d $fp, $sp, 80 # 8-byte Folded Reload
; CHECK-NEXT:    ld.d $ra, $sp, 88 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 96
; CHECK-NEXT:    ret
  %v = load volatile <16 x i16>, ptr %src
  %e = extractelement <16 x i16> %v, i32 %idx
  store i16 %e, ptr %dst
  ret void
}

define void @extract_8xi32_idx(ptr %src, ptr %dst, i32 %idx) nounwind {
; CHECK-LABEL: extract_8xi32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi.d $sp, $sp, -96
; CHECK-NEXT:    st.d $ra, $sp, 88 # 8-byte Folded Spill
; CHECK-NEXT:    st.d $fp, $sp, 80 # 8-byte Folded Spill
; CHECK-NEXT:    addi.d $fp, $sp, 96
; CHECK-NEXT:    bstrins.d $sp, $zero, 4, 0
; CHECK-NEXT:    xvld $xr0, $a0, 0
; CHECK-NEXT:    xvst $xr0, $sp, 32
; CHECK-NEXT:    addi.d $a0, $sp, 32
; CHECK-NEXT:    bstrins.d $a0, $a2, 4, 2
; CHECK-NEXT:    ld.w $a0, $a0, 0
; CHECK-NEXT:    st.w $a0, $a1, 0
; CHECK-NEXT:    addi.d $sp, $fp, -96
; CHECK-NEXT:    ld.d $fp, $sp, 80 # 8-byte Folded Reload
; CHECK-NEXT:    ld.d $ra, $sp, 88 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 96
; CHECK-NEXT:    ret
  %v = load volatile <8 x i32>, ptr %src
  %e = extractelement <8 x i32> %v, i32 %idx
  store i32 %e, ptr %dst
  ret void
}

define void @extract_4xi64_idx(ptr %src, ptr %dst, i32 %idx) nounwind {
; CHECK-LABEL: extract_4xi64_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi.d $sp, $sp, -96
; CHECK-NEXT:    st.d $ra, $sp, 88 # 8-byte Folded Spill
; CHECK-NEXT:    st.d $fp, $sp, 80 # 8-byte Folded Spill
; CHECK-NEXT:    addi.d $fp, $sp, 96
; CHECK-NEXT:    bstrins.d $sp, $zero, 4, 0
; CHECK-NEXT:    xvld $xr0, $a0, 0
; CHECK-NEXT:    xvst $xr0, $sp, 32
; CHECK-NEXT:    addi.d $a0, $sp, 32
; CHECK-NEXT:    bstrins.d $a0, $a2, 4, 3
; CHECK-NEXT:    ld.d $a0, $a0, 0
; CHECK-NEXT:    st.d $a0, $a1, 0
; CHECK-NEXT:    addi.d $sp, $fp, -96
; CHECK-NEXT:    ld.d $fp, $sp, 80 # 8-byte Folded Reload
; CHECK-NEXT:    ld.d $ra, $sp, 88 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 96
; CHECK-NEXT:    ret
  %v = load volatile <4 x i64>, ptr %src
  %e = extractelement <4 x i64> %v, i32 %idx
  store i64 %e, ptr %dst
  ret void
}

define void @extract_8xfloat_idx(ptr %src, ptr %dst, i32 %idx) nounwind {
; CHECK-LABEL: extract_8xfloat_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi.d $sp, $sp, -96
; CHECK-NEXT:    st.d $ra, $sp, 88 # 8-byte Folded Spill
; CHECK-NEXT:    st.d $fp, $sp, 80 # 8-byte Folded Spill
; CHECK-NEXT:    addi.d $fp, $sp, 96
; CHECK-NEXT:    bstrins.d $sp, $zero, 4, 0
; CHECK-NEXT:    xvld $xr0, $a0, 0
; CHECK-NEXT:    xvst $xr0, $sp, 32
; CHECK-NEXT:    addi.d $a0, $sp, 32
; CHECK-NEXT:    bstrins.d $a0, $a2, 4, 2
; CHECK-NEXT:    fld.s $fa0, $a0, 0
; CHECK-NEXT:    fst.s $fa0, $a1, 0
; CHECK-NEXT:    addi.d $sp, $fp, -96
; CHECK-NEXT:    ld.d $fp, $sp, 80 # 8-byte Folded Reload
; CHECK-NEXT:    ld.d $ra, $sp, 88 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 96
; CHECK-NEXT:    ret
  %v = load volatile <8 x float>, ptr %src
  %e = extractelement <8 x float> %v, i32 %idx
  store float %e, ptr %dst
  ret void
}

define void @extract_4xdouble_idx(ptr %src, ptr %dst, i32 %idx) nounwind {
; CHECK-LABEL: extract_4xdouble_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi.d $sp, $sp, -96
; CHECK-NEXT:    st.d $ra, $sp, 88 # 8-byte Folded Spill
; CHECK-NEXT:    st.d $fp, $sp, 80 # 8-byte Folded Spill
; CHECK-NEXT:    addi.d $fp, $sp, 96
; CHECK-NEXT:    bstrins.d $sp, $zero, 4, 0
; CHECK-NEXT:    xvld $xr0, $a0, 0
; CHECK-NEXT:    xvst $xr0, $sp, 32
; CHECK-NEXT:    addi.d $a0, $sp, 32
; CHECK-NEXT:    bstrins.d $a0, $a2, 4, 3
; CHECK-NEXT:    fld.d $fa0, $a0, 0
; CHECK-NEXT:    fst.d $fa0, $a1, 0
; CHECK-NEXT:    addi.d $sp, $fp, -96
; CHECK-NEXT:    ld.d $fp, $sp, 80 # 8-byte Folded Reload
; CHECK-NEXT:    ld.d $ra, $sp, 88 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 96
; CHECK-NEXT:    ret
  %v = load volatile <4 x double>, ptr %src
  %e = extractelement <4 x double> %v, i32 %idx
  store double %e, ptr %dst
  ret void
}

define void @eliminate_frame_index(<8 x i32> %a) nounwind {
; CHECK-LABEL: eliminate_frame_index:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi.d $sp, $sp, -1040
; CHECK-NEXT:    addi.d $a0, $sp, 524
; CHECK-NEXT:    xvstelm.w $xr0, $a0, 0, 1
; CHECK-NEXT:    addi.d $sp, $sp, 1040
; CHECK-NEXT:    ret
  %1 = alloca [32 x [8 x i32]]
  %2 = getelementptr i8, ptr %1, i64 508
  %b = extractelement <8 x i32> %a, i64 1
  store i32 %b, ptr %2
  ret void
}
