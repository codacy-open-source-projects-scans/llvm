; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S -scalarizer -dxil-op-lower -mtriple=dxil-pc-shadermodel6.3-library %s | FileCheck %s

; Make sure dxil operation function calls for rsqrt are generated for float and half.

; CHECK-LABEL: rsqrt_float
define noundef float @rsqrt_float(float noundef %a) {
; CHECK-SAME: float noundef [[A:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[DX_RSQRT1:%.*]] = call float @dx.op.unary.f32(i32 25, float [[A]])
; CHECK-NEXT:    ret float [[DX_RSQRT1]]
;
entry:
  %dx.rsqrt = call float @llvm.dx.rsqrt.f32(float %a)
  ret float %dx.rsqrt
}

; CHECK-LABEL: rsqrt_half
define noundef half @rsqrt_half(half noundef %a) {
; CHECK-SAME: half noundef [[A:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[DX_RSQRT1:%.*]] = call half @dx.op.unary.f16(i32 25, half [[A]])
; CHECK-NEXT:    ret half [[DX_RSQRT1]]
;
entry:
  %dx.rsqrt = call half @llvm.dx.rsqrt.f16(half %a)
  ret half %dx.rsqrt
}

define noundef <4 x float> @rsqrt_float4(<4 x float> noundef %a) #0 {
; CHECK-LABEL: define noundef <4 x float> @rsqrt_float4(
; CHECK-SAME: <4 x float> noundef [[A:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[A_I0:%.*]] = extractelement <4 x float> [[A]], i64 0
; CHECK-NEXT:    [[DOTI04:%.*]] = call float @dx.op.unary.f32(i32 25, float [[A_I0]])
; CHECK-NEXT:    [[A_I1:%.*]] = extractelement <4 x float> [[A]], i64 1
; CHECK-NEXT:    [[DOTI13:%.*]] = call float @dx.op.unary.f32(i32 25, float [[A_I1]])
; CHECK-NEXT:    [[A_I2:%.*]] = extractelement <4 x float> [[A]], i64 2
; CHECK-NEXT:    [[DOTI22:%.*]] = call float @dx.op.unary.f32(i32 25, float [[A_I2]])
; CHECK-NEXT:    [[A_I3:%.*]] = extractelement <4 x float> [[A]], i64 3
; CHECK-NEXT:    [[DOTI31:%.*]] = call float @dx.op.unary.f32(i32 25, float [[A_I3]])
; CHECK-NEXT:    [[DOTUPTO0:%.*]] = insertelement <4 x float> poison, float [[DOTI04]], i64 0
; CHECK-NEXT:    [[DOTUPTO1:%.*]] = insertelement <4 x float> [[DOTUPTO0]], float [[DOTI13]], i64 1
; CHECK-NEXT:    [[DOTUPTO2:%.*]] = insertelement <4 x float> [[DOTUPTO1]], float [[DOTI22]], i64 2
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <4 x float> [[DOTUPTO2]], float [[DOTI31]], i64 3
; CHECK-NEXT:    ret <4 x float> [[TMP0]]
;
entry:
  %2 = call <4 x float> @llvm.dx.rsqrt.v4f32(<4 x float> %a)
  ret <4 x float> %2
}


declare half @llvm.dx.rsqrt.f16(half)
declare float @llvm.dx.rsqrt.f32(float)
declare <4 x float> @llvm.dx.rsqrt.v4f32(<4 x float>)