; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5

; RUN: opt -S --passes=slp-vectorizer < %s | FileCheck %s

define void @test(i8 %0, i8 %1) {
; CHECK-LABEL: define void @test(
; CHECK-SAME: i8 [[TMP0:%.*]], i8 [[TMP1:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[L:%.*]] = load <4 x i8>, ptr getelementptr (i8, ptr null, i32 8), align 1
; CHECK-NEXT:    [[LI15:%.*]] = extractelement <4 x i8> [[L]], i64 15
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <4 x i8> poison, i8 [[TMP0]], i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <4 x i8> [[TMP2]], i8 [[TMP1]], i32 1
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <4 x i8> [[TMP3]], i8 [[LI15]], i32 3
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <4 x i8> [[TMP4]], <4 x i8> poison, <4 x i32> <i32 0, i32 1, i32 0, i32 3>
; CHECK-NEXT:    [[TMP6:%.*]] = icmp ne <4 x i8> [[TMP5]], zeroinitializer
; CHECK-NEXT:    ret void
;
entry:
  %l = load <4 x i8>, ptr getelementptr (i8, ptr null, i32 8), align 1
  %li15 = extractelement <4 x i8> %l, i64 15
  %2 = icmp ne i8 %0, 0
  %3 = icmp ne i8 %1, 0
  %4 = icmp ne i8 %0, 0
  %.i15 = icmp ne i8 %li15, 0

  %i0244 = insertelement <4 x i1> zeroinitializer, i1 %2, i64 0
  %i1245 = insertelement <4 x i1> %i0244, i1 %3, i64 1
  %i2246 = insertelement <4 x i1> %i1245, i1 %4, i64 2
  %14 = insertelement <4 x i1> %i2246, i1 %.i15, i64 3
  ret void
}