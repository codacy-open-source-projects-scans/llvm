; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; This testcase comes from this C fragment:
;
; void test(unsigned Num, int *Array) {
;  unsigned i, j, k;
;
;  for (i = 0; i != Num; ++i)
;    for (j = 0; j != Num; ++j)
;      for (k = 0; k != Num; ++k)
;        printf("%d\n", i+k+j);    /* Reassociate to (i+j)+k */
;}
;
; In this case, we want to reassociate the specified expr so that i+j can be
; hoisted out of the inner most loop.
;
; RUN: opt < %s -passes=reassociate -S | FileCheck %s
; END.
@.LC0 = internal global [4 x i8] c"%d\0A\00"		; <ptr> [#uses=1]

declare i32 @printf(ptr, ...)

; Check that (i+j) has been reassociated (i=reg115, j=reg116)
define void @test(i32 %Num, ptr %Array) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  bb0:
; CHECK-NEXT:    [[COND221:%.*]] = icmp eq i32 0, [[NUM:%.*]]
; CHECK-NEXT:    br i1 [[COND221]], label [[BB7:%.*]], label [[BB2:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    [[REG115:%.*]] = phi i32 [ [[REG120:%.*]], [[BB6:%.*]] ], [ 0, [[BB0:%.*]] ]
; CHECK-NEXT:    br i1 [[COND221]], label [[BB6]], label [[BB3:%.*]]
; CHECK:       bb3:
; CHECK-NEXT:    [[REG116:%.*]] = phi i32 [ [[REG119:%.*]], [[BB5:%.*]] ], [ 0, [[BB2]] ]
; CHECK-NEXT:    br i1 [[COND221]], label [[BB5]], label [[BB4:%.*]]
; CHECK:       bb4:
; CHECK-NEXT:    [[REG117:%.*]] = phi i32 [ [[REG118:%.*]], [[BB4]] ], [ 0, [[BB3]] ]
; CHECK-NEXT:    [[REG113:%.*]] = add i32 [[REG116]], [[REG115]]
; CHECK-NEXT:    [[REG114:%.*]] = add i32 [[REG113]], [[REG117]]
; CHECK-NEXT:    [[CAST227:%.*]] = getelementptr [4 x i8], ptr @.LC0, i64 0, i64 0
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 (ptr, ...) @printf(ptr [[CAST227]], i32 [[REG114]])
; CHECK-NEXT:    [[REG118]] = add i32 [[REG117]], 1
; CHECK-NEXT:    [[COND224:%.*]] = icmp ne i32 [[REG118]], [[NUM]]
; CHECK-NEXT:    br i1 [[COND224]], label [[BB4]], label [[BB5]]
; CHECK:       bb5:
; CHECK-NEXT:    [[REG119]] = add i32 [[REG116]], 1
; CHECK-NEXT:    [[COND225:%.*]] = icmp ne i32 [[REG119]], [[NUM]]
; CHECK-NEXT:    br i1 [[COND225]], label [[BB3]], label [[BB6]]
; CHECK:       bb6:
; CHECK-NEXT:    [[REG120]] = add i32 [[REG115]], 1
; CHECK-NEXT:    [[COND226:%.*]] = icmp ne i32 [[REG120]], [[NUM]]
; CHECK-NEXT:    br i1 [[COND226]], label [[BB2]], label [[BB7]]
; CHECK:       bb7:
; CHECK-NEXT:    ret void
;
bb0:
  %cond221 = icmp eq i32 0, %Num		; <i1> [#uses=3]
  br i1 %cond221, label %bb7, label %bb2
bb2:		; preds = %bb6, %bb0
  %reg115 = phi i32 [ %reg120, %bb6 ], [ 0, %bb0 ]		; <i32> [#uses=2]
  br i1 %cond221, label %bb6, label %bb3
bb3:		; preds = %bb5, %bb2
  %reg116 = phi i32 [ %reg119, %bb5 ], [ 0, %bb2 ]		; <i32> [#uses=2]
  br i1 %cond221, label %bb5, label %bb4
bb4:		; preds = %bb4, %bb3
  %reg117 = phi i32 [ %reg118, %bb4 ], [ 0, %bb3 ]		; <i32> [#uses=2]
  %reg113 = add i32 %reg115, %reg117		; <i32> [#uses=1]
  %reg114 = add i32 %reg113, %reg116		; <i32> [#uses=1]
  %cast227 = getelementptr [4 x i8], ptr @.LC0, i64 0, i64 0		; <ptr> [#uses=1]
  call i32 (ptr, ...) @printf( ptr %cast227, i32 %reg114 )		; <i32>:0 [#uses=0]
  %reg118 = add i32 %reg117, 1		; <i32> [#uses=2]
  %cond224 = icmp ne i32 %reg118, %Num		; <i1> [#uses=1]
  br i1 %cond224, label %bb4, label %bb5
bb5:		; preds = %bb4, %bb3
  %reg119 = add i32 %reg116, 1		; <i32> [#uses=2]
  %cond225 = icmp ne i32 %reg119, %Num		; <i1> [#uses=1]
  br i1 %cond225, label %bb3, label %bb6
bb6:		; preds = %bb5, %bb2
  %reg120 = add i32 %reg115, 1		; <i32> [#uses=2]
  %cond226 = icmp ne i32 %reg120, %Num		; <i1> [#uses=1]
  br i1 %cond226, label %bb2, label %bb7
bb7:		; preds = %bb6, %bb0
  ret void
}