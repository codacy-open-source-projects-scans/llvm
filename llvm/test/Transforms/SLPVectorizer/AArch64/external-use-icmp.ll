; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S --passes=slp-vectorizer -mtriple=aarch64 -slp-threshold=-20 -slp-vectorize-hor=0 < %s | FileCheck %s

define i16 @foo(i16 %in1, i16 %in2) {
; CHECK-LABEL: define i16 @foo(
; CHECK-SAME: i16 [[IN1:%.*]], i16 [[IN2:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <2 x i16> poison, i16 [[IN1]], i32 0
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <2 x i16> [[TMP0]], <2 x i16> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP4:%.*]] = zext <2 x i16> [[TMP1]] to <2 x i64>
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <2 x i16> poison, i16 [[IN2]], i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <2 x i16> [[TMP2]], <2 x i16> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP5:%.*]] = zext <2 x i16> [[TMP3]] to <2 x i64>
; CHECK-NEXT:    [[TMP9:%.*]] = mul nuw nsw <2 x i64> [[TMP5]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = and <2 x i64> [[TMP9]], <i64 65535, i64 65535>
; CHECK-NEXT:    [[TMP7:%.*]] = icmp ne <2 x i64> [[TMP6]], <i64 65533, i64 65533>
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <2 x i1> [[TMP7]], i32 1
; CHECK-NEXT:    [[ZEXT3_1:%.*]] = zext i1 [[TMP8]] to i16
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <2 x i64> [[TMP9]], i32 1
; CHECK-NEXT:    [[CMP2_1:%.*]] = icmp ne i64 [[TMP10]], 196605
; CHECK-NEXT:    [[ZEXT4_1:%.*]] = zext i1 [[CMP2_1]] to i16
; CHECK-NEXT:    [[ADD1:%.*]] = add nuw nsw i16 [[ZEXT3_1]], [[ZEXT4_1]]
; CHECK-NEXT:    [[TMP11:%.*]] = extractelement <2 x i1> [[TMP7]], i32 0
; CHECK-NEXT:    [[ZEXT3_2:%.*]] = zext i1 [[TMP11]] to i16
; CHECK-NEXT:    [[TMP13:%.*]] = extractelement <2 x i64> [[TMP9]], i32 0
; CHECK-NEXT:    [[CMP2_2:%.*]] = icmp ne i64 [[TMP13]], 196605
; CHECK-NEXT:    [[ZEXT4_2:%.*]] = zext i1 [[CMP2_2]] to i16
; CHECK-NEXT:    [[ADD2:%.*]] = add nuw nsw i16 [[ADD1]], [[ZEXT4_2]]
; CHECK-NEXT:    [[ADD3:%.*]] = add nuw nsw i16 [[ADD2]], [[ZEXT3_2]]
; CHECK-NEXT:    ret i16 [[ADD3]]
;
entry:
  %zext1_1 = zext i16 %in1 to i64
  %zext2_1 = zext i16 %in2 to i64
  %mul1 = mul nuw nsw i64 %zext2_1, %zext1_1
  %and1 = and i64 %mul1, 65535
  %cmp1_1 = icmp ne i64 %and1, 65533
  %zext3_1 = zext i1 %cmp1_1 to i16
  %cmp2_1 = icmp ne i64 %mul1, 196605
  %zext4_1 = zext i1 %cmp2_1 to i16
  %add1 = add nuw nsw i16 %zext3_1, %zext4_1
  %zext1_2 = zext i16 %in1 to i64
  %zext2_2 = zext i16 %in2 to i64
  %mul2 = mul nuw nsw i64 %zext2_2, %zext1_2
  %and2 = and i64 %mul2, 65535
  %cmp1_2 = icmp ne i64 %and2, 65533
  %zext3_2 = zext i1 %cmp1_2 to i16
  %cmp2_2 = icmp ne i64 %mul2, 196605
  %zext4_2 = zext i1 %cmp2_2 to i16
  %add2 = add nuw nsw i16 %add1, %zext4_2
  %add3 = add nuw nsw i16 %add2, %zext3_2
  ret i16 %add3
}

