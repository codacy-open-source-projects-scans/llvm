; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt < %s -passes=sccp -S | FileCheck %s

define i32 @test1(i1 %C) {
; CHECK-LABEL: define i32 @test1(
; CHECK-SAME: i1 [[C:%.*]]) {
; CHECK-NEXT:    ret i32 0
;
  %X = select i1 %C, i32 0, i32 0
  ret i32 %X
}

define i32 @test2(i1 %C) {
; CHECK-LABEL: define i32 @test2(
; CHECK-SAME: i1 [[C:%.*]]) {
; CHECK-NEXT:    ret i32 0
;
  %X = select i1 %C, i32 0, i32 undef
  ret i32 %X
}

define i1 @f2(i32 %x, i1 %cmp) {
; CHECK-LABEL: define i1 @f2(
; CHECK-SAME: i32 [[X:%.*]], i1 [[CMP:%.*]]) {
; CHECK-NEXT:    [[SEL_1:%.*]] = select i1 [[CMP]], i32 [[X]], i32 10
; CHECK-NEXT:    [[C_1:%.*]] = icmp sgt i32 [[SEL_1]], 300
; CHECK-NEXT:    [[C_2:%.*]] = icmp sgt i32 [[SEL_1]], 100
; CHECK-NEXT:    [[C_3:%.*]] = icmp eq i32 [[SEL_1]], 50
; CHECK-NEXT:    [[C_4:%.*]] = icmp slt i32 [[SEL_1]], 9
; CHECK-NEXT:    [[RES_1:%.*]] = add i1 [[C_1]], [[C_2]]
; CHECK-NEXT:    [[RES_2:%.*]] = add i1 [[RES_1]], [[C_3]]
; CHECK-NEXT:    [[RES_3:%.*]] = add i1 [[RES_2]], [[C_4]]
; CHECK-NEXT:    ret i1 [[RES_3]]
;
  %sel.1 = select i1 %cmp, i32 %x, i32 10
  %c.1 = icmp sgt i32 %sel.1, 300
  %c.2 = icmp sgt i32 %sel.1, 100
  %c.3 = icmp eq i32 %sel.1, 50
  %c.4 = icmp slt i32 %sel.1, 9
  %res.1 = add i1 %c.1, %c.2
  %res.2 = add i1 %res.1, %c.3
  %res.3 = add i1 %res.2, %c.4
  ret i1 %res.3
}