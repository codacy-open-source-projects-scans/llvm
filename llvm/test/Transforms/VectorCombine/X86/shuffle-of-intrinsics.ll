; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=x86_64-- -mcpu=x86-64 -passes=vector-combine -S %s | FileCheck %s --check-prefixes=CHECK,SSE
; RUN: opt -mtriple=x86_64-- -mcpu=x86-64-v2 -passes=vector-combine -S %s | FileCheck %s --check-prefixes=CHECK,SSE
; RUN: opt -mtriple=x86_64-- -mcpu=x86-64-v3 -passes=vector-combine -S %s | FileCheck %s --check-prefixes=CHECK,AVX
; RUN: opt -mtriple=x86_64-- -mcpu=x86-64-v4 -passes=vector-combine -S %s | FileCheck %s --check-prefixes=CHECK,AVX

define <8 x i32> @test1(<4 x i32> %0, <4 x i32> %1) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <4 x i32> [[TMP0:%.*]], <4 x i32> [[TMP1:%.*]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[TMP3:%.*]] = call <8 x i32> @llvm.abs.v8i32(<8 x i32> [[TMP2]], i1 false)
; CHECK-NEXT:    ret <8 x i32> [[TMP3]]
;
entry:
  %2 = call <4 x i32> @llvm.abs.v4i32(<4 x i32> %0, i1 false)
  %3 = call <4 x i32> @llvm.abs.v4i32(<4 x i32> %1, i1 false)
  %4 = shufflevector <4 x i32> %2, <4 x i32> %3, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i32> %4
}

define <8 x i32> @test2(<4 x i32> %0, <4 x i32> %1) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i32> @llvm.abs.v4i32(<4 x i32> [[TMP0:%.*]], i1 true)
; CHECK-NEXT:    [[TMP3:%.*]] = call <4 x i32> @llvm.abs.v4i32(<4 x i32> [[TMP1:%.*]], i1 false)
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <4 x i32> [[TMP2]], <4 x i32> [[TMP3]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    ret <8 x i32> [[TMP4]]
;
entry:
  %2 = call <4 x i32> @llvm.abs.v4i32(<4 x i32> %0, i1 true)
  %3 = call <4 x i32> @llvm.abs.v4i32(<4 x i32> %1, i1 false)
  %4 = shufflevector <4 x i32> %2, <4 x i32> %3, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i32> %4
}

define <8 x i32> @test3(<4 x i32> %0, <4 x i32> %1, <4 x i32> %2, <4 x i32> %3) {
; SSE-LABEL: @test3(
; SSE-NEXT:  entry:
; SSE-NEXT:    [[TMP4:%.*]] = call <4 x i32> @llvm.smax.v4i32(<4 x i32> [[TMP0:%.*]], <4 x i32> [[TMP1:%.*]])
; SSE-NEXT:    [[TMP5:%.*]] = call <4 x i32> @llvm.smax.v4i32(<4 x i32> [[TMP2:%.*]], <4 x i32> [[TMP3:%.*]])
; SSE-NEXT:    [[TMP6:%.*]] = shufflevector <4 x i32> [[TMP4]], <4 x i32> [[TMP5]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; SSE-NEXT:    ret <8 x i32> [[TMP6]]
;
; AVX-LABEL: @test3(
; AVX-NEXT:  entry:
; AVX-NEXT:    [[TMP4:%.*]] = shufflevector <4 x i32> [[TMP0:%.*]], <4 x i32> [[TMP2:%.*]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; AVX-NEXT:    [[TMP5:%.*]] = shufflevector <4 x i32> [[TMP1:%.*]], <4 x i32> [[TMP3:%.*]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; AVX-NEXT:    [[TMP6:%.*]] = call <8 x i32> @llvm.smax.v8i32(<8 x i32> [[TMP4]], <8 x i32> [[TMP5]])
; AVX-NEXT:    ret <8 x i32> [[TMP6]]
;
entry:
  %4 = call <4 x i32> @llvm.smax.v4i32(<4 x i32> %0, <4 x i32> %1)
  %5 = call <4 x i32> @llvm.smax.v4i32(<4 x i32> %2, <4 x i32> %3)
  %6 = shufflevector <4 x i32> %4, <4 x i32> %5, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i32> %6
}

define <8 x i1> @test4(<4 x float> %0, <4 x float> %1) {
; SSE-LABEL: @test4(
; SSE-NEXT:  entry:
; SSE-NEXT:    [[TMP2:%.*]] = shufflevector <4 x float> [[TMP0:%.*]], <4 x float> [[TMP1:%.*]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; SSE-NEXT:    [[TMP3:%.*]] = call <8 x i1> @llvm.is.fpclass.v8f32(<8 x float> [[TMP2]], i32 0)
; SSE-NEXT:    ret <8 x i1> [[TMP3]]
;
; AVX-LABEL: @test4(
; AVX-NEXT:  entry:
; AVX-NEXT:    [[TMP2:%.*]] = call <4 x i1> @llvm.is.fpclass.v4f32(<4 x float> [[TMP0:%.*]], i32 0)
; AVX-NEXT:    [[TMP3:%.*]] = call <4 x i1> @llvm.is.fpclass.v4f32(<4 x float> [[TMP1:%.*]], i32 0)
; AVX-NEXT:    [[TMP4:%.*]] = shufflevector <4 x i1> [[TMP2]], <4 x i1> [[TMP3]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; AVX-NEXT:    ret <8 x i1> [[TMP4]]
;
entry:
  %2 = call <4 x i1> @llvm.is.fpclass.v4f32(<4 x float> %0, i32 0)
  %3 = call <4 x i1> @llvm.is.fpclass.v4f32(<4 x float> %1, i32 0)
  %4 = shufflevector <4 x i1> %2, <4 x i1> %3, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i1> %4
}

define <8 x float> @test5(<4 x float> %0, i32 %1, <4 x float> %2, <4 x i32> %3) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP4:%.*]] = call <4 x float> @llvm.powi.v4f32.i32(<4 x float> [[TMP0:%.*]], i32 [[TMP1:%.*]])
; CHECK-NEXT:    [[TMP5:%.*]] = call <4 x float> @llvm.powi.v4f32.v4i32(<4 x float> [[TMP2:%.*]], <4 x i32> [[TMP3:%.*]])
; CHECK-NEXT:    [[TMP6:%.*]] = shufflevector <4 x float> [[TMP4]], <4 x float> [[TMP5]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    ret <8 x float> [[TMP6]]
;
entry:
  %4 = call <4 x float> @llvm.powi.v4f32.i32(<4 x float> %0, i32 %1)
  %5 = call <4 x float> @llvm.powi.v4f32.v4i32(<4 x float> %2, <4 x i32> %3)
  %6 = shufflevector <4 x float> %4, <4 x float> %5, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x float> %6
}

declare <4 x i32> @llvm.abs.v4i32(<4 x i32>, i1)
declare <4 x i32> @llvm.smax.v4i32(<4 x i32>, <4 x i32>)
declare <4 x i1> @llvm.is.fpclass.v4f32(<4 x float>, i32)
declare <4 x float> @llvm.powi.v4f32.i32(<4 x float>, i32)
declare <4 x float> @llvm.powi.v4f32.v4i32(<4 x float>, <4 x i32>)