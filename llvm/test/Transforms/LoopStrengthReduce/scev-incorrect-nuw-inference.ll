; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt < %s -loop-reduce -S | FileCheck %s
; REQUIRES: x86-registered-target

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128-ni:1-p2:32:8:8:32-ni:2"
target triple = "x86_64-unknown-linux-gnu"

; The returned value should be equal to
;     zext (%phi-1) to i64
; or simply 1209.
define noundef i64 @test() {
; CHECK-LABEL: define noundef i64 @test() {
; CHECK-NEXT:  bb2:
; CHECK-NEXT:    br label [[BB3:%.*]]
; CHECK:       bb3:
; CHECK-NEXT:    [[LSR_IV:%.*]] = phi i32 [ [[LSR_IV_NEXT:%.*]], [[BB10:%.*]] ], [ -1, [[BB2:%.*]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[LSR_IV]], 65536
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[TMP0]], 65535
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[AND]] to i64
; CHECK-NEXT:    [[ADD4:%.*]] = add nsw i64 [[ZEXT]], -128
; CHECK-NEXT:    [[ICMP5:%.*]] = icmp ult i64 [[ADD4]], -256
; CHECK-NEXT:    [[ICMP6:%.*]] = icmp ult i32 [[AND]], 128
; CHECK-NEXT:    [[OR:%.*]] = or i1 [[ICMP5]], [[ICMP6]]
; CHECK-NEXT:    br i1 [[OR]], label [[BB10]], label [[BB7:%.*]]
; CHECK:       bb7:
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[LSR_IV]], 1
; CHECK-NEXT:    call void @foo(i32 [[TMP1]])
; CHECK-NEXT:    unreachable
; CHECK:       bb10:
; CHECK-NEXT:    [[LSR_IV_NEXT]] = add nsw i32 [[LSR_IV]], 1
; CHECK-NEXT:    [[ICMP12:%.*]] = icmp ult i32 [[LSR_IV_NEXT]], 1210
; CHECK-NEXT:    br i1 [[ICMP12]], label [[BB3]], label [[BB13:%.*]]
; CHECK:       bb13:
; CHECK-NEXT:    ret i64 [[ZEXT]]
;
bb2:
  br label %bb3

bb3:                                              ; preds = %bb10, %bb2
  %phi = phi i32 [ 0, %bb2 ], [ %add11, %bb10 ]
  %add = add nuw nsw i32 %phi, 65535
  %and = and i32 %add, 65535
  %zext = zext i32 %and to i64
  %add4 = add nsw i64 %zext, -128
  %icmp5 = icmp ult i64 %add4, -256
  %icmp6 = icmp ult i32 %and, 128
  %or = or i1 %icmp5, %icmp6
  br i1 %or, label %bb10, label %bb7

bb7:                                              ; preds = %bb3
  call void @foo(i32 %phi)
  unreachable

bb10:                                             ; preds = %bb3
  %add11 = add nuw nsw i32 %phi, 1
  %icmp12 = icmp ult i32 %phi, 1210
  br i1 %icmp12, label %bb3, label %bb13

bb13:                                             ; preds = %bb10
  ret i64 %zext

  uselistorder i32 %phi, { 0, 3, 1, 2 }
}

declare void @foo(i32)