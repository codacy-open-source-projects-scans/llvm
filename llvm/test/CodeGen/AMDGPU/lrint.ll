; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --extra_scrub --version 5

; RUN: llc -global-isel=0 -mtriple=amdgcn -mcpu=gfx900 < %s | FileCheck -check-prefixes=GCN,GFX9,GFX9-SDAG %s
; RUN: llc -global-isel=1 -mtriple=amdgcn -mcpu=gfx900 < %s | FileCheck -check-prefixes=GCN,GFX9,GFX9-GISEL %s
; RUN: llc -global-isel=0 -mtriple=amdgcn -mcpu=gfx1010 < %s | FileCheck -check-prefixes=GCN,GFX10,GFX10-SDAG %s
; RUN: llc -global-isel=1 -mtriple=amdgcn -mcpu=gfx1010 < %s | FileCheck -check-prefixes=GCN,GFX10,GFX10-GISEL %s
; RUN: llc -global-isel=0 -mtriple=amdgcn -mcpu=gfx1100 < %s | FileCheck -check-prefixes=GCN,GFX11,GFX11-SDAG %s
; RUN: llc -global-isel=1 -mtriple=amdgcn -mcpu=gfx1100 < %s | FileCheck -check-prefixes=GCN,GFX11,GFX11-GISEL %s

declare float @llvm.rint.f32(float)
declare i32 @llvm.lrint.i32.f32(float)
declare i32 @llvm.lrint.i32.f64(double)
declare i64 @llvm.lrint.i64.f32(float)
declare i64 @llvm.lrint.i64.f64(double)
declare i64 @llvm.llrint.i64.f32(float)
declare half @llvm.rint.f16(half)
declare i32 @llvm.lrint.i32.f16(half %arg)
declare <2 x float> @llvm.rint.v2f32.v2f32(<2 x float> %arg)
declare <2 x i32> @llvm.lrint.v2i32.v2f32(<2 x float> %arg)
declare <2 x i64> @llvm.lrint.v2i64.v2f32(<2 x float> %arg)

define float @intrinsic_frint(float %arg) {
; GCN-LABEL: intrinsic_frint:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_rndne_f32_e32 v0, v0
; GCN-NEXT:    s_setpc_b64 s[30:31]
entry:
  %res = tail call float @llvm.rint.f32(float %arg)
  ret float %res
}

define i32 @intrinsic_lrint_i32_f32(float %arg) {
; GFX9-LABEL: intrinsic_lrint_i32_f32:
; GFX9:       ; %bb.0: ; %entry
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_rndne_f32_e32 v0, v0
; GFX9-NEXT:    v_cvt_i32_f32_e32 v0, v0
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: intrinsic_lrint_i32_f32:
; GFX10:       ; %bb.0: ; %entry
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_rndne_f32_e32 v0, v0
; GFX10-NEXT:    v_cvt_i32_f32_e32 v0, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: intrinsic_lrint_i32_f32:
; GFX11:       ; %bb.0: ; %entry
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_rndne_f32_e32 v0, v0
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_cvt_i32_f32_e32 v0, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
entry:
  %res = tail call i32 @llvm.lrint.i32.f32(float %arg)
  ret i32 %res
}

define i32 @intrinsic_lrint_i32_f64(double %arg) {
; GFX9-LABEL: intrinsic_lrint_i32_f64:
; GFX9:       ; %bb.0: ; %entry
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_rndne_f64_e32 v[0:1], v[0:1]
; GFX9-NEXT:    v_cvt_i32_f64_e32 v0, v[0:1]
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: intrinsic_lrint_i32_f64:
; GFX10:       ; %bb.0: ; %entry
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_rndne_f64_e32 v[0:1], v[0:1]
; GFX10-NEXT:    v_cvt_i32_f64_e32 v0, v[0:1]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: intrinsic_lrint_i32_f64:
; GFX11:       ; %bb.0: ; %entry
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_rndne_f64_e32 v[0:1], v[0:1]
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_cvt_i32_f64_e32 v0, v[0:1]
; GFX11-NEXT:    s_setpc_b64 s[30:31]
entry:
  %res = tail call i32 @llvm.lrint.i32.f64(double %arg)
  ret i32 %res
}

define i64 @intrinsic_lrint_i64_f32(float %arg) {
; GFX9-SDAG-LABEL: intrinsic_lrint_i64_f32:
; GFX9-SDAG:       ; %bb.0: ; %entry
; GFX9-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-SDAG-NEXT:    v_rndne_f32_e32 v0, v0
; GFX9-SDAG-NEXT:    s_mov_b32 s4, 0x2f800000
; GFX9-SDAG-NEXT:    v_mul_f32_e64 v1, |v0|, s4
; GFX9-SDAG-NEXT:    v_floor_f32_e32 v1, v1
; GFX9-SDAG-NEXT:    s_mov_b32 s4, 0xcf800000
; GFX9-SDAG-NEXT:    v_cvt_u32_f32_e32 v2, v1
; GFX9-SDAG-NEXT:    v_fma_f32 v1, v1, s4, |v0|
; GFX9-SDAG-NEXT:    v_cvt_u32_f32_e32 v1, v1
; GFX9-SDAG-NEXT:    v_ashrrev_i32_e32 v3, 31, v0
; GFX9-SDAG-NEXT:    v_xor_b32_e32 v2, v2, v3
; GFX9-SDAG-NEXT:    v_xor_b32_e32 v0, v1, v3
; GFX9-SDAG-NEXT:    v_sub_co_u32_e32 v0, vcc, v0, v3
; GFX9-SDAG-NEXT:    v_subb_co_u32_e32 v1, vcc, v2, v3, vcc
; GFX9-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-GISEL-LABEL: intrinsic_lrint_i64_f32:
; GFX9-GISEL:       ; %bb.0: ; %entry
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-GISEL-NEXT:    v_rndne_f32_e32 v0, v0
; GFX9-GISEL-NEXT:    v_trunc_f32_e32 v1, v0
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v2, 0x2f800000
; GFX9-GISEL-NEXT:    v_mul_f32_e64 v2, |v1|, v2
; GFX9-GISEL-NEXT:    v_floor_f32_e32 v2, v2
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v3, 0xcf800000
; GFX9-GISEL-NEXT:    v_fma_f32 v1, v2, v3, |v1|
; GFX9-GISEL-NEXT:    v_cvt_u32_f32_e32 v1, v1
; GFX9-GISEL-NEXT:    v_cvt_u32_f32_e32 v2, v2
; GFX9-GISEL-NEXT:    v_ashrrev_i32_e32 v3, 31, v0
; GFX9-GISEL-NEXT:    v_xor_b32_e32 v0, v1, v3
; GFX9-GISEL-NEXT:    v_xor_b32_e32 v1, v2, v3
; GFX9-GISEL-NEXT:    v_sub_co_u32_e32 v0, vcc, v0, v3
; GFX9-GISEL-NEXT:    v_subb_co_u32_e32 v1, vcc, v1, v3, vcc
; GFX9-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-SDAG-LABEL: intrinsic_lrint_i64_f32:
; GFX10-SDAG:       ; %bb.0: ; %entry
; GFX10-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-SDAG-NEXT:    v_rndne_f32_e32 v0, v0
; GFX10-SDAG-NEXT:    v_mul_f32_e64 v1, 0x2f800000, |v0|
; GFX10-SDAG-NEXT:    v_ashrrev_i32_e32 v3, 31, v0
; GFX10-SDAG-NEXT:    v_floor_f32_e32 v1, v1
; GFX10-SDAG-NEXT:    v_fma_f32 v2, 0xcf800000, v1, |v0|
; GFX10-SDAG-NEXT:    v_cvt_u32_f32_e32 v1, v1
; GFX10-SDAG-NEXT:    v_cvt_u32_f32_e32 v0, v2
; GFX10-SDAG-NEXT:    v_xor_b32_e32 v1, v1, v3
; GFX10-SDAG-NEXT:    v_xor_b32_e32 v0, v0, v3
; GFX10-SDAG-NEXT:    v_sub_co_u32 v0, vcc_lo, v0, v3
; GFX10-SDAG-NEXT:    v_sub_co_ci_u32_e32 v1, vcc_lo, v1, v3, vcc_lo
; GFX10-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-GISEL-LABEL: intrinsic_lrint_i64_f32:
; GFX10-GISEL:       ; %bb.0: ; %entry
; GFX10-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-GISEL-NEXT:    v_rndne_f32_e32 v0, v0
; GFX10-GISEL-NEXT:    v_trunc_f32_e32 v1, v0
; GFX10-GISEL-NEXT:    v_ashrrev_i32_e32 v3, 31, v0
; GFX10-GISEL-NEXT:    v_mul_f32_e64 v2, 0x2f800000, |v1|
; GFX10-GISEL-NEXT:    v_floor_f32_e32 v2, v2
; GFX10-GISEL-NEXT:    v_fma_f32 v1, 0xcf800000, v2, |v1|
; GFX10-GISEL-NEXT:    v_cvt_u32_f32_e32 v0, v1
; GFX10-GISEL-NEXT:    v_cvt_u32_f32_e32 v1, v2
; GFX10-GISEL-NEXT:    v_xor_b32_e32 v0, v0, v3
; GFX10-GISEL-NEXT:    v_xor_b32_e32 v1, v1, v3
; GFX10-GISEL-NEXT:    v_sub_co_u32 v0, vcc_lo, v0, v3
; GFX10-GISEL-NEXT:    v_sub_co_ci_u32_e32 v1, vcc_lo, v1, v3, vcc_lo
; GFX10-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-SDAG-LABEL: intrinsic_lrint_i64_f32:
; GFX11-SDAG:       ; %bb.0: ; %entry
; GFX11-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-SDAG-NEXT:    v_rndne_f32_e32 v0, v0
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
; GFX11-SDAG-NEXT:    v_mul_f32_e64 v1, 0x2f800000, |v0|
; GFX11-SDAG-NEXT:    v_ashrrev_i32_e32 v3, 31, v0
; GFX11-SDAG-NEXT:    v_floor_f32_e32 v1, v1
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
; GFX11-SDAG-NEXT:    v_fma_f32 v2, 0xcf800000, v1, |v0|
; GFX11-SDAG-NEXT:    v_cvt_u32_f32_e32 v1, v1
; GFX11-SDAG-NEXT:    v_cvt_u32_f32_e32 v0, v2
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
; GFX11-SDAG-NEXT:    v_xor_b32_e32 v1, v1, v3
; GFX11-SDAG-NEXT:    v_xor_b32_e32 v0, v0, v3
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
; GFX11-SDAG-NEXT:    v_sub_co_u32 v0, vcc_lo, v0, v3
; GFX11-SDAG-NEXT:    v_sub_co_ci_u32_e32 v1, vcc_lo, v1, v3, vcc_lo
; GFX11-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-GISEL-LABEL: intrinsic_lrint_i64_f32:
; GFX11-GISEL:       ; %bb.0: ; %entry
; GFX11-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-GISEL-NEXT:    v_rndne_f32_e32 v0, v0
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
; GFX11-GISEL-NEXT:    v_trunc_f32_e32 v1, v0
; GFX11-GISEL-NEXT:    v_ashrrev_i32_e32 v3, 31, v0
; GFX11-GISEL-NEXT:    v_mul_f32_e64 v2, 0x2f800000, |v1|
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
; GFX11-GISEL-NEXT:    v_floor_f32_e32 v2, v2
; GFX11-GISEL-NEXT:    v_fma_f32 v1, 0xcf800000, v2, |v1|
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
; GFX11-GISEL-NEXT:    v_cvt_u32_f32_e32 v0, v1
; GFX11-GISEL-NEXT:    v_cvt_u32_f32_e32 v1, v2
; GFX11-GISEL-NEXT:    v_xor_b32_e32 v0, v0, v3
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
; GFX11-GISEL-NEXT:    v_xor_b32_e32 v1, v1, v3
; GFX11-GISEL-NEXT:    v_sub_co_u32 v0, vcc_lo, v0, v3
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_2)
; GFX11-GISEL-NEXT:    v_sub_co_ci_u32_e32 v1, vcc_lo, v1, v3, vcc_lo
; GFX11-GISEL-NEXT:    s_setpc_b64 s[30:31]
entry:
  %res = tail call i64 @llvm.lrint.i64.f32(float %arg)
  ret i64 %res
}

define i64 @intrinsic_lrint_i64_f64(double %arg) {
; GFX9-SDAG-LABEL: intrinsic_lrint_i64_f64:
; GFX9-SDAG:       ; %bb.0: ; %entry
; GFX9-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-SDAG-NEXT:    v_rndne_f64_e32 v[0:1], v[0:1]
; GFX9-SDAG-NEXT:    s_movk_i32 s4, 0xffe0
; GFX9-SDAG-NEXT:    v_ldexp_f64 v[2:3], v[0:1], s4
; GFX9-SDAG-NEXT:    s_mov_b32 s4, 0
; GFX9-SDAG-NEXT:    s_mov_b32 s5, 0xc1f00000
; GFX9-SDAG-NEXT:    v_floor_f64_e32 v[2:3], v[2:3]
; GFX9-SDAG-NEXT:    v_fma_f64 v[0:1], v[2:3], s[4:5], v[0:1]
; GFX9-SDAG-NEXT:    v_cvt_u32_f64_e32 v0, v[0:1]
; GFX9-SDAG-NEXT:    v_cvt_i32_f64_e32 v1, v[2:3]
; GFX9-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-GISEL-LABEL: intrinsic_lrint_i64_f64:
; GFX9-GISEL:       ; %bb.0: ; %entry
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-GISEL-NEXT:    v_rndne_f64_e32 v[0:1], v[0:1]
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v2, 0
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v3, 0x3df00000
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v4, 0
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v5, 0xc1f00000
; GFX9-GISEL-NEXT:    v_trunc_f64_e32 v[0:1], v[0:1]
; GFX9-GISEL-NEXT:    v_mul_f64 v[2:3], v[0:1], v[2:3]
; GFX9-GISEL-NEXT:    v_floor_f64_e32 v[2:3], v[2:3]
; GFX9-GISEL-NEXT:    v_fma_f64 v[0:1], v[2:3], v[4:5], v[0:1]
; GFX9-GISEL-NEXT:    v_cvt_u32_f64_e32 v0, v[0:1]
; GFX9-GISEL-NEXT:    v_cvt_i32_f64_e32 v1, v[2:3]
; GFX9-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-SDAG-LABEL: intrinsic_lrint_i64_f64:
; GFX10-SDAG:       ; %bb.0: ; %entry
; GFX10-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-SDAG-NEXT:    v_rndne_f64_e32 v[0:1], v[0:1]
; GFX10-SDAG-NEXT:    v_ldexp_f64 v[2:3], v[0:1], 0xffffffe0
; GFX10-SDAG-NEXT:    v_floor_f64_e32 v[2:3], v[2:3]
; GFX10-SDAG-NEXT:    v_fma_f64 v[0:1], 0xc1f00000, v[2:3], v[0:1]
; GFX10-SDAG-NEXT:    v_cvt_u32_f64_e32 v0, v[0:1]
; GFX10-SDAG-NEXT:    v_cvt_i32_f64_e32 v1, v[2:3]
; GFX10-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-GISEL-LABEL: intrinsic_lrint_i64_f64:
; GFX10-GISEL:       ; %bb.0: ; %entry
; GFX10-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-GISEL-NEXT:    v_rndne_f64_e32 v[0:1], v[0:1]
; GFX10-GISEL-NEXT:    v_trunc_f64_e32 v[0:1], v[0:1]
; GFX10-GISEL-NEXT:    v_mul_f64 v[2:3], 0x3df00000, v[0:1]
; GFX10-GISEL-NEXT:    v_floor_f64_e32 v[2:3], v[2:3]
; GFX10-GISEL-NEXT:    v_fma_f64 v[0:1], 0xc1f00000, v[2:3], v[0:1]
; GFX10-GISEL-NEXT:    v_cvt_u32_f64_e32 v0, v[0:1]
; GFX10-GISEL-NEXT:    v_cvt_i32_f64_e32 v1, v[2:3]
; GFX10-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-SDAG-LABEL: intrinsic_lrint_i64_f64:
; GFX11-SDAG:       ; %bb.0: ; %entry
; GFX11-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-SDAG-NEXT:    v_rndne_f64_e32 v[0:1], v[0:1]
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
; GFX11-SDAG-NEXT:    v_ldexp_f64 v[2:3], v[0:1], 0xffffffe0
; GFX11-SDAG-NEXT:    v_floor_f64_e32 v[2:3], v[2:3]
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
; GFX11-SDAG-NEXT:    v_fma_f64 v[0:1], 0xc1f00000, v[2:3], v[0:1]
; GFX11-SDAG-NEXT:    v_cvt_u32_f64_e32 v0, v[0:1]
; GFX11-SDAG-NEXT:    v_cvt_i32_f64_e32 v1, v[2:3]
; GFX11-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-GISEL-LABEL: intrinsic_lrint_i64_f64:
; GFX11-GISEL:       ; %bb.0: ; %entry
; GFX11-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-GISEL-NEXT:    v_rndne_f64_e32 v[0:1], v[0:1]
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
; GFX11-GISEL-NEXT:    v_trunc_f64_e32 v[0:1], v[0:1]
; GFX11-GISEL-NEXT:    v_mul_f64 v[2:3], 0x3df00000, v[0:1]
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
; GFX11-GISEL-NEXT:    v_floor_f64_e32 v[2:3], v[2:3]
; GFX11-GISEL-NEXT:    v_fma_f64 v[0:1], 0xc1f00000, v[2:3], v[0:1]
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-GISEL-NEXT:    v_cvt_u32_f64_e32 v0, v[0:1]
; GFX11-GISEL-NEXT:    v_cvt_i32_f64_e32 v1, v[2:3]
; GFX11-GISEL-NEXT:    s_setpc_b64 s[30:31]
entry:
  %res = tail call i64 @llvm.lrint.i64.f64(double %arg)
  ret i64 %res
}

define i64 @intrinsic_llrint_i64_f32(float %arg) {
; GFX9-SDAG-LABEL: intrinsic_llrint_i64_f32:
; GFX9-SDAG:       ; %bb.0: ; %entry
; GFX9-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-SDAG-NEXT:    v_rndne_f32_e32 v0, v0
; GFX9-SDAG-NEXT:    s_mov_b32 s4, 0x2f800000
; GFX9-SDAG-NEXT:    v_mul_f32_e64 v1, |v0|, s4
; GFX9-SDAG-NEXT:    v_floor_f32_e32 v1, v1
; GFX9-SDAG-NEXT:    s_mov_b32 s4, 0xcf800000
; GFX9-SDAG-NEXT:    v_cvt_u32_f32_e32 v2, v1
; GFX9-SDAG-NEXT:    v_fma_f32 v1, v1, s4, |v0|
; GFX9-SDAG-NEXT:    v_cvt_u32_f32_e32 v1, v1
; GFX9-SDAG-NEXT:    v_ashrrev_i32_e32 v3, 31, v0
; GFX9-SDAG-NEXT:    v_xor_b32_e32 v2, v2, v3
; GFX9-SDAG-NEXT:    v_xor_b32_e32 v0, v1, v3
; GFX9-SDAG-NEXT:    v_sub_co_u32_e32 v0, vcc, v0, v3
; GFX9-SDAG-NEXT:    v_subb_co_u32_e32 v1, vcc, v2, v3, vcc
; GFX9-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-GISEL-LABEL: intrinsic_llrint_i64_f32:
; GFX9-GISEL:       ; %bb.0: ; %entry
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-GISEL-NEXT:    v_rndne_f32_e32 v0, v0
; GFX9-GISEL-NEXT:    v_trunc_f32_e32 v1, v0
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v2, 0x2f800000
; GFX9-GISEL-NEXT:    v_mul_f32_e64 v2, |v1|, v2
; GFX9-GISEL-NEXT:    v_floor_f32_e32 v2, v2
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v3, 0xcf800000
; GFX9-GISEL-NEXT:    v_fma_f32 v1, v2, v3, |v1|
; GFX9-GISEL-NEXT:    v_cvt_u32_f32_e32 v1, v1
; GFX9-GISEL-NEXT:    v_cvt_u32_f32_e32 v2, v2
; GFX9-GISEL-NEXT:    v_ashrrev_i32_e32 v3, 31, v0
; GFX9-GISEL-NEXT:    v_xor_b32_e32 v0, v1, v3
; GFX9-GISEL-NEXT:    v_xor_b32_e32 v1, v2, v3
; GFX9-GISEL-NEXT:    v_sub_co_u32_e32 v0, vcc, v0, v3
; GFX9-GISEL-NEXT:    v_subb_co_u32_e32 v1, vcc, v1, v3, vcc
; GFX9-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-SDAG-LABEL: intrinsic_llrint_i64_f32:
; GFX10-SDAG:       ; %bb.0: ; %entry
; GFX10-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-SDAG-NEXT:    v_rndne_f32_e32 v0, v0
; GFX10-SDAG-NEXT:    v_mul_f32_e64 v1, 0x2f800000, |v0|
; GFX10-SDAG-NEXT:    v_ashrrev_i32_e32 v3, 31, v0
; GFX10-SDAG-NEXT:    v_floor_f32_e32 v1, v1
; GFX10-SDAG-NEXT:    v_fma_f32 v2, 0xcf800000, v1, |v0|
; GFX10-SDAG-NEXT:    v_cvt_u32_f32_e32 v1, v1
; GFX10-SDAG-NEXT:    v_cvt_u32_f32_e32 v0, v2
; GFX10-SDAG-NEXT:    v_xor_b32_e32 v1, v1, v3
; GFX10-SDAG-NEXT:    v_xor_b32_e32 v0, v0, v3
; GFX10-SDAG-NEXT:    v_sub_co_u32 v0, vcc_lo, v0, v3
; GFX10-SDAG-NEXT:    v_sub_co_ci_u32_e32 v1, vcc_lo, v1, v3, vcc_lo
; GFX10-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-GISEL-LABEL: intrinsic_llrint_i64_f32:
; GFX10-GISEL:       ; %bb.0: ; %entry
; GFX10-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-GISEL-NEXT:    v_rndne_f32_e32 v0, v0
; GFX10-GISEL-NEXT:    v_trunc_f32_e32 v1, v0
; GFX10-GISEL-NEXT:    v_ashrrev_i32_e32 v3, 31, v0
; GFX10-GISEL-NEXT:    v_mul_f32_e64 v2, 0x2f800000, |v1|
; GFX10-GISEL-NEXT:    v_floor_f32_e32 v2, v2
; GFX10-GISEL-NEXT:    v_fma_f32 v1, 0xcf800000, v2, |v1|
; GFX10-GISEL-NEXT:    v_cvt_u32_f32_e32 v0, v1
; GFX10-GISEL-NEXT:    v_cvt_u32_f32_e32 v1, v2
; GFX10-GISEL-NEXT:    v_xor_b32_e32 v0, v0, v3
; GFX10-GISEL-NEXT:    v_xor_b32_e32 v1, v1, v3
; GFX10-GISEL-NEXT:    v_sub_co_u32 v0, vcc_lo, v0, v3
; GFX10-GISEL-NEXT:    v_sub_co_ci_u32_e32 v1, vcc_lo, v1, v3, vcc_lo
; GFX10-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-SDAG-LABEL: intrinsic_llrint_i64_f32:
; GFX11-SDAG:       ; %bb.0: ; %entry
; GFX11-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-SDAG-NEXT:    v_rndne_f32_e32 v0, v0
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
; GFX11-SDAG-NEXT:    v_mul_f32_e64 v1, 0x2f800000, |v0|
; GFX11-SDAG-NEXT:    v_ashrrev_i32_e32 v3, 31, v0
; GFX11-SDAG-NEXT:    v_floor_f32_e32 v1, v1
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
; GFX11-SDAG-NEXT:    v_fma_f32 v2, 0xcf800000, v1, |v0|
; GFX11-SDAG-NEXT:    v_cvt_u32_f32_e32 v1, v1
; GFX11-SDAG-NEXT:    v_cvt_u32_f32_e32 v0, v2
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
; GFX11-SDAG-NEXT:    v_xor_b32_e32 v1, v1, v3
; GFX11-SDAG-NEXT:    v_xor_b32_e32 v0, v0, v3
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_3)
; GFX11-SDAG-NEXT:    v_sub_co_u32 v0, vcc_lo, v0, v3
; GFX11-SDAG-NEXT:    v_sub_co_ci_u32_e32 v1, vcc_lo, v1, v3, vcc_lo
; GFX11-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-GISEL-LABEL: intrinsic_llrint_i64_f32:
; GFX11-GISEL:       ; %bb.0: ; %entry
; GFX11-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-GISEL-NEXT:    v_rndne_f32_e32 v0, v0
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
; GFX11-GISEL-NEXT:    v_trunc_f32_e32 v1, v0
; GFX11-GISEL-NEXT:    v_ashrrev_i32_e32 v3, 31, v0
; GFX11-GISEL-NEXT:    v_mul_f32_e64 v2, 0x2f800000, |v1|
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
; GFX11-GISEL-NEXT:    v_floor_f32_e32 v2, v2
; GFX11-GISEL-NEXT:    v_fma_f32 v1, 0xcf800000, v2, |v1|
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_2)
; GFX11-GISEL-NEXT:    v_cvt_u32_f32_e32 v0, v1
; GFX11-GISEL-NEXT:    v_cvt_u32_f32_e32 v1, v2
; GFX11-GISEL-NEXT:    v_xor_b32_e32 v0, v0, v3
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
; GFX11-GISEL-NEXT:    v_xor_b32_e32 v1, v1, v3
; GFX11-GISEL-NEXT:    v_sub_co_u32 v0, vcc_lo, v0, v3
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_2)
; GFX11-GISEL-NEXT:    v_sub_co_ci_u32_e32 v1, vcc_lo, v1, v3, vcc_lo
; GFX11-GISEL-NEXT:    s_setpc_b64 s[30:31]
entry:
  %res = tail call i64 @llvm.llrint.i64.f32(float %arg)
  ret i64 %res
}

define i64 @intrinsic_llrint_i64_f64(double %arg) {
; GFX9-SDAG-LABEL: intrinsic_llrint_i64_f64:
; GFX9-SDAG:       ; %bb.0: ; %entry
; GFX9-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-SDAG-NEXT:    v_rndne_f64_e32 v[0:1], v[0:1]
; GFX9-SDAG-NEXT:    s_movk_i32 s4, 0xffe0
; GFX9-SDAG-NEXT:    v_ldexp_f64 v[2:3], v[0:1], s4
; GFX9-SDAG-NEXT:    s_mov_b32 s4, 0
; GFX9-SDAG-NEXT:    s_mov_b32 s5, 0xc1f00000
; GFX9-SDAG-NEXT:    v_floor_f64_e32 v[2:3], v[2:3]
; GFX9-SDAG-NEXT:    v_fma_f64 v[0:1], v[2:3], s[4:5], v[0:1]
; GFX9-SDAG-NEXT:    v_cvt_u32_f64_e32 v0, v[0:1]
; GFX9-SDAG-NEXT:    v_cvt_i32_f64_e32 v1, v[2:3]
; GFX9-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-GISEL-LABEL: intrinsic_llrint_i64_f64:
; GFX9-GISEL:       ; %bb.0: ; %entry
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-GISEL-NEXT:    v_rndne_f64_e32 v[0:1], v[0:1]
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v2, 0
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v3, 0x3df00000
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v4, 0
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v5, 0xc1f00000
; GFX9-GISEL-NEXT:    v_trunc_f64_e32 v[0:1], v[0:1]
; GFX9-GISEL-NEXT:    v_mul_f64 v[2:3], v[0:1], v[2:3]
; GFX9-GISEL-NEXT:    v_floor_f64_e32 v[2:3], v[2:3]
; GFX9-GISEL-NEXT:    v_fma_f64 v[0:1], v[2:3], v[4:5], v[0:1]
; GFX9-GISEL-NEXT:    v_cvt_u32_f64_e32 v0, v[0:1]
; GFX9-GISEL-NEXT:    v_cvt_i32_f64_e32 v1, v[2:3]
; GFX9-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-SDAG-LABEL: intrinsic_llrint_i64_f64:
; GFX10-SDAG:       ; %bb.0: ; %entry
; GFX10-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-SDAG-NEXT:    v_rndne_f64_e32 v[0:1], v[0:1]
; GFX10-SDAG-NEXT:    v_ldexp_f64 v[2:3], v[0:1], 0xffffffe0
; GFX10-SDAG-NEXT:    v_floor_f64_e32 v[2:3], v[2:3]
; GFX10-SDAG-NEXT:    v_fma_f64 v[0:1], 0xc1f00000, v[2:3], v[0:1]
; GFX10-SDAG-NEXT:    v_cvt_u32_f64_e32 v0, v[0:1]
; GFX10-SDAG-NEXT:    v_cvt_i32_f64_e32 v1, v[2:3]
; GFX10-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-GISEL-LABEL: intrinsic_llrint_i64_f64:
; GFX10-GISEL:       ; %bb.0: ; %entry
; GFX10-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-GISEL-NEXT:    v_rndne_f64_e32 v[0:1], v[0:1]
; GFX10-GISEL-NEXT:    v_trunc_f64_e32 v[0:1], v[0:1]
; GFX10-GISEL-NEXT:    v_mul_f64 v[2:3], 0x3df00000, v[0:1]
; GFX10-GISEL-NEXT:    v_floor_f64_e32 v[2:3], v[2:3]
; GFX10-GISEL-NEXT:    v_fma_f64 v[0:1], 0xc1f00000, v[2:3], v[0:1]
; GFX10-GISEL-NEXT:    v_cvt_u32_f64_e32 v0, v[0:1]
; GFX10-GISEL-NEXT:    v_cvt_i32_f64_e32 v1, v[2:3]
; GFX10-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-SDAG-LABEL: intrinsic_llrint_i64_f64:
; GFX11-SDAG:       ; %bb.0: ; %entry
; GFX11-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-SDAG-NEXT:    v_rndne_f64_e32 v[0:1], v[0:1]
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
; GFX11-SDAG-NEXT:    v_ldexp_f64 v[2:3], v[0:1], 0xffffffe0
; GFX11-SDAG-NEXT:    v_floor_f64_e32 v[2:3], v[2:3]
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
; GFX11-SDAG-NEXT:    v_fma_f64 v[0:1], 0xc1f00000, v[2:3], v[0:1]
; GFX11-SDAG-NEXT:    v_cvt_u32_f64_e32 v0, v[0:1]
; GFX11-SDAG-NEXT:    v_cvt_i32_f64_e32 v1, v[2:3]
; GFX11-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-GISEL-LABEL: intrinsic_llrint_i64_f64:
; GFX11-GISEL:       ; %bb.0: ; %entry
; GFX11-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-GISEL-NEXT:    v_rndne_f64_e32 v[0:1], v[0:1]
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
; GFX11-GISEL-NEXT:    v_trunc_f64_e32 v[0:1], v[0:1]
; GFX11-GISEL-NEXT:    v_mul_f64 v[2:3], 0x3df00000, v[0:1]
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
; GFX11-GISEL-NEXT:    v_floor_f64_e32 v[2:3], v[2:3]
; GFX11-GISEL-NEXT:    v_fma_f64 v[0:1], 0xc1f00000, v[2:3], v[0:1]
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-GISEL-NEXT:    v_cvt_u32_f64_e32 v0, v[0:1]
; GFX11-GISEL-NEXT:    v_cvt_i32_f64_e32 v1, v[2:3]
; GFX11-GISEL-NEXT:    s_setpc_b64 s[30:31]
entry:
  %res = tail call i64 @llvm.llrint.i64.f64(double %arg)
  ret i64 %res
}

define half @intrinsic_frint_half(half %arg) {
; GCN-LABEL: intrinsic_frint_half:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_rndne_f16_e32 v0, v0
; GCN-NEXT:    s_setpc_b64 s[30:31]
entry:
  %res = tail call half @llvm.rint.f16(half %arg)
  ret half %res
}

define i32 @intrinsic_lrint_i32_f16(half %arg) {
; GFX9-LABEL: intrinsic_lrint_i32_f16:
; GFX9:       ; %bb.0: ; %entry
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_rndne_f16_e32 v0, v0
; GFX9-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX9-NEXT:    v_cvt_i32_f32_e32 v0, v0
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: intrinsic_lrint_i32_f16:
; GFX10:       ; %bb.0: ; %entry
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_rndne_f16_e32 v0, v0
; GFX10-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX10-NEXT:    v_cvt_i32_f32_e32 v0, v0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: intrinsic_lrint_i32_f16:
; GFX11:       ; %bb.0: ; %entry
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_rndne_f16_e32 v0, v0
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
; GFX11-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX11-NEXT:    v_cvt_i32_f32_e32 v0, v0
; GFX11-NEXT:    s_setpc_b64 s[30:31]
entry:
  %res = tail call i32 @llvm.lrint.i32.f16(half %arg)
  ret i32 %res
}

define <2 x float> @intrinsic_frint_v2f32_v2f32(<2 x float> %arg) {
; GCN-LABEL: intrinsic_frint_v2f32_v2f32:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_rndne_f32_e32 v0, v0
; GCN-NEXT:    v_rndne_f32_e32 v1, v1
; GCN-NEXT:    s_setpc_b64 s[30:31]
entry:
  %res = tail call <2 x float> @llvm.rint.v2f32.v2f32(<2 x float> %arg)
  ret <2 x float> %res
}

define <2 x i32> @intrinsic_lrint_v2i32_v2f32(<2 x float> %arg) {
; GFX9-LABEL: intrinsic_lrint_v2i32_v2f32:
; GFX9:       ; %bb.0: ; %entry
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_rndne_f32_e32 v0, v0
; GFX9-NEXT:    v_rndne_f32_e32 v1, v1
; GFX9-NEXT:    v_cvt_i32_f32_e32 v0, v0
; GFX9-NEXT:    v_cvt_i32_f32_e32 v1, v1
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: intrinsic_lrint_v2i32_v2f32:
; GFX10:       ; %bb.0: ; %entry
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_rndne_f32_e32 v0, v0
; GFX10-NEXT:    v_rndne_f32_e32 v1, v1
; GFX10-NEXT:    v_cvt_i32_f32_e32 v0, v0
; GFX10-NEXT:    v_cvt_i32_f32_e32 v1, v1
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: intrinsic_lrint_v2i32_v2f32:
; GFX11:       ; %bb.0: ; %entry
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_rndne_f32_e32 v0, v0
; GFX11-NEXT:    v_rndne_f32_e32 v1, v1
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
; GFX11-NEXT:    v_cvt_i32_f32_e32 v0, v0
; GFX11-NEXT:    v_cvt_i32_f32_e32 v1, v1
; GFX11-NEXT:    s_setpc_b64 s[30:31]
entry:
  %res = tail call <2 x i32> @llvm.lrint.v2i32.v2f32(<2 x float> %arg)
  ret <2 x i32> %res
}

define <2 x i64> @intrinsic_lrint_v2i64_v2f32(<2 x float> %arg) {
; GFX9-SDAG-LABEL: intrinsic_lrint_v2i64_v2f32:
; GFX9-SDAG:       ; %bb.0: ; %entry
; GFX9-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-SDAG-NEXT:    v_rndne_f32_e32 v0, v0
; GFX9-SDAG-NEXT:    s_mov_b32 s4, 0x2f800000
; GFX9-SDAG-NEXT:    v_mul_f32_e64 v2, |v0|, s4
; GFX9-SDAG-NEXT:    v_floor_f32_e32 v2, v2
; GFX9-SDAG-NEXT:    s_mov_b32 s5, 0xcf800000
; GFX9-SDAG-NEXT:    v_cvt_u32_f32_e32 v3, v2
; GFX9-SDAG-NEXT:    v_fma_f32 v2, v2, s5, |v0|
; GFX9-SDAG-NEXT:    v_cvt_u32_f32_e32 v2, v2
; GFX9-SDAG-NEXT:    v_ashrrev_i32_e32 v4, 31, v0
; GFX9-SDAG-NEXT:    v_xor_b32_e32 v3, v3, v4
; GFX9-SDAG-NEXT:    v_xor_b32_e32 v0, v2, v4
; GFX9-SDAG-NEXT:    v_rndne_f32_e32 v2, v1
; GFX9-SDAG-NEXT:    v_mul_f32_e64 v1, |v2|, s4
; GFX9-SDAG-NEXT:    v_floor_f32_e32 v1, v1
; GFX9-SDAG-NEXT:    v_cvt_u32_f32_e32 v5, v1
; GFX9-SDAG-NEXT:    v_fma_f32 v1, v1, s5, |v2|
; GFX9-SDAG-NEXT:    v_cvt_u32_f32_e32 v6, v1
; GFX9-SDAG-NEXT:    v_sub_co_u32_e32 v0, vcc, v0, v4
; GFX9-SDAG-NEXT:    v_subb_co_u32_e32 v1, vcc, v3, v4, vcc
; GFX9-SDAG-NEXT:    v_ashrrev_i32_e32 v3, 31, v2
; GFX9-SDAG-NEXT:    v_xor_b32_e32 v2, v6, v3
; GFX9-SDAG-NEXT:    v_xor_b32_e32 v4, v5, v3
; GFX9-SDAG-NEXT:    v_sub_co_u32_e32 v2, vcc, v2, v3
; GFX9-SDAG-NEXT:    v_subb_co_u32_e32 v3, vcc, v4, v3, vcc
; GFX9-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-GISEL-LABEL: intrinsic_lrint_v2i64_v2f32:
; GFX9-GISEL:       ; %bb.0: ; %entry
; GFX9-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-GISEL-NEXT:    v_rndne_f32_e32 v0, v0
; GFX9-GISEL-NEXT:    v_trunc_f32_e32 v2, v0
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v3, 0x2f800000
; GFX9-GISEL-NEXT:    v_mul_f32_e64 v4, |v2|, v3
; GFX9-GISEL-NEXT:    v_floor_f32_e32 v4, v4
; GFX9-GISEL-NEXT:    v_mov_b32_e32 v5, 0xcf800000
; GFX9-GISEL-NEXT:    v_fma_f32 v2, v4, v5, |v2|
; GFX9-GISEL-NEXT:    v_cvt_u32_f32_e32 v2, v2
; GFX9-GISEL-NEXT:    v_cvt_u32_f32_e32 v4, v4
; GFX9-GISEL-NEXT:    v_ashrrev_i32_e32 v6, 31, v0
; GFX9-GISEL-NEXT:    v_xor_b32_e32 v0, v2, v6
; GFX9-GISEL-NEXT:    v_xor_b32_e32 v2, v4, v6
; GFX9-GISEL-NEXT:    v_rndne_f32_e32 v4, v1
; GFX9-GISEL-NEXT:    v_trunc_f32_e32 v1, v4
; GFX9-GISEL-NEXT:    v_mul_f32_e64 v3, |v1|, v3
; GFX9-GISEL-NEXT:    v_floor_f32_e32 v3, v3
; GFX9-GISEL-NEXT:    v_fma_f32 v1, v3, v5, |v1|
; GFX9-GISEL-NEXT:    v_cvt_u32_f32_e32 v5, v1
; GFX9-GISEL-NEXT:    v_cvt_u32_f32_e32 v3, v3
; GFX9-GISEL-NEXT:    v_sub_co_u32_e32 v0, vcc, v0, v6
; GFX9-GISEL-NEXT:    v_ashrrev_i32_e32 v4, 31, v4
; GFX9-GISEL-NEXT:    v_subb_co_u32_e32 v1, vcc, v2, v6, vcc
; GFX9-GISEL-NEXT:    v_xor_b32_e32 v2, v5, v4
; GFX9-GISEL-NEXT:    v_xor_b32_e32 v3, v3, v4
; GFX9-GISEL-NEXT:    v_sub_co_u32_e32 v2, vcc, v2, v4
; GFX9-GISEL-NEXT:    v_subb_co_u32_e32 v3, vcc, v3, v4, vcc
; GFX9-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-SDAG-LABEL: intrinsic_lrint_v2i64_v2f32:
; GFX10-SDAG:       ; %bb.0: ; %entry
; GFX10-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-SDAG-NEXT:    v_rndne_f32_e32 v0, v0
; GFX10-SDAG-NEXT:    v_rndne_f32_e32 v1, v1
; GFX10-SDAG-NEXT:    v_mul_f32_e64 v2, 0x2f800000, |v0|
; GFX10-SDAG-NEXT:    v_mul_f32_e64 v3, 0x2f800000, |v1|
; GFX10-SDAG-NEXT:    v_ashrrev_i32_e32 v5, 31, v0
; GFX10-SDAG-NEXT:    v_ashrrev_i32_e32 v6, 31, v1
; GFX10-SDAG-NEXT:    v_floor_f32_e32 v2, v2
; GFX10-SDAG-NEXT:    v_floor_f32_e32 v3, v3
; GFX10-SDAG-NEXT:    v_fma_f32 v4, 0xcf800000, v2, |v0|
; GFX10-SDAG-NEXT:    v_fma_f32 v0, 0xcf800000, v3, |v1|
; GFX10-SDAG-NEXT:    v_cvt_u32_f32_e32 v2, v2
; GFX10-SDAG-NEXT:    v_cvt_u32_f32_e32 v3, v3
; GFX10-SDAG-NEXT:    v_cvt_u32_f32_e32 v1, v4
; GFX10-SDAG-NEXT:    v_cvt_u32_f32_e32 v0, v0
; GFX10-SDAG-NEXT:    v_xor_b32_e32 v2, v2, v5
; GFX10-SDAG-NEXT:    v_xor_b32_e32 v3, v3, v6
; GFX10-SDAG-NEXT:    v_xor_b32_e32 v1, v1, v5
; GFX10-SDAG-NEXT:    v_xor_b32_e32 v4, v0, v6
; GFX10-SDAG-NEXT:    v_sub_co_u32 v0, vcc_lo, v1, v5
; GFX10-SDAG-NEXT:    v_sub_co_ci_u32_e32 v1, vcc_lo, v2, v5, vcc_lo
; GFX10-SDAG-NEXT:    v_sub_co_u32 v2, vcc_lo, v4, v6
; GFX10-SDAG-NEXT:    v_sub_co_ci_u32_e32 v3, vcc_lo, v3, v6, vcc_lo
; GFX10-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-GISEL-LABEL: intrinsic_lrint_v2i64_v2f32:
; GFX10-GISEL:       ; %bb.0: ; %entry
; GFX10-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-GISEL-NEXT:    v_rndne_f32_e32 v0, v0
; GFX10-GISEL-NEXT:    v_rndne_f32_e32 v1, v1
; GFX10-GISEL-NEXT:    v_trunc_f32_e32 v2, v0
; GFX10-GISEL-NEXT:    v_trunc_f32_e32 v3, v1
; GFX10-GISEL-NEXT:    v_ashrrev_i32_e32 v6, 31, v0
; GFX10-GISEL-NEXT:    v_mul_f32_e64 v4, 0x2f800000, |v2|
; GFX10-GISEL-NEXT:    v_mul_f32_e64 v5, 0x2f800000, |v3|
; GFX10-GISEL-NEXT:    v_floor_f32_e32 v4, v4
; GFX10-GISEL-NEXT:    v_floor_f32_e32 v5, v5
; GFX10-GISEL-NEXT:    v_fma_f32 v2, 0xcf800000, v4, |v2|
; GFX10-GISEL-NEXT:    v_fma_f32 v0, 0xcf800000, v5, |v3|
; GFX10-GISEL-NEXT:    v_ashrrev_i32_e32 v3, 31, v1
; GFX10-GISEL-NEXT:    v_cvt_u32_f32_e32 v1, v2
; GFX10-GISEL-NEXT:    v_cvt_u32_f32_e32 v2, v4
; GFX10-GISEL-NEXT:    v_cvt_u32_f32_e32 v0, v0
; GFX10-GISEL-NEXT:    v_cvt_u32_f32_e32 v4, v5
; GFX10-GISEL-NEXT:    v_xor_b32_e32 v1, v1, v6
; GFX10-GISEL-NEXT:    v_xor_b32_e32 v2, v2, v6
; GFX10-GISEL-NEXT:    v_xor_b32_e32 v5, v0, v3
; GFX10-GISEL-NEXT:    v_xor_b32_e32 v4, v4, v3
; GFX10-GISEL-NEXT:    v_sub_co_u32 v0, vcc_lo, v1, v6
; GFX10-GISEL-NEXT:    v_sub_co_ci_u32_e32 v1, vcc_lo, v2, v6, vcc_lo
; GFX10-GISEL-NEXT:    v_sub_co_u32 v2, vcc_lo, v5, v3
; GFX10-GISEL-NEXT:    v_sub_co_ci_u32_e32 v3, vcc_lo, v4, v3, vcc_lo
; GFX10-GISEL-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-SDAG-LABEL: intrinsic_lrint_v2i64_v2f32:
; GFX11-SDAG:       ; %bb.0: ; %entry
; GFX11-SDAG-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-SDAG-NEXT:    v_rndne_f32_e32 v0, v0
; GFX11-SDAG-NEXT:    v_rndne_f32_e32 v1, v1
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
; GFX11-SDAG-NEXT:    v_mul_f32_e64 v2, 0x2f800000, |v0|
; GFX11-SDAG-NEXT:    v_mul_f32_e64 v3, 0x2f800000, |v1|
; GFX11-SDAG-NEXT:    v_ashrrev_i32_e32 v5, 31, v0
; GFX11-SDAG-NEXT:    v_ashrrev_i32_e32 v6, 31, v1
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
; GFX11-SDAG-NEXT:    v_floor_f32_e32 v2, v2
; GFX11-SDAG-NEXT:    v_floor_f32_e32 v3, v3
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
; GFX11-SDAG-NEXT:    v_fma_f32 v4, 0xcf800000, v2, |v0|
; GFX11-SDAG-NEXT:    v_fma_f32 v0, 0xcf800000, v3, |v1|
; GFX11-SDAG-NEXT:    v_cvt_u32_f32_e32 v2, v2
; GFX11-SDAG-NEXT:    v_cvt_u32_f32_e32 v3, v3
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
; GFX11-SDAG-NEXT:    v_cvt_u32_f32_e32 v1, v4
; GFX11-SDAG-NEXT:    v_cvt_u32_f32_e32 v0, v0
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
; GFX11-SDAG-NEXT:    v_xor_b32_e32 v2, v2, v5
; GFX11-SDAG-NEXT:    v_xor_b32_e32 v3, v3, v6
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
; GFX11-SDAG-NEXT:    v_xor_b32_e32 v1, v1, v5
; GFX11-SDAG-NEXT:    v_xor_b32_e32 v4, v0, v6
; GFX11-SDAG-NEXT:    s_delay_alu instid0(VALU_DEP_2) | instskip(SKIP_1) | instid1(VALU_DEP_3)
; GFX11-SDAG-NEXT:    v_sub_co_u32 v0, vcc_lo, v1, v5
; GFX11-SDAG-NEXT:    v_sub_co_ci_u32_e32 v1, vcc_lo, v2, v5, vcc_lo
; GFX11-SDAG-NEXT:    v_sub_co_u32 v2, vcc_lo, v4, v6
; GFX11-SDAG-NEXT:    v_sub_co_ci_u32_e32 v3, vcc_lo, v3, v6, vcc_lo
; GFX11-SDAG-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-GISEL-LABEL: intrinsic_lrint_v2i64_v2f32:
; GFX11-GISEL:       ; %bb.0: ; %entry
; GFX11-GISEL-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-GISEL-NEXT:    v_rndne_f32_e32 v0, v0
; GFX11-GISEL-NEXT:    v_rndne_f32_e32 v1, v1
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
; GFX11-GISEL-NEXT:    v_trunc_f32_e32 v2, v0
; GFX11-GISEL-NEXT:    v_trunc_f32_e32 v3, v1
; GFX11-GISEL-NEXT:    v_ashrrev_i32_e32 v6, 31, v0
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_3) | instskip(NEXT) | instid1(VALU_DEP_3)
; GFX11-GISEL-NEXT:    v_mul_f32_e64 v4, 0x2f800000, |v2|
; GFX11-GISEL-NEXT:    v_mul_f32_e64 v5, 0x2f800000, |v3|
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
; GFX11-GISEL-NEXT:    v_floor_f32_e32 v4, v4
; GFX11-GISEL-NEXT:    v_floor_f32_e32 v5, v5
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_2) | instskip(NEXT) | instid1(VALU_DEP_2)
; GFX11-GISEL-NEXT:    v_fma_f32 v2, 0xcf800000, v4, |v2|
; GFX11-GISEL-NEXT:    v_fma_f32 v0, 0xcf800000, v5, |v3|
; GFX11-GISEL-NEXT:    v_ashrrev_i32_e32 v3, 31, v1
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_3) | instskip(SKIP_1) | instid1(VALU_DEP_4)
; GFX11-GISEL-NEXT:    v_cvt_u32_f32_e32 v1, v2
; GFX11-GISEL-NEXT:    v_cvt_u32_f32_e32 v2, v4
; GFX11-GISEL-NEXT:    v_cvt_u32_f32_e32 v0, v0
; GFX11-GISEL-NEXT:    v_cvt_u32_f32_e32 v4, v5
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
; GFX11-GISEL-NEXT:    v_xor_b32_e32 v1, v1, v6
; GFX11-GISEL-NEXT:    v_xor_b32_e32 v2, v2, v6
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
; GFX11-GISEL-NEXT:    v_xor_b32_e32 v5, v0, v3
; GFX11-GISEL-NEXT:    v_xor_b32_e32 v4, v4, v3
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
; GFX11-GISEL-NEXT:    v_sub_co_u32 v0, vcc_lo, v1, v6
; GFX11-GISEL-NEXT:    v_sub_co_ci_u32_e32 v1, vcc_lo, v2, v6, vcc_lo
; GFX11-GISEL-NEXT:    s_delay_alu instid0(VALU_DEP_4) | instskip(NEXT) | instid1(VALU_DEP_4)
; GFX11-GISEL-NEXT:    v_sub_co_u32 v2, vcc_lo, v5, v3
; GFX11-GISEL-NEXT:    v_sub_co_ci_u32_e32 v3, vcc_lo, v4, v3, vcc_lo
; GFX11-GISEL-NEXT:    s_setpc_b64 s[30:31]
entry:
  %res = tail call <2 x i64> @llvm.lrint.v2i64.v2f32(<2 x float> %arg)
  ret <2 x i64> %res
}
