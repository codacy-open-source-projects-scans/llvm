; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+zfbfmin,+zvfbfmin,+v \
; RUN:     -target-abi=ilp32d -verify-machineinstrs < %s | FileCheck %s \
; RUN:     --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+zfbfmin,+zvfbfmin,+v \
; RUN:     -target-abi=lp64d -verify-machineinstrs < %s | FileCheck %s \
; RUN:     --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfhmin,+zvfhmin,+zfbfmin,+zvfbfmin,+v \
; RUN:     -target-abi=ilp32d -verify-machineinstrs < %s | FileCheck %s \
; RUN:     --check-prefixes=CHECK,ZVFHMIN
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfhmin,+zvfhmin,+zfbfmin,+zvfbfmin,+v \
; RUN:     -target-abi=lp64d -verify-machineinstrs < %s | FileCheck %s \
; RUN:     --check-prefixes=CHECK,ZVFHMIN

declare <vscale x 1 x bfloat> @llvm.vp.sqrt.nxv1bf16(<vscale x 1 x bfloat>, <vscale x 1 x i1>, i32)

define <vscale x 1 x bfloat> @vfsqrt_vv_nxv1bf16(<vscale x 1 x bfloat> %va, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv1bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfsqrt.v v9, v9, v0.t
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x bfloat> @llvm.vp.sqrt.nxv1bf16(<vscale x 1 x bfloat> %va, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x bfloat> %v
}

define <vscale x 1 x bfloat> @vfsqrt_vv_nxv1bf16_unmasked(<vscale x 1 x bfloat> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv1bf16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfsqrt.v v9, v9
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x bfloat> @llvm.vp.sqrt.nxv1bf16(<vscale x 1 x bfloat> %va, <vscale x 1 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 1 x bfloat> %v
}

declare <vscale x 2 x bfloat> @llvm.vp.sqrt.nxv2bf16(<vscale x 2 x bfloat>, <vscale x 2 x i1>, i32)

define <vscale x 2 x bfloat> @vfsqrt_vv_nxv2bf16(<vscale x 2 x bfloat> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv2bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfsqrt.v v9, v9, v0.t
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x bfloat> @llvm.vp.sqrt.nxv2bf16(<vscale x 2 x bfloat> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x bfloat> %v
}

define <vscale x 2 x bfloat> @vfsqrt_vv_nxv2bf16_unmasked(<vscale x 2 x bfloat> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv2bf16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfsqrt.v v9, v9
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x bfloat> @llvm.vp.sqrt.nxv2bf16(<vscale x 2 x bfloat> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x bfloat> %v
}

declare <vscale x 4 x bfloat> @llvm.vp.sqrt.nxv4bf16(<vscale x 4 x bfloat>, <vscale x 4 x i1>, i32)

define <vscale x 4 x bfloat> @vfsqrt_vv_nxv4bf16(<vscale x 4 x bfloat> %va, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv4bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v10, v8
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfsqrt.v v10, v10, v0.t
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x bfloat> @llvm.vp.sqrt.nxv4bf16(<vscale x 4 x bfloat> %va, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x bfloat> %v
}

define <vscale x 4 x bfloat> @vfsqrt_vv_nxv4bf16_unmasked(<vscale x 4 x bfloat> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv4bf16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v10, v8
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfsqrt.v v10, v10
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x bfloat> @llvm.vp.sqrt.nxv4bf16(<vscale x 4 x bfloat> %va, <vscale x 4 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 4 x bfloat> %v
}

declare <vscale x 8 x bfloat> @llvm.vp.sqrt.nxv8bf16(<vscale x 8 x bfloat>, <vscale x 8 x i1>, i32)

define <vscale x 8 x bfloat> @vfsqrt_vv_nxv8bf16(<vscale x 8 x bfloat> %va, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv8bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m2, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v12, v8
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfsqrt.v v12, v12, v0.t
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v12
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x bfloat> @llvm.vp.sqrt.nxv8bf16(<vscale x 8 x bfloat> %va, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x bfloat> %v
}

define <vscale x 8 x bfloat> @vfsqrt_vv_nxv8bf16_unmasked(<vscale x 8 x bfloat> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv8bf16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m2, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v12, v8
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfsqrt.v v12, v12
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v12
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x bfloat> @llvm.vp.sqrt.nxv8bf16(<vscale x 8 x bfloat> %va, <vscale x 8 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 8 x bfloat> %v
}

declare <vscale x 16 x bfloat> @llvm.vp.sqrt.nxv16bf16(<vscale x 16 x bfloat>, <vscale x 16 x i1>, i32)

define <vscale x 16 x bfloat> @vfsqrt_vv_nxv16bf16(<vscale x 16 x bfloat> %va, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv16bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v16, v8
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v16, v16, v0.t
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x bfloat> @llvm.vp.sqrt.nxv16bf16(<vscale x 16 x bfloat> %va, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x bfloat> %v
}

define <vscale x 16 x bfloat> @vfsqrt_vv_nxv16bf16_unmasked(<vscale x 16 x bfloat> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv16bf16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v16, v8
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v16, v16
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x bfloat> @llvm.vp.sqrt.nxv16bf16(<vscale x 16 x bfloat> %va, <vscale x 16 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 16 x bfloat> %v
}

declare <vscale x 32 x bfloat> @llvm.vp.sqrt.nxv32bf16(<vscale x 32 x bfloat>, <vscale x 32 x i1>, i32)

define <vscale x 32 x bfloat> @vfsqrt_vv_nxv32bf16(<vscale x 32 x bfloat> %va, <vscale x 32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv32bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v16, v0
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    slli a1, a2, 1
; CHECK-NEXT:    sub a3, a0, a1
; CHECK-NEXT:    sltu a4, a0, a3
; CHECK-NEXT:    addi a4, a4, -1
; CHECK-NEXT:    and a3, a4, a3
; CHECK-NEXT:    srli a2, a2, 2
; CHECK-NEXT:    vsetvli a4, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v0, a2
; CHECK-NEXT:    vsetvli a2, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v24, v12
; CHECK-NEXT:    vsetvli zero, a3, e32, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v24, v24, v0.t
; CHECK-NEXT:    vsetvli a2, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v12, v24
; CHECK-NEXT:    bltu a0, a1, .LBB10_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB10_2:
; CHECK-NEXT:    vfwcvtbf16.f.f.v v24, v8
; CHECK-NEXT:    vmv1r.v v0, v16
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v16, v24, v0.t
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x bfloat> @llvm.vp.sqrt.nxv32bf16(<vscale x 32 x bfloat> %va, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x bfloat> %v
}

define <vscale x 32 x bfloat> @vfsqrt_vv_nxv32bf16_unmasked(<vscale x 32 x bfloat> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv32bf16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    slli a1, a2, 1
; CHECK-NEXT:    sub a3, a0, a1
; CHECK-NEXT:    sltu a4, a0, a3
; CHECK-NEXT:    addi a4, a4, -1
; CHECK-NEXT:    and a3, a4, a3
; CHECK-NEXT:    srli a2, a2, 2
; CHECK-NEXT:    vsetvli a4, zero, e8, m4, ta, ma
; CHECK-NEXT:    vmset.m v16
; CHECK-NEXT:    vsetvli a4, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v16, a2
; CHECK-NEXT:    vsetvli a2, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v16, v12
; CHECK-NEXT:    vsetvli zero, a3, e32, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v16, v16, v0.t
; CHECK-NEXT:    vsetvli a2, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v12, v16
; CHECK-NEXT:    bltu a0, a1, .LBB11_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB11_2:
; CHECK-NEXT:    vfwcvtbf16.f.f.v v16, v8
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v16, v16
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vfncvtbf16.f.f.w v8, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x bfloat> @llvm.vp.sqrt.nxv32bf16(<vscale x 32 x bfloat> %va, <vscale x 32 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 32 x bfloat> %v
}
declare <vscale x 1 x half> @llvm.vp.sqrt.nxv1f16(<vscale x 1 x half>, <vscale x 1 x i1>, i32)

define <vscale x 1 x half> @vfsqrt_vv_nxv1f16(<vscale x 1 x half> %va, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_nxv1f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_nxv1f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v9, v9, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 1 x half> @llvm.vp.sqrt.nxv1f16(<vscale x 1 x half> %va, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x half> %v
}

define <vscale x 1 x half> @vfsqrt_vv_nxv1f16_unmasked(<vscale x 1 x half> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_nxv1f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_nxv1f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v9, v9
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 1 x half> @llvm.vp.sqrt.nxv1f16(<vscale x 1 x half> %va, <vscale x 1 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 1 x half> %v
}

declare <vscale x 2 x half> @llvm.vp.sqrt.nxv2f16(<vscale x 2 x half>, <vscale x 2 x i1>, i32)

define <vscale x 2 x half> @vfsqrt_vv_nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_nxv2f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_nxv2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v9, v9, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.sqrt.nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x half> %v
}

define <vscale x 2 x half> @vfsqrt_vv_nxv2f16_unmasked(<vscale x 2 x half> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_nxv2f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_nxv2f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v9, v9
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.sqrt.nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x half> %v
}

declare <vscale x 4 x half> @llvm.vp.sqrt.nxv4f16(<vscale x 4 x half>, <vscale x 4 x i1>, i32)

define <vscale x 4 x half> @vfsqrt_vv_nxv4f16(<vscale x 4 x half> %va, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_nxv4f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_nxv4f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v10, v10, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 4 x half> @llvm.vp.sqrt.nxv4f16(<vscale x 4 x half> %va, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x half> %v
}

define <vscale x 4 x half> @vfsqrt_vv_nxv4f16_unmasked(<vscale x 4 x half> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_nxv4f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_nxv4f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v10, v10
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 4 x half> @llvm.vp.sqrt.nxv4f16(<vscale x 4 x half> %va, <vscale x 4 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 4 x half> %v
}

declare <vscale x 8 x half> @llvm.vp.sqrt.nxv8f16(<vscale x 8 x half>, <vscale x 8 x i1>, i32)

define <vscale x 8 x half> @vfsqrt_vv_nxv8f16(<vscale x 8 x half> %va, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_nxv8f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_nxv8f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v12, v12, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 8 x half> @llvm.vp.sqrt.nxv8f16(<vscale x 8 x half> %va, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x half> %v
}

define <vscale x 8 x half> @vfsqrt_vv_nxv8f16_unmasked(<vscale x 8 x half> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_nxv8f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_nxv8f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v12, v12
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 8 x half> @llvm.vp.sqrt.nxv8f16(<vscale x 8 x half> %va, <vscale x 8 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 8 x half> %v
}

declare <vscale x 16 x half> @llvm.vp.sqrt.nxv16f16(<vscale x 16 x half>, <vscale x 16 x i1>, i32)

define <vscale x 16 x half> @vfsqrt_vv_nxv16f16(<vscale x 16 x half> %va, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_nxv16f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_nxv16f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v16, v16, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 16 x half> @llvm.vp.sqrt.nxv16f16(<vscale x 16 x half> %va, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x half> %v
}

define <vscale x 16 x half> @vfsqrt_vv_nxv16f16_unmasked(<vscale x 16 x half> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_nxv16f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_nxv16f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v16, v16
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 16 x half> @llvm.vp.sqrt.nxv16f16(<vscale x 16 x half> %va, <vscale x 16 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 16 x half> %v
}

declare <vscale x 32 x half> @llvm.vp.sqrt.nxv32f16(<vscale x 32 x half>, <vscale x 32 x i1>, i32)

define <vscale x 32 x half> @vfsqrt_vv_nxv32f16(<vscale x 32 x half> %va, <vscale x 32 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_nxv32f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_nxv32f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vmv1r.v v16, v0
; ZVFHMIN-NEXT:    csrr a2, vlenb
; ZVFHMIN-NEXT:    slli a1, a2, 1
; ZVFHMIN-NEXT:    sub a3, a0, a1
; ZVFHMIN-NEXT:    sltu a4, a0, a3
; ZVFHMIN-NEXT:    addi a4, a4, -1
; ZVFHMIN-NEXT:    and a3, a4, a3
; ZVFHMIN-NEXT:    srli a2, a2, 2
; ZVFHMIN-NEXT:    vsetvli a4, zero, e8, mf2, ta, ma
; ZVFHMIN-NEXT:    vslidedown.vx v0, v0, a2
; ZVFHMIN-NEXT:    vsetvli a2, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v12
; ZVFHMIN-NEXT:    vsetvli zero, a3, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v24, v24, v0.t
; ZVFHMIN-NEXT:    vsetvli a2, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v12, v24
; ZVFHMIN-NEXT:    bltu a0, a1, .LBB22_2
; ZVFHMIN-NEXT:  # %bb.1:
; ZVFHMIN-NEXT:    mv a0, a1
; ZVFHMIN-NEXT:  .LBB22_2:
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v8
; ZVFHMIN-NEXT:    vmv1r.v v0, v16
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v16, v24, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 32 x half> @llvm.vp.sqrt.nxv32f16(<vscale x 32 x half> %va, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x half> %v
}

define <vscale x 32 x half> @vfsqrt_vv_nxv32f16_unmasked(<vscale x 32 x half> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vfsqrt_vv_nxv32f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_vv_nxv32f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    csrr a2, vlenb
; ZVFHMIN-NEXT:    slli a1, a2, 1
; ZVFHMIN-NEXT:    sub a3, a0, a1
; ZVFHMIN-NEXT:    sltu a4, a0, a3
; ZVFHMIN-NEXT:    addi a4, a4, -1
; ZVFHMIN-NEXT:    and a3, a4, a3
; ZVFHMIN-NEXT:    srli a2, a2, 2
; ZVFHMIN-NEXT:    vsetvli a4, zero, e8, m4, ta, ma
; ZVFHMIN-NEXT:    vmset.m v16
; ZVFHMIN-NEXT:    vsetvli a4, zero, e8, mf2, ta, ma
; ZVFHMIN-NEXT:    vslidedown.vx v0, v16, a2
; ZVFHMIN-NEXT:    vsetvli a2, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v12
; ZVFHMIN-NEXT:    vsetvli zero, a3, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v16, v16, v0.t
; ZVFHMIN-NEXT:    vsetvli a2, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v12, v16
; ZVFHMIN-NEXT:    bltu a0, a1, .LBB23_2
; ZVFHMIN-NEXT:  # %bb.1:
; ZVFHMIN-NEXT:    mv a0, a1
; ZVFHMIN-NEXT:  .LBB23_2:
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v16, v16
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 32 x half> @llvm.vp.sqrt.nxv32f16(<vscale x 32 x half> %va, <vscale x 32 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 32 x half> %v
}

declare <vscale x 1 x float> @llvm.vp.sqrt.nxv1f32(<vscale x 1 x float>, <vscale x 1 x i1>, i32)

define <vscale x 1 x float> @vfsqrt_vv_nxv1f32(<vscale x 1 x float> %va, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x float> @llvm.vp.sqrt.nxv1f32(<vscale x 1 x float> %va, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x float> %v
}

define <vscale x 1 x float> @vfsqrt_vv_nxv1f32_unmasked(<vscale x 1 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv1f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x float> @llvm.vp.sqrt.nxv1f32(<vscale x 1 x float> %va, <vscale x 1 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 1 x float> %v
}

declare <vscale x 2 x float> @llvm.vp.sqrt.nxv2f32(<vscale x 2 x float>, <vscale x 2 x i1>, i32)

define <vscale x 2 x float> @vfsqrt_vv_nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.sqrt.nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x float> %v
}

define <vscale x 2 x float> @vfsqrt_vv_nxv2f32_unmasked(<vscale x 2 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv2f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.sqrt.nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x float> %v
}

declare <vscale x 4 x float> @llvm.vp.sqrt.nxv4f32(<vscale x 4 x float>, <vscale x 4 x i1>, i32)

define <vscale x 4 x float> @vfsqrt_vv_nxv4f32(<vscale x 4 x float> %va, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x float> @llvm.vp.sqrt.nxv4f32(<vscale x 4 x float> %va, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x float> %v
}

define <vscale x 4 x float> @vfsqrt_vv_nxv4f32_unmasked(<vscale x 4 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv4f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x float> @llvm.vp.sqrt.nxv4f32(<vscale x 4 x float> %va, <vscale x 4 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 4 x float> %v
}

declare <vscale x 8 x float> @llvm.vp.sqrt.nxv8f32(<vscale x 8 x float>, <vscale x 8 x i1>, i32)

define <vscale x 8 x float> @vfsqrt_vv_nxv8f32(<vscale x 8 x float> %va, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x float> @llvm.vp.sqrt.nxv8f32(<vscale x 8 x float> %va, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x float> %v
}

define <vscale x 8 x float> @vfsqrt_vv_nxv8f32_unmasked(<vscale x 8 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv8f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x float> @llvm.vp.sqrt.nxv8f32(<vscale x 8 x float> %va, <vscale x 8 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 8 x float> %v
}

declare <vscale x 16 x float> @llvm.vp.sqrt.nxv16f32(<vscale x 16 x float>, <vscale x 16 x i1>, i32)

define <vscale x 16 x float> @vfsqrt_vv_nxv16f32(<vscale x 16 x float> %va, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x float> @llvm.vp.sqrt.nxv16f32(<vscale x 16 x float> %va, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x float> %v
}

define <vscale x 16 x float> @vfsqrt_vv_nxv16f32_unmasked(<vscale x 16 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv16f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x float> @llvm.vp.sqrt.nxv16f32(<vscale x 16 x float> %va, <vscale x 16 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 16 x float> %v
}

declare <vscale x 1 x double> @llvm.vp.sqrt.nxv1f64(<vscale x 1 x double>, <vscale x 1 x i1>, i32)

define <vscale x 1 x double> @vfsqrt_vv_nxv1f64(<vscale x 1 x double> %va, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x double> @llvm.vp.sqrt.nxv1f64(<vscale x 1 x double> %va, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x double> %v
}

define <vscale x 1 x double> @vfsqrt_vv_nxv1f64_unmasked(<vscale x 1 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv1f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x double> @llvm.vp.sqrt.nxv1f64(<vscale x 1 x double> %va, <vscale x 1 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 1 x double> %v
}

declare <vscale x 2 x double> @llvm.vp.sqrt.nxv2f64(<vscale x 2 x double>, <vscale x 2 x i1>, i32)

define <vscale x 2 x double> @vfsqrt_vv_nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.sqrt.nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x double> %v
}

define <vscale x 2 x double> @vfsqrt_vv_nxv2f64_unmasked(<vscale x 2 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv2f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.sqrt.nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x double> %v
}

declare <vscale x 4 x double> @llvm.vp.sqrt.nxv4f64(<vscale x 4 x double>, <vscale x 4 x i1>, i32)

define <vscale x 4 x double> @vfsqrt_vv_nxv4f64(<vscale x 4 x double> %va, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x double> @llvm.vp.sqrt.nxv4f64(<vscale x 4 x double> %va, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x double> %v
}

define <vscale x 4 x double> @vfsqrt_vv_nxv4f64_unmasked(<vscale x 4 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv4f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x double> @llvm.vp.sqrt.nxv4f64(<vscale x 4 x double> %va, <vscale x 4 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 4 x double> %v
}

declare <vscale x 7 x double> @llvm.vp.sqrt.nxv7f64(<vscale x 7 x double>, <vscale x 7 x i1>, i32)

define <vscale x 7 x double> @vfsqrt_vv_nxv7f64(<vscale x 7 x double> %va, <vscale x 7 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv7f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 7 x double> @llvm.vp.sqrt.nxv7f64(<vscale x 7 x double> %va, <vscale x 7 x i1> %m, i32 %evl)
  ret <vscale x 7 x double> %v
}

define <vscale x 7 x double> @vfsqrt_vv_nxv7f64_unmasked(<vscale x 7 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv7f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 7 x double> @llvm.vp.sqrt.nxv7f64(<vscale x 7 x double> %va, <vscale x 7 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 7 x double> %v
}

declare <vscale x 8 x double> @llvm.vp.sqrt.nxv8f64(<vscale x 8 x double>, <vscale x 8 x i1>, i32)

define <vscale x 8 x double> @vfsqrt_vv_nxv8f64(<vscale x 8 x double> %va, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x double> @llvm.vp.sqrt.nxv8f64(<vscale x 8 x double> %va, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x double> %v
}

define <vscale x 8 x double> @vfsqrt_vv_nxv8f64_unmasked(<vscale x 8 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv8f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x double> @llvm.vp.sqrt.nxv8f64(<vscale x 8 x double> %va, <vscale x 8 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 8 x double> %v
}

; Test splitting.
declare <vscale x 16 x double> @llvm.vp.sqrt.nxv16f64(<vscale x 16 x double>, <vscale x 16 x i1>, i32)

define <vscale x 16 x double> @vfsqrt_vv_nxv16f64(<vscale x 16 x double> %va, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv16f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v24, v0
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    srli a2, a1, 3
; CHECK-NEXT:    vsetvli a3, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v0, a2
; CHECK-NEXT:    sub a2, a0, a1
; CHECK-NEXT:    sltu a3, a0, a2
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a2, a3, a2
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v16, v16, v0.t
; CHECK-NEXT:    bltu a0, a1, .LBB44_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB44_2:
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x double> @llvm.vp.sqrt.nxv16f64(<vscale x 16 x double> %va, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x double> %v
}

define <vscale x 16 x double> @vfsqrt_vv_nxv16f64_unmasked(<vscale x 16 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfsqrt_vv_nxv16f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    sub a2, a0, a1
; CHECK-NEXT:    sltu a3, a0, a2
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a2, a3, a2
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v16, v16
; CHECK-NEXT:    bltu a0, a1, .LBB45_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB45_2:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x double> @llvm.vp.sqrt.nxv16f64(<vscale x 16 x double> %va, <vscale x 16 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 16 x double> %v
}