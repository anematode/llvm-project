; RUN: not llc -mtriple=sparc64-linux-gnu -o - %s 2>&1 | FileCheck %s --check-prefixes=CHECK-RESERVED-L0

;; Ensure explicit register references for non-reserved registers
;; are caught properly.

; CHECK-RESERVED-L0: error: <unknown>:0:0: invalid register "l0" for llvm.write_register
define void @set_reg(i32 zeroext %x) {
entry:
  tail call void @llvm.write_register.i32(metadata !0, i32 %x)
  ret void
}

declare void @llvm.write_register.i32(metadata, i32)
!0 = !{!"l0"}
