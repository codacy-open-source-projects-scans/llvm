; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=riscv32 -mattr=+v,+zvfbfwma -verify-machineinstrs | FileCheck %s --check-prefix=ZVFBFWMA
; RUN: llc < %s -mtriple=riscv64 -mattr=+v,+zvfbfwma -verify-machineinstrs | FileCheck %s --check-prefix=ZVFBFWMA
; RUN: llc < %s -mtriple=riscv32 -mattr=+v,+zvfbfmin -verify-machineinstrs | FileCheck %s --check-prefixes=ZVFBFMIN,ZVFBMIN32
; RUN: llc < %s -mtriple=riscv64 -mattr=+v,+zvfbfmin -verify-machineinstrs | FileCheck %s --check-prefixes=ZVFBFMIN,ZVFBMIN64

define <1 x float> @vfwmaccbf16_vv_v1f32(<1 x float> %a, <1 x bfloat> %b, <1 x bfloat> %c) {
; ZVFBFWMA-LABEL: vfwmaccbf16_vv_v1f32:
; ZVFBFWMA:       # %bb.0:
; ZVFBFWMA-NEXT:    addi sp, sp, -16
; ZVFBFWMA-NEXT:    .cfi_def_cfa_offset 16
; ZVFBFWMA-NEXT:    fcvt.s.bf16 fa5, fa0
; ZVFBFWMA-NEXT:    fsw fa5, 8(sp)
; ZVFBFWMA-NEXT:    addi a0, sp, 8
; ZVFBFWMA-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; ZVFBFWMA-NEXT:    vle32.v v9, (a0)
; ZVFBFWMA-NEXT:    fcvt.s.bf16 fa5, fa1
; ZVFBFWMA-NEXT:    fsw fa5, 12(sp)
; ZVFBFWMA-NEXT:    addi a0, sp, 12
; ZVFBFWMA-NEXT:    vle32.v v10, (a0)
; ZVFBFWMA-NEXT:    vfmacc.vv v8, v9, v10
; ZVFBFWMA-NEXT:    addi sp, sp, 16
; ZVFBFWMA-NEXT:    ret
;
; ZVFBMIN32-LABEL: vfwmaccbf16_vv_v1f32:
; ZVFBMIN32:       # %bb.0:
; ZVFBMIN32-NEXT:    addi sp, sp, -32
; ZVFBMIN32-NEXT:    .cfi_def_cfa_offset 32
; ZVFBMIN32-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; ZVFBMIN32-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; ZVFBMIN32-NEXT:    fsd fs0, 16(sp) # 8-byte Folded Spill
; ZVFBMIN32-NEXT:    .cfi_offset ra, -4
; ZVFBMIN32-NEXT:    .cfi_offset s0, -8
; ZVFBMIN32-NEXT:    .cfi_offset fs0, -16
; ZVFBMIN32-NEXT:    csrr a0, vlenb
; ZVFBMIN32-NEXT:    sub sp, sp, a0
; ZVFBMIN32-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 1 * vlenb
; ZVFBMIN32-NEXT:    fmv.s fs0, fa0
; ZVFBMIN32-NEXT:    addi a0, sp, 16
; ZVFBMIN32-NEXT:    vs1r.v v8, (a0) # Unknown-size Folded Spill
; ZVFBMIN32-NEXT:    fmv.s fa0, fa1
; ZVFBMIN32-NEXT:    call __truncsfbf2
; ZVFBMIN32-NEXT:    fmv.x.w s0, fa0
; ZVFBMIN32-NEXT:    fmv.s fa0, fs0
; ZVFBMIN32-NEXT:    call __truncsfbf2
; ZVFBMIN32-NEXT:    fmv.x.w a0, fa0
; ZVFBMIN32-NEXT:    slli a0, a0, 16
; ZVFBMIN32-NEXT:    sw a0, 8(sp)
; ZVFBMIN32-NEXT:    addi a0, sp, 8
; ZVFBMIN32-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; ZVFBMIN32-NEXT:    vle32.v v10, (a0)
; ZVFBMIN32-NEXT:    slli s0, s0, 16
; ZVFBMIN32-NEXT:    sw s0, 12(sp)
; ZVFBMIN32-NEXT:    addi a0, sp, 12
; ZVFBMIN32-NEXT:    vle32.v v9, (a0)
; ZVFBMIN32-NEXT:    addi a0, sp, 16
; ZVFBMIN32-NEXT:    vl1r.v v8, (a0) # Unknown-size Folded Reload
; ZVFBMIN32-NEXT:    vfmacc.vv v8, v10, v9
; ZVFBMIN32-NEXT:    csrr a0, vlenb
; ZVFBMIN32-NEXT:    add sp, sp, a0
; ZVFBMIN32-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; ZVFBMIN32-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; ZVFBMIN32-NEXT:    fld fs0, 16(sp) # 8-byte Folded Reload
; ZVFBMIN32-NEXT:    addi sp, sp, 32
; ZVFBMIN32-NEXT:    ret
;
; ZVFBMIN64-LABEL: vfwmaccbf16_vv_v1f32:
; ZVFBMIN64:       # %bb.0:
; ZVFBMIN64-NEXT:    addi sp, sp, -64
; ZVFBMIN64-NEXT:    .cfi_def_cfa_offset 64
; ZVFBMIN64-NEXT:    sd ra, 56(sp) # 8-byte Folded Spill
; ZVFBMIN64-NEXT:    sd s0, 48(sp) # 8-byte Folded Spill
; ZVFBMIN64-NEXT:    fsd fs0, 40(sp) # 8-byte Folded Spill
; ZVFBMIN64-NEXT:    .cfi_offset ra, -8
; ZVFBMIN64-NEXT:    .cfi_offset s0, -16
; ZVFBMIN64-NEXT:    .cfi_offset fs0, -24
; ZVFBMIN64-NEXT:    csrr a0, vlenb
; ZVFBMIN64-NEXT:    sub sp, sp, a0
; ZVFBMIN64-NEXT:    .cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 1 * vlenb
; ZVFBMIN64-NEXT:    fmv.s fs0, fa0
; ZVFBMIN64-NEXT:    addi a0, sp, 32
; ZVFBMIN64-NEXT:    vs1r.v v8, (a0) # Unknown-size Folded Spill
; ZVFBMIN64-NEXT:    fmv.s fa0, fa1
; ZVFBMIN64-NEXT:    call __truncsfbf2
; ZVFBMIN64-NEXT:    fmv.x.w s0, fa0
; ZVFBMIN64-NEXT:    fmv.s fa0, fs0
; ZVFBMIN64-NEXT:    call __truncsfbf2
; ZVFBMIN64-NEXT:    fmv.x.w a0, fa0
; ZVFBMIN64-NEXT:    slli a0, a0, 16
; ZVFBMIN64-NEXT:    fmv.w.x fa5, a0
; ZVFBMIN64-NEXT:    fsw fa5, 16(sp)
; ZVFBMIN64-NEXT:    addi a0, sp, 16
; ZVFBMIN64-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; ZVFBMIN64-NEXT:    vle32.v v10, (a0)
; ZVFBMIN64-NEXT:    slli s0, s0, 16
; ZVFBMIN64-NEXT:    fmv.w.x fa5, s0
; ZVFBMIN64-NEXT:    fsw fa5, 20(sp)
; ZVFBMIN64-NEXT:    addi a0, sp, 20
; ZVFBMIN64-NEXT:    vle32.v v9, (a0)
; ZVFBMIN64-NEXT:    addi a0, sp, 32
; ZVFBMIN64-NEXT:    vl1r.v v8, (a0) # Unknown-size Folded Reload
; ZVFBMIN64-NEXT:    vfmacc.vv v8, v10, v9
; ZVFBMIN64-NEXT:    csrr a0, vlenb
; ZVFBMIN64-NEXT:    add sp, sp, a0
; ZVFBMIN64-NEXT:    ld ra, 56(sp) # 8-byte Folded Reload
; ZVFBMIN64-NEXT:    ld s0, 48(sp) # 8-byte Folded Reload
; ZVFBMIN64-NEXT:    fld fs0, 40(sp) # 8-byte Folded Reload
; ZVFBMIN64-NEXT:    addi sp, sp, 64
; ZVFBMIN64-NEXT:    ret
  %b.ext = fpext <1 x bfloat> %b to <1 x float>
  %c.ext = fpext <1 x bfloat> %c to <1 x float>
  %res = call <1 x float> @llvm.fma.v1f32(<1 x float> %b.ext, <1 x float> %c.ext, <1 x float> %a)
  ret <1 x float> %res
}

define <1 x float> @vfwmaccbf16_vf_v1f32(<1 x float> %a, bfloat %b, <1 x bfloat> %c) {
; ZVFBFWMA-LABEL: vfwmaccbf16_vf_v1f32:
; ZVFBFWMA:       # %bb.0:
; ZVFBFWMA-NEXT:    addi sp, sp, -16
; ZVFBFWMA-NEXT:    .cfi_def_cfa_offset 16
; ZVFBFWMA-NEXT:    fcvt.s.bf16 fa5, fa0
; ZVFBFWMA-NEXT:    fsw fa5, 8(sp)
; ZVFBFWMA-NEXT:    addi a0, sp, 8
; ZVFBFWMA-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; ZVFBFWMA-NEXT:    vle32.v v9, (a0)
; ZVFBFWMA-NEXT:    fcvt.s.bf16 fa5, fa1
; ZVFBFWMA-NEXT:    fsw fa5, 12(sp)
; ZVFBFWMA-NEXT:    addi a0, sp, 12
; ZVFBFWMA-NEXT:    vle32.v v10, (a0)
; ZVFBFWMA-NEXT:    vfmacc.vv v8, v9, v10
; ZVFBFWMA-NEXT:    addi sp, sp, 16
; ZVFBFWMA-NEXT:    ret
;
; ZVFBMIN32-LABEL: vfwmaccbf16_vf_v1f32:
; ZVFBMIN32:       # %bb.0:
; ZVFBMIN32-NEXT:    addi sp, sp, -48
; ZVFBMIN32-NEXT:    .cfi_def_cfa_offset 48
; ZVFBMIN32-NEXT:    sw ra, 44(sp) # 4-byte Folded Spill
; ZVFBMIN32-NEXT:    fsd fs0, 32(sp) # 8-byte Folded Spill
; ZVFBMIN32-NEXT:    .cfi_offset ra, -4
; ZVFBMIN32-NEXT:    .cfi_offset fs0, -16
; ZVFBMIN32-NEXT:    csrr a0, vlenb
; ZVFBMIN32-NEXT:    sub sp, sp, a0
; ZVFBMIN32-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 1 * vlenb
; ZVFBMIN32-NEXT:    fmv.s fs0, fa0
; ZVFBMIN32-NEXT:    addi a0, sp, 32
; ZVFBMIN32-NEXT:    vs1r.v v8, (a0) # Unknown-size Folded Spill
; ZVFBMIN32-NEXT:    fmv.s fa0, fa1
; ZVFBMIN32-NEXT:    call __truncsfbf2
; ZVFBMIN32-NEXT:    fmv.x.w a0, fa0
; ZVFBMIN32-NEXT:    fmv.x.w a1, fs0
; ZVFBMIN32-NEXT:    slli a1, a1, 16
; ZVFBMIN32-NEXT:    sw a1, 8(sp)
; ZVFBMIN32-NEXT:    addi a1, sp, 8
; ZVFBMIN32-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; ZVFBMIN32-NEXT:    vle32.v v10, (a1)
; ZVFBMIN32-NEXT:    slli a0, a0, 16
; ZVFBMIN32-NEXT:    sw a0, 12(sp)
; ZVFBMIN32-NEXT:    addi a0, sp, 12
; ZVFBMIN32-NEXT:    vle32.v v9, (a0)
; ZVFBMIN32-NEXT:    addi a0, sp, 32
; ZVFBMIN32-NEXT:    vl1r.v v8, (a0) # Unknown-size Folded Reload
; ZVFBMIN32-NEXT:    vfmacc.vv v8, v10, v9
; ZVFBMIN32-NEXT:    csrr a0, vlenb
; ZVFBMIN32-NEXT:    add sp, sp, a0
; ZVFBMIN32-NEXT:    lw ra, 44(sp) # 4-byte Folded Reload
; ZVFBMIN32-NEXT:    fld fs0, 32(sp) # 8-byte Folded Reload
; ZVFBMIN32-NEXT:    addi sp, sp, 48
; ZVFBMIN32-NEXT:    ret
;
; ZVFBMIN64-LABEL: vfwmaccbf16_vf_v1f32:
; ZVFBMIN64:       # %bb.0:
; ZVFBMIN64-NEXT:    addi sp, sp, -48
; ZVFBMIN64-NEXT:    .cfi_def_cfa_offset 48
; ZVFBMIN64-NEXT:    sd ra, 40(sp) # 8-byte Folded Spill
; ZVFBMIN64-NEXT:    fsd fs0, 32(sp) # 8-byte Folded Spill
; ZVFBMIN64-NEXT:    .cfi_offset ra, -8
; ZVFBMIN64-NEXT:    .cfi_offset fs0, -16
; ZVFBMIN64-NEXT:    csrr a0, vlenb
; ZVFBMIN64-NEXT:    sub sp, sp, a0
; ZVFBMIN64-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 1 * vlenb
; ZVFBMIN64-NEXT:    fmv.s fs0, fa0
; ZVFBMIN64-NEXT:    addi a0, sp, 32
; ZVFBMIN64-NEXT:    vs1r.v v8, (a0) # Unknown-size Folded Spill
; ZVFBMIN64-NEXT:    fmv.s fa0, fa1
; ZVFBMIN64-NEXT:    call __truncsfbf2
; ZVFBMIN64-NEXT:    fmv.x.w a0, fa0
; ZVFBMIN64-NEXT:    fmv.x.w a1, fs0
; ZVFBMIN64-NEXT:    slli a1, a1, 16
; ZVFBMIN64-NEXT:    fmv.w.x fa5, a1
; ZVFBMIN64-NEXT:    fsw fa5, 24(sp)
; ZVFBMIN64-NEXT:    addi a1, sp, 24
; ZVFBMIN64-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; ZVFBMIN64-NEXT:    vle32.v v10, (a1)
; ZVFBMIN64-NEXT:    slli a0, a0, 16
; ZVFBMIN64-NEXT:    fmv.w.x fa5, a0
; ZVFBMIN64-NEXT:    fsw fa5, 28(sp)
; ZVFBMIN64-NEXT:    addi a0, sp, 28
; ZVFBMIN64-NEXT:    vle32.v v9, (a0)
; ZVFBMIN64-NEXT:    addi a0, sp, 32
; ZVFBMIN64-NEXT:    vl1r.v v8, (a0) # Unknown-size Folded Reload
; ZVFBMIN64-NEXT:    vfmacc.vv v8, v10, v9
; ZVFBMIN64-NEXT:    csrr a0, vlenb
; ZVFBMIN64-NEXT:    add sp, sp, a0
; ZVFBMIN64-NEXT:    ld ra, 40(sp) # 8-byte Folded Reload
; ZVFBMIN64-NEXT:    fld fs0, 32(sp) # 8-byte Folded Reload
; ZVFBMIN64-NEXT:    addi sp, sp, 48
; ZVFBMIN64-NEXT:    ret
  %b.head = insertelement <1 x bfloat> poison, bfloat %b, i32 0
  %b.splat = shufflevector <1 x bfloat> %b.head, <1 x bfloat> poison, <1 x i32> zeroinitializer
  %b.ext = fpext <1 x bfloat> %b.splat to <1 x float>
  %c.ext = fpext <1 x bfloat> %c to <1 x float>
  %res = call <1 x float> @llvm.fma.v1f32(<1 x float> %b.ext, <1 x float> %c.ext, <1 x float> %a)
  ret <1 x float> %res
}

define <2 x float> @vfwmaccbf16_vv_v2f32(<2 x float> %a, <2 x bfloat> %b, <2 x bfloat> %c) {
; ZVFBFWMA-LABEL: vfwmaccbf16_vv_v2f32:
; ZVFBFWMA:       # %bb.0:
; ZVFBFWMA-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFBFWMA-NEXT:    vfwmaccbf16.vv v8, v9, v10
; ZVFBFWMA-NEXT:    ret
;
; ZVFBFMIN-LABEL: vfwmaccbf16_vv_v2f32:
; ZVFBFMIN:       # %bb.0:
; ZVFBFMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v11, v9
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v9, v10
; ZVFBFMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFBFMIN-NEXT:    vfmacc.vv v8, v11, v9
; ZVFBFMIN-NEXT:    ret
  %b.ext = fpext <2 x bfloat> %b to <2 x float>
  %c.ext = fpext <2 x bfloat> %c to <2 x float>
  %res = call <2 x float> @llvm.fma.v2f32(<2 x float> %b.ext, <2 x float> %c.ext, <2 x float> %a)
  ret <2 x float> %res
}

define <2 x float> @vfwmaccbf16_vf_v2f32(<2 x float> %a, bfloat %b, <2 x bfloat> %c) {
; ZVFBFWMA-LABEL: vfwmaccbf16_vf_v2f32:
; ZVFBFWMA:       # %bb.0:
; ZVFBFWMA-NEXT:    fmv.x.h a0, fa0
; ZVFBFWMA-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFBFWMA-NEXT:    vmv.v.x v10, a0
; ZVFBFWMA-NEXT:    vfwmaccbf16.vv v8, v10, v9
; ZVFBFWMA-NEXT:    ret
;
; ZVFBFMIN-LABEL: vfwmaccbf16_vf_v2f32:
; ZVFBFMIN:       # %bb.0:
; ZVFBFMIN-NEXT:    fmv.x.w a0, fa0
; ZVFBFMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFBFMIN-NEXT:    vmv.v.x v10, a0
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v11, v10
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v10, v9
; ZVFBFMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFBFMIN-NEXT:    vfmacc.vv v8, v11, v10
; ZVFBFMIN-NEXT:    ret
  %b.head = insertelement <2 x bfloat> poison, bfloat %b, i32 0
  %b.splat = shufflevector <2 x bfloat> %b.head, <2 x bfloat> poison, <2 x i32> zeroinitializer
  %b.ext = fpext <2 x bfloat> %b.splat to <2 x float>
  %c.ext = fpext <2 x bfloat> %c to <2 x float>
  %res = call <2 x float> @llvm.fma.v2f32(<2 x float> %b.ext, <2 x float> %c.ext, <2 x float> %a)
  ret <2 x float> %res
}

define <4 x float> @vfwmaccbf16_vv_v4f32(<4 x float> %a, <4 x bfloat> %b, <4 x bfloat> %c) {
; ZVFBFWMA-LABEL: vfwmaccbf16_vv_v4f32:
; ZVFBFWMA:       # %bb.0:
; ZVFBFWMA-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFBFWMA-NEXT:    vfwmaccbf16.vv v8, v9, v10
; ZVFBFWMA-NEXT:    ret
;
; ZVFBFMIN-LABEL: vfwmaccbf16_vv_v4f32:
; ZVFBFMIN:       # %bb.0:
; ZVFBFMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v11, v9
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v9, v10
; ZVFBFMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFBFMIN-NEXT:    vfmacc.vv v8, v11, v9
; ZVFBFMIN-NEXT:    ret
  %b.ext = fpext <4 x bfloat> %b to <4 x float>
  %c.ext = fpext <4 x bfloat> %c to <4 x float>
  %res = call <4 x float> @llvm.fma.v4f32(<4 x float> %b.ext, <4 x float> %c.ext, <4 x float> %a)
  ret <4 x float> %res
}

define <4 x float> @vfwmaccbf16_vf_v4f32(<4 x float> %a, bfloat %b, <4 x bfloat> %c) {
; ZVFBFWMA-LABEL: vfwmaccbf16_vf_v4f32:
; ZVFBFWMA:       # %bb.0:
; ZVFBFWMA-NEXT:    fmv.x.h a0, fa0
; ZVFBFWMA-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFBFWMA-NEXT:    vmv.v.x v10, a0
; ZVFBFWMA-NEXT:    vfwmaccbf16.vv v8, v10, v9
; ZVFBFWMA-NEXT:    ret
;
; ZVFBFMIN-LABEL: vfwmaccbf16_vf_v4f32:
; ZVFBFMIN:       # %bb.0:
; ZVFBFMIN-NEXT:    fmv.x.w a0, fa0
; ZVFBFMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFBFMIN-NEXT:    vmv.v.x v10, a0
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v11, v10
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v10, v9
; ZVFBFMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFBFMIN-NEXT:    vfmacc.vv v8, v11, v10
; ZVFBFMIN-NEXT:    ret
  %b.head = insertelement <4 x bfloat> poison, bfloat %b, i32 0
  %b.splat = shufflevector <4 x bfloat> %b.head, <4 x bfloat> poison, <4 x i32> zeroinitializer
  %b.ext = fpext <4 x bfloat> %b.splat to <4 x float>
  %c.ext = fpext <4 x bfloat> %c to <4 x float>
  %res = call <4 x float> @llvm.fma.v4f32(<4 x float> %b.ext, <4 x float> %c.ext, <4 x float> %a)
  ret <4 x float> %res
}

define <8 x float> @vfwmaccbf16_vv_v8f32(<8 x float> %a, <8 x bfloat> %b, <8 x bfloat> %c) {
; ZVFBFWMA-LABEL: vfwmaccbf16_vv_v8f32:
; ZVFBFWMA:       # %bb.0:
; ZVFBFWMA-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFBFWMA-NEXT:    vfwmaccbf16.vv v8, v10, v11
; ZVFBFWMA-NEXT:    ret
;
; ZVFBFMIN-LABEL: vfwmaccbf16_vv_v8f32:
; ZVFBFMIN:       # %bb.0:
; ZVFBFMIN-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v12, v10
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v14, v11
; ZVFBFMIN-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; ZVFBFMIN-NEXT:    vfmacc.vv v8, v12, v14
; ZVFBFMIN-NEXT:    ret
  %b.ext = fpext <8 x bfloat> %b to <8 x float>
  %c.ext = fpext <8 x bfloat> %c to <8 x float>
  %res = call <8 x float> @llvm.fma.v8f32(<8 x float> %b.ext, <8 x float> %c.ext, <8 x float> %a)
  ret <8 x float> %res
}

define <8 x float> @vfwmaccbf16_vf_v8f32(<8 x float> %a, bfloat %b, <8 x bfloat> %c) {
; ZVFBFWMA-LABEL: vfwmaccbf16_vf_v8f32:
; ZVFBFWMA:       # %bb.0:
; ZVFBFWMA-NEXT:    fmv.x.h a0, fa0
; ZVFBFWMA-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFBFWMA-NEXT:    vmv.v.x v11, a0
; ZVFBFWMA-NEXT:    vfwmaccbf16.vv v8, v11, v10
; ZVFBFWMA-NEXT:    ret
;
; ZVFBFMIN-LABEL: vfwmaccbf16_vf_v8f32:
; ZVFBFMIN:       # %bb.0:
; ZVFBFMIN-NEXT:    fmv.x.w a0, fa0
; ZVFBFMIN-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFBFMIN-NEXT:    vmv.v.x v11, a0
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v12, v11
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v14, v10
; ZVFBFMIN-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; ZVFBFMIN-NEXT:    vfmacc.vv v8, v12, v14
; ZVFBFMIN-NEXT:    ret
  %b.head = insertelement <8 x bfloat> poison, bfloat %b, i32 0
  %b.splat = shufflevector <8 x bfloat> %b.head, <8 x bfloat> poison, <8 x i32> zeroinitializer
  %b.ext = fpext <8 x bfloat> %b.splat to <8 x float>
  %c.ext = fpext <8 x bfloat> %c to <8 x float>
  %res = call <8 x float> @llvm.fma.v8f32(<8 x float> %b.ext, <8 x float> %c.ext, <8 x float> %a)
  ret <8 x float> %res
}

define <16 x float> @vfwmaccbf16_vv_v16f32(<16 x float> %a, <16 x bfloat> %b, <16 x bfloat> %c) {
; ZVFBFWMA-LABEL: vfwmaccbf16_vv_v16f32:
; ZVFBFWMA:       # %bb.0:
; ZVFBFWMA-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFBFWMA-NEXT:    vfwmaccbf16.vv v8, v12, v14
; ZVFBFWMA-NEXT:    ret
;
; ZVFBFMIN-LABEL: vfwmaccbf16_vv_v16f32:
; ZVFBFMIN:       # %bb.0:
; ZVFBFMIN-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v16, v12
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v20, v14
; ZVFBFMIN-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; ZVFBFMIN-NEXT:    vfmacc.vv v8, v16, v20
; ZVFBFMIN-NEXT:    ret
  %b.ext = fpext <16 x bfloat> %b to <16 x float>
  %c.ext = fpext <16 x bfloat> %c to <16 x float>
  %res = call <16 x float> @llvm.fma.v16f32(<16 x float> %b.ext, <16 x float> %c.ext, <16 x float> %a)
  ret <16 x float> %res
}

define <16 x float> @vfwmaccbf16_vf_v16f32(<16 x float> %a, bfloat %b, <16 x bfloat> %c) {
; ZVFBFWMA-LABEL: vfwmaccbf16_vf_v16f32:
; ZVFBFWMA:       # %bb.0:
; ZVFBFWMA-NEXT:    fmv.x.h a0, fa0
; ZVFBFWMA-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFBFWMA-NEXT:    vmv.v.x v14, a0
; ZVFBFWMA-NEXT:    vfwmaccbf16.vv v8, v14, v12
; ZVFBFWMA-NEXT:    ret
;
; ZVFBFMIN-LABEL: vfwmaccbf16_vf_v16f32:
; ZVFBFMIN:       # %bb.0:
; ZVFBFMIN-NEXT:    fmv.x.w a0, fa0
; ZVFBFMIN-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFBFMIN-NEXT:    vmv.v.x v14, a0
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v16, v14
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v20, v12
; ZVFBFMIN-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; ZVFBFMIN-NEXT:    vfmacc.vv v8, v16, v20
; ZVFBFMIN-NEXT:    ret
  %b.head = insertelement <16 x bfloat> poison, bfloat %b, i32 0
  %b.splat = shufflevector <16 x bfloat> %b.head, <16 x bfloat> poison, <16 x i32> zeroinitializer
  %b.ext = fpext <16 x bfloat> %b.splat to <16 x float>
  %c.ext = fpext <16 x bfloat> %c to <16 x float>
  %res = call <16 x float> @llvm.fma.v16f32(<16 x float> %b.ext, <16 x float> %c.ext, <16 x float> %a)
  ret <16 x float> %res
}

define <32 x float> @vfwmaccbf32_vv_v32f32(<32 x float> %a, <32 x bfloat> %b, <32 x bfloat> %c) {
; ZVFBFWMA-LABEL: vfwmaccbf32_vv_v32f32:
; ZVFBFWMA:       # %bb.0:
; ZVFBFWMA-NEXT:    li a0, 32
; ZVFBFWMA-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; ZVFBFWMA-NEXT:    vfwmaccbf16.vv v8, v16, v20
; ZVFBFWMA-NEXT:    ret
;
; ZVFBFMIN-LABEL: vfwmaccbf32_vv_v32f32:
; ZVFBFMIN:       # %bb.0:
; ZVFBFMIN-NEXT:    li a0, 32
; ZVFBFMIN-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v24, v16
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v0, v20
; ZVFBFMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFBFMIN-NEXT:    vfmacc.vv v8, v24, v0
; ZVFBFMIN-NEXT:    ret
  %b.ext = fpext <32 x bfloat> %b to <32 x float>
  %c.ext = fpext <32 x bfloat> %c to <32 x float>
  %res = call <32 x float> @llvm.fma.v32f32(<32 x float> %b.ext, <32 x float> %c.ext, <32 x float> %a)
  ret <32 x float> %res
}

define <32 x float> @vfwmaccbf32_vf_v32f32(<32 x float> %a, bfloat %b, <32 x bfloat> %c) {
; ZVFBFWMA-LABEL: vfwmaccbf32_vf_v32f32:
; ZVFBFWMA:       # %bb.0:
; ZVFBFWMA-NEXT:    fmv.x.h a0, fa0
; ZVFBFWMA-NEXT:    li a1, 32
; ZVFBFWMA-NEXT:    vsetvli zero, a1, e16, m4, ta, ma
; ZVFBFWMA-NEXT:    vmv.v.x v20, a0
; ZVFBFWMA-NEXT:    vfwmaccbf16.vv v8, v20, v16
; ZVFBFWMA-NEXT:    ret
;
; ZVFBFMIN-LABEL: vfwmaccbf32_vf_v32f32:
; ZVFBFMIN:       # %bb.0:
; ZVFBFMIN-NEXT:    fmv.x.w a0, fa0
; ZVFBFMIN-NEXT:    li a1, 32
; ZVFBFMIN-NEXT:    vsetvli zero, a1, e16, m4, ta, ma
; ZVFBFMIN-NEXT:    vmv.v.x v20, a0
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v24, v20
; ZVFBFMIN-NEXT:    vfwcvtbf16.f.f.v v0, v16
; ZVFBFMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFBFMIN-NEXT:    vfmacc.vv v8, v24, v0
; ZVFBFMIN-NEXT:    ret
  %b.head = insertelement <32 x bfloat> poison, bfloat %b, i32 0
  %b.splat = shufflevector <32 x bfloat> %b.head, <32 x bfloat> poison, <32 x i32> zeroinitializer
  %b.ext = fpext <32 x bfloat> %b.splat to <32 x float>
  %c.ext = fpext <32 x bfloat> %c to <32 x float>
  %res = call <32 x float> @llvm.fma.v32f32(<32 x float> %b.ext, <32 x float> %c.ext, <32 x float> %a)
  ret <32 x float> %res
}