; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -stress-regalloc=2 -verify-machineinstrs < %s | FileCheck %s -check-prefix=GFX9
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1100 -stress-regalloc=2 -verify-machineinstrs < %s | FileCheck %s -check-prefix=GFX11
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1200 -stress-regalloc=2 -verify-machineinstrs < %s | FileCheck %s -check-prefix=GFX12

define void @test_remat_s_getpc_b64() {
; GFX9-LABEL: test_remat_s_getpc_b64:
; GFX9:       ; %bb.0: ; %entry
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    s_xor_saveexec_b64 s[4:5], -1
; GFX9-NEXT:    buffer_store_dword v2, off, s[0:3], s32 ; 4-byte Folded Spill
; GFX9-NEXT:    s_mov_b64 exec, s[4:5]
; GFX9-NEXT:    v_writelane_b32 v2, s30, 0
; GFX9-NEXT:    s_getpc_b64 s[4:5]
; GFX9-NEXT:    v_writelane_b32 v2, s31, 1
; GFX9-NEXT:    ;;#ASMSTART
; GFX9-NEXT:    ;;#ASMEND
; GFX9-NEXT:    ;;#ASMSTART
; GFX9-NEXT:    ;;#ASMEND
; GFX9-NEXT:    s_getpc_b64 s[4:5]
; GFX9-NEXT:    v_mov_b32_e32 v0, s4
; GFX9-NEXT:    v_mov_b32_e32 v1, s5
; GFX9-NEXT:    global_store_dwordx2 v[0:1], v[0:1], off
; GFX9-NEXT:    v_readlane_b32 s31, v2, 1
; GFX9-NEXT:    v_readlane_b32 s30, v2, 0
; GFX9-NEXT:    s_xor_saveexec_b64 s[4:5], -1
; GFX9-NEXT:    buffer_load_dword v2, off, s[0:3], s32 ; 4-byte Folded Reload
; GFX9-NEXT:    s_mov_b64 exec, s[4:5]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: test_remat_s_getpc_b64:
; GFX11:       ; %bb.0: ; %entry
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    s_xor_saveexec_b32 s0, -1
; GFX11-NEXT:    scratch_store_b32 off, v2, s32 ; 4-byte Folded Spill
; GFX11-NEXT:    s_mov_b32 exec_lo, s0
; GFX11-NEXT:    v_writelane_b32 v2, s30, 0
; GFX11-NEXT:    s_getpc_b64 s[0:1]
; GFX11-NEXT:    ;;#ASMSTART
; GFX11-NEXT:    ;;#ASMEND
; GFX11-NEXT:    v_writelane_b32 v2, s31, 1
; GFX11-NEXT:    ;;#ASMSTART
; GFX11-NEXT:    ;;#ASMEND
; GFX11-NEXT:    s_getpc_b64 s[0:1]
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(VALU_DEP_2)
; GFX11-NEXT:    v_dual_mov_b32 v0, s0 :: v_dual_mov_b32 v1, s1
; GFX11-NEXT:    v_readlane_b32 s31, v2, 1
; GFX11-NEXT:    v_readlane_b32 s30, v2, 0
; GFX11-NEXT:    global_store_b64 v[0:1], v[0:1], off
; GFX11-NEXT:    s_xor_saveexec_b32 s0, -1
; GFX11-NEXT:    scratch_load_b32 v2, off, s32 ; 4-byte Folded Reload
; GFX11-NEXT:    s_mov_b32 exec_lo, s0
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_remat_s_getpc_b64:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    s_xor_saveexec_b32 s0, -1
; GFX12-NEXT:    scratch_store_b32 off, v2, s32 ; 4-byte Folded Spill
; GFX12-NEXT:    s_wait_alu 0xfffe
; GFX12-NEXT:    s_mov_b32 exec_lo, s0
; GFX12-NEXT:    v_writelane_b32 v2, s30, 0
; GFX12-NEXT:    s_getpc_b64 s[0:1]
; GFX12-NEXT:    s_wait_alu 0xfffe
; GFX12-NEXT:    s_sext_i32_i16 s1, s1
; GFX12-NEXT:    ;;#ASMSTART
; GFX12-NEXT:    ;;#ASMEND
; GFX12-NEXT:    v_writelane_b32 v2, s31, 1
; GFX12-NEXT:    ;;#ASMSTART
; GFX12-NEXT:    ;;#ASMEND
; GFX12-NEXT:    s_getpc_b64 s[0:1]
; GFX12-NEXT:    s_wait_alu 0xfffe
; GFX12-NEXT:    s_sext_i32_i16 s1, s1
; GFX12-NEXT:    s_wait_alu 0xfffe
; GFX12-NEXT:    v_dual_mov_b32 v0, s0 :: v_dual_mov_b32 v1, s1
; GFX12-NEXT:    v_readlane_b32 s31, v2, 1
; GFX12-NEXT:    v_readlane_b32 s30, v2, 0
; GFX12-NEXT:    global_store_b64 v[0:1], v[0:1], off
; GFX12-NEXT:    s_xor_saveexec_b32 s0, -1
; GFX12-NEXT:    scratch_load_b32 v2, off, s32 ; 4-byte Folded Reload
; GFX12-NEXT:    s_wait_alu 0xfffe
; GFX12-NEXT:    s_mov_b32 exec_lo, s0
; GFX12-NEXT:    s_wait_loadcnt 0x0
; GFX12-NEXT:    s_wait_alu 0xfffe
; GFX12-NEXT:    s_setpc_b64 s[30:31]
entry:
  %0 = tail call i64 @llvm.amdgcn.s.getpc()
  tail call void asm sideeffect "", "s"(i64 %0)
  tail call void asm sideeffect "", "~{s0},~{s1},~{s2},~{s3},~{s4},~{s5},~{s6},~{s7},~{s8},~{s9},~{s10},~{s11},~{s12},~{s13},~{s14},~{s15},~{s16},~{s17},~{s18},~{s19},~{s20},~{s21},~{s22},~{s23},~{s24},~{s25},~{s26},~{s27},~{s28},~{s29},~{s30},~{s31}"()
  store i64 %0, ptr addrspace(1) undef
  ret void
}

declare i64 @llvm.amdgcn.s.getpc()