; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=skx | FileCheck %s

define <8 x i1> @ham(i64 %arg) {
; CHECK-LABEL: ham:
; CHECK:       # %bb.0:
; CHECK-NEXT:    andb $1, %dil
; CHECK-NEXT:    negb %dil
; CHECK-NEXT:    kmovd %edi, %k0
; CHECK-NEXT:    vpmovm2w %k0, %xmm0
; CHECK-NEXT:    retq
  %tmp = trunc i64 %arg to i1
  %tmp1 = insertelement <8 x i1> undef, i1 %tmp, i32 0
  %tmp2 = shufflevector <8 x i1> %tmp1, <8 x i1> undef, <8 x i32> zeroinitializer
  ret <8 x i1> %tmp2
}