; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -lowerswitch -fix-irreducible --verify-loop-info -S | FileCheck %s
; RUN: opt < %s -passes='lower-switch,fix-irreducible,verify<loops>' -S | FileCheck %s
; RUN: opt < %s -passes='lower-switch,verify<loops>,fix-irreducible,verify<loops>' -S | FileCheck %s

define void @loop_1(i32 %Value, i1 %PredEntry, i1 %PredD) {
; CHECK-LABEL: @loop_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PREDENTRY_INV:%.*]] = xor i1 [[PREDENTRY:%.*]], true
; CHECK-NEXT:    br label [[IRR_GUARD:%.*]]
; CHECK:       A:
; CHECK-NEXT:    br label [[IRR_GUARD]]
; CHECK:       B:
; CHECK-NEXT:    br label [[NODEBLOCK:%.*]]
; CHECK:       NodeBlock:
; CHECK-NEXT:    [[PIVOT:%.*]] = icmp slt i32 [[VALUE:%.*]], 1
; CHECK-NEXT:    br i1 [[PIVOT]], label [[LEAFBLOCK:%.*]], label [[LEAFBLOCK1:%.*]]
; CHECK:       LeafBlock1:
; CHECK-NEXT:    [[SWITCHLEAF2:%.*]] = icmp eq i32 [[VALUE]], 1
; CHECK-NEXT:    br i1 [[SWITCHLEAF2]], label [[IRR_GUARD]], label [[EXIT:%.*]]
; CHECK:       LeafBlock:
; CHECK-NEXT:    [[SWITCHLEAF:%.*]] = icmp eq i32 [[VALUE]], 0
; CHECK-NEXT:    br i1 [[SWITCHLEAF]], label [[A:%.*]], label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
; CHECK:       irr.guard:
; CHECK-NEXT:    [[GUARD_B:%.*]] = phi i1 [ true, [[LEAFBLOCK1]] ], [ true, [[A]] ], [ [[PREDENTRY_INV]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    br i1 [[GUARD_B]], label [[B:%.*]], label [[A]]
;
entry:
  br i1 %PredEntry, label %A, label %B

A:
  br label %B

B:
  switch i32 %Value, label %exit [
  i32 0, label %A
  i32 1, label %B
  ]

exit:
  ret void
}