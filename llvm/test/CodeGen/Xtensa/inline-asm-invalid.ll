; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: not llc --mtriple=xtensa < %s 2>&1 | FileCheck %s

define void @constraint_f() nounwind {
; CHECK: error: unknown asm constraint 'f'
  tail call void asm "addi a1, a1, $0", "f"(i32 1)
  ret void
}

define i32 @register_a100(i32 %a) nounwind {
; CHECK: error: couldn't allocate input reg for constraint '{$a100}'
  %1 = tail call i32 asm "addi $0, $1, 1", "=r,{$a100}"(i32 %a)
  ret i32 %1
}