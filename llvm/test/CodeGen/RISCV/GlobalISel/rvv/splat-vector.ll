; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=riscv32 -mattr=+v,+zvfh -global-isel \
; RUN:   -verify-machineinstrs < %s | FileCheck -check-prefixes=CHECK,RV32 %s
; RUN: llc -mtriple=riscv64 -mattr=+v,+zvfh -global-isel \
; RUN:   -verify-machineinstrs < %s | FileCheck -check-prefixes=CHECK,RV64 %s

define <vscale x 1 x i1> @splat_zero_nxv1i1() {
; CHECK-LABEL: splat_zero_nxv1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vmclr.m v0
; CHECK-NEXT:    ret
  ret <vscale x 1 x i1> zeroinitializer
}

define <vscale x 2 x i1> @splat_zero_nxv2i1() {
; CHECK-LABEL: splat_zero_nxv2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vmclr.m v0
; CHECK-NEXT:    ret
  ret <vscale x 2 x i1> zeroinitializer
}

define <vscale x 4 x i1> @splat_zero_nxv4i1() {
; CHECK-LABEL: splat_zero_nxv4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vmclr.m v0
; CHECK-NEXT:    ret
  ret <vscale x 4 x i1> zeroinitializer
}

define <vscale x 8 x i1> @splat_zero_nxv8i1() {
; CHECK-LABEL: splat_zero_nxv8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmclr.m v0
; CHECK-NEXT:    ret
  ret <vscale x 8 x i1> zeroinitializer
}

define <vscale x 16 x i1> @splat_zero_nxv16i1() {
; CHECK-LABEL: splat_zero_nxv16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m2, ta, ma
; CHECK-NEXT:    vmclr.m v0
; CHECK-NEXT:    ret
  ret <vscale x 16 x i1> zeroinitializer
}

define <vscale x 32 x i1> @splat_zero_nxv32i1() {
; CHECK-LABEL: splat_zero_nxv32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m4, ta, ma
; CHECK-NEXT:    vmclr.m v0
; CHECK-NEXT:    ret
  ret <vscale x 32 x i1> zeroinitializer
}

define <vscale x 64 x i1> @splat_zero_nxv64i1() {
; CHECK-LABEL: splat_zero_nxv64i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m8, ta, ma
; CHECK-NEXT:    vmclr.m v0
; CHECK-NEXT:    ret
  ret <vscale x 64 x i1> zeroinitializer
}


;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; RV32: {{.*}}
; RV64: {{.*}}