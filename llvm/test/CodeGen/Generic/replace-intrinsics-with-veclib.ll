; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes
; RUN: opt -vector-library=SVML -replace-with-veclib -S < %s | FileCheck %s  --check-prefixes=COMMON,SVML
; RUN: opt -vector-library=AMDLIBM -replace-with-veclib -S < %s | FileCheck %s  --check-prefixes=COMMON,AMDLIBM
; RUN: opt -vector-library=LIBMVEC-X86 -replace-with-veclib -S < %s | FileCheck %s  --check-prefixes=COMMON,LIBMVEC-X86
; RUN: opt -vector-library=MASSV -replace-with-veclib -S < %s | FileCheck %s  --check-prefixes=COMMON,MASSV
; RUN: opt -vector-library=Accelerate -replace-with-veclib -S < %s | FileCheck %s  --check-prefixes=COMMON,ACCELERATE

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define <4 x double> @exp_v4(<4 x double> %in) {
; SVML-LABEL: define {{[^@]+}}@exp_v4
; SVML-SAME: (<4 x double> [[IN:%.*]]) {
; SVML-NEXT:    [[TMP1:%.*]] = call <4 x double> @__svml_exp4(<4 x double> [[IN]])
; SVML-NEXT:    ret <4 x double> [[TMP1]]
;
; AMDLIBM-LABEL: define {{[^@]+}}@exp_v4
; AMDLIBM-SAME: (<4 x double> [[IN:%.*]]) {
; AMDLIBM-NEXT:    [[TMP1:%.*]] = call <4 x double> @amd_vrd4_exp(<4 x double> [[IN]])
; AMDLIBM-NEXT:    ret <4 x double> [[TMP1]]
;
; LIBMVEC-X86-LABEL: define {{[^@]+}}@exp_v4
; LIBMVEC-X86-SAME: (<4 x double> [[IN:%.*]]) {
; LIBMVEC-X86-NEXT:    [[TMP1:%.*]] = call <4 x double> @_ZGVdN4v_exp(<4 x double> [[IN]])
; LIBMVEC-X86-NEXT:    ret <4 x double> [[TMP1]]
;
; MASSV-LABEL: define {{[^@]+}}@exp_v4
; MASSV-SAME: (<4 x double> [[IN:%.*]]) {
; MASSV-NEXT:    [[CALL:%.*]] = call <4 x double> @llvm.exp.v4f64(<4 x double> [[IN]])
; MASSV-NEXT:    ret <4 x double> [[CALL]]
;
; ACCELERATE-LABEL: define {{[^@]+}}@exp_v4
; ACCELERATE-SAME: (<4 x double> [[IN:%.*]]) {
; ACCELERATE-NEXT:    [[CALL:%.*]] = call <4 x double> @llvm.exp.v4f64(<4 x double> [[IN]])
; ACCELERATE-NEXT:    ret <4 x double> [[CALL]]
;
  %call = call <4 x double> @llvm.exp.v4f64(<4 x double> %in)
  ret <4 x double> %call
}

declare <4 x double> @llvm.exp.v4f64(<4 x double>) #0

define <4 x float> @exp_f32(<4 x float> %in) {
; SVML-LABEL: define {{[^@]+}}@exp_f32
; SVML-SAME: (<4 x float> [[IN:%.*]]) {
; SVML-NEXT:    [[TMP1:%.*]] = call <4 x float> @__svml_expf4(<4 x float> [[IN]])
; SVML-NEXT:    ret <4 x float> [[TMP1]]
;
; AMDLIBM-LABEL: define {{[^@]+}}@exp_f32
; AMDLIBM-SAME: (<4 x float> [[IN:%.*]]) {
; AMDLIBM-NEXT:    [[TMP1:%.*]] = call <4 x float> @amd_vrs4_expf(<4 x float> [[IN]])
; AMDLIBM-NEXT:    ret <4 x float> [[TMP1]]
;
; LIBMVEC-X86-LABEL: define {{[^@]+}}@exp_f32
; LIBMVEC-X86-SAME: (<4 x float> [[IN:%.*]]) {
; LIBMVEC-X86-NEXT:    [[TMP1:%.*]] = call <4 x float> @_ZGVbN4v_expf(<4 x float> [[IN]])
; LIBMVEC-X86-NEXT:    ret <4 x float> [[TMP1]]
;
; MASSV-LABEL: define {{[^@]+}}@exp_f32
; MASSV-SAME: (<4 x float> [[IN:%.*]]) {
; MASSV-NEXT:    [[TMP1:%.*]] = call <4 x float> @__expf4(<4 x float> [[IN]])
; MASSV-NEXT:    ret <4 x float> [[TMP1]]
;
; ACCELERATE-LABEL: define {{[^@]+}}@exp_f32
; ACCELERATE-SAME: (<4 x float> [[IN:%.*]]) {
; ACCELERATE-NEXT:    [[TMP1:%.*]] = call <4 x float> @vexpf(<4 x float> [[IN]])
; ACCELERATE-NEXT:    ret <4 x float> [[TMP1]]
;
  %call = call <4 x float> @llvm.exp.v4f32(<4 x float> %in)
  ret <4 x float> %call
}

declare <4 x float> @llvm.exp.v4f32(<4 x float>) #0

; No replacement should take place for non-vector intrinsic.
define double @exp_f64(double %in) {
; COMMON-LABEL: define {{[^@]+}}@exp_f64
; COMMON-SAME: (double [[IN:%.*]]) {
; COMMON-NEXT:    [[CALL:%.*]] = call double @llvm.exp.f64(double [[IN]])
; COMMON-NEXT:    ret double [[CALL]]
;
  %call = call double @llvm.exp.f64(double %in)
  ret double %call
}

declare double @llvm.exp.f64(double) #0

; Check that the pass works with scalar operands on
; vector intrinsics. No vector library has a substitute for powi.
define <4 x double> @powi_v4(<4 x double> %in){
; COMMON-LABEL: define {{[^@]+}}@powi_v4
; COMMON-SAME: (<4 x double> [[IN:%.*]]) {
; COMMON-NEXT:    [[CALL:%.*]] = call <4 x double> @llvm.powi.v4f64.i32(<4 x double> [[IN]], i32 3)
; COMMON-NEXT:    ret <4 x double> [[CALL]]
;
  %call = call <4 x double> @llvm.powi.v4f64.i32(<4 x double> %in, i32 3)
  ret <4 x double> %call
}

declare <4 x double> @llvm.powi.v4f64.i32(<4 x double>, i32) #0

; Replacement should not take place if the vector length
; does not match exactly.
define <3 x double> @exp_v3(<3 x double> %in) {
; COMMON-LABEL: define {{[^@]+}}@exp_v3
; COMMON-SAME: (<3 x double> [[IN:%.*]]) {
; COMMON-NEXT:    [[CALL:%.*]] = call <3 x double> @llvm.exp.v3f64(<3 x double> [[IN]])
; COMMON-NEXT:    ret <3 x double> [[CALL]]
;
  %call = call <3 x double> @llvm.exp.v3f64(<3 x double> %in)
  ret <3 x double> %call
}

declare <3 x double> @llvm.exp.v3f64(<3 x double>) #0

attributes #0 = {nounwind readnone}