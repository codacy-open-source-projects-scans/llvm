; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc < %s -verify-machineinstrs -mtriple=x86_64-unknown-unknown --show-mc-encoding -mattr=+avx10.2-512 | FileCheck %s --check-prefixes=CHECK,X64
; RUN: llc < %s -verify-machineinstrs -mtriple=i686-unknown-unknown --show-mc-encoding -mattr=+avx10.2-512 | FileCheck %s --check-prefixes=CHECK,X86


define <8 x i32> @test_int_x86_mask_vcvtt_pd2dqs_512(<8 x double> %x0, <8 x i32> %src, i8 %mask) {
; X64-LABEL: test_int_x86_mask_vcvtt_pd2dqs_512:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttpd2dqs %zmm0, %ymm1 {%k1} # encoding: [0x62,0xf5,0xfc,0x49,0x6d,0xc8]
; X64-NEXT:    vmovaps %ymm1, %ymm0 # EVEX TO VEX Compression encoding: [0xc5,0xfc,0x28,0xc1]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_pd2dqs_512:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttpd2dqs %zmm0, %ymm1 {%k1} # encoding: [0x62,0xf5,0xfc,0x49,0x6d,0xc8]
; X86-NEXT:    vmovaps %ymm1, %ymm0 # EVEX TO VEX Compression encoding: [0xc5,0xfc,0x28,0xc1]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i32> @llvm.x86.avx10.mask.vcvttpd2dqs.round.512(<8 x double> %x0, <8 x i32> %src, i8 %mask, i32 4)
  ret <8 x i32> %res
}

define <8 x i32> @test_int_x86_maskz_vcvtt_pd2dqs_512_z(<8 x double> %x0, i8 %mask) {
; X64-LABEL: test_int_x86_maskz_vcvtt_pd2dqs_512_z:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttpd2dqs %zmm0, %ymm0 {%k1} {z} # encoding: [0x62,0xf5,0xfc,0xc9,0x6d,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_maskz_vcvtt_pd2dqs_512_z:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttpd2dqs %zmm0, %ymm0 {%k1} {z} # encoding: [0x62,0xf5,0xfc,0xc9,0x6d,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i32> @llvm.x86.avx10.mask.vcvttpd2dqs.round.512(<8 x double> %x0, <8 x i32> zeroinitializer, i8 %mask, i32 4)
  ret <8 x i32> %res
}

define <8 x i32> @test_int_x86_mask_vcvtt_pd2dqs_512_undef(<8 x double> %x0, i8 %mask) {
; X64-LABEL: test_int_x86_mask_vcvtt_pd2dqs_512_undef:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttpd2dqs %zmm0, %ymm0 {%k1} {z} # encoding: [0x62,0xf5,0xfc,0xc9,0x6d,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_pd2dqs_512_undef:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttpd2dqs %zmm0, %ymm0 {%k1} {z} # encoding: [0x62,0xf5,0xfc,0xc9,0x6d,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i32> @llvm.x86.avx10.mask.vcvttpd2dqs.round.512(<8 x double> %x0, <8 x i32> undef, i8 %mask, i32 4)
  ret <8 x i32> %res
}

define <8 x i32> @test_int_x86_mask_vcvtt_pd2dqs_512_default(<8 x double>* %x0) {
; X64-LABEL: test_int_x86_mask_vcvtt_pd2dqs_512_default:
; X64:       # %bb.0:
; X64-NEXT:    vcvttpd2dqs (%rdi), %ymm0 # encoding: [0x62,0xf5,0xfc,0x48,0x6d,0x07]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_pd2dqs_512_default:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-NEXT:    vcvttpd2dqs (%eax), %ymm0 # encoding: [0x62,0xf5,0xfc,0x48,0x6d,0x00]
; X86-NEXT:    retl # encoding: [0xc3]
  %x10 = load <8 x double>, <8 x double> * %x0
  %res = call <8 x i32> @llvm.x86.avx10.mask.vcvttpd2dqs.round.512(<8 x double> %x10, <8 x i32> undef, i8 -1, i32 4)
  ret <8 x i32> %res
}
declare <8 x i32> @llvm.x86.avx10.mask.vcvttpd2dqs.round.512(<8 x double>, <8 x i32>, i8 , i32)

define <8 x i32> @test_int_x86_mask_vcvtt_pd2udqs_512(<8 x double> %x0, <8 x i32> %src, i8 %mask) {
; X64-LABEL: test_int_x86_mask_vcvtt_pd2udqs_512:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttpd2udqs %zmm0, %ymm1 {%k1} # encoding: [0x62,0xf5,0xfc,0x49,0x6c,0xc8]
; X64-NEXT:    vmovaps %ymm1, %ymm0 # EVEX TO VEX Compression encoding: [0xc5,0xfc,0x28,0xc1]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_pd2udqs_512:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttpd2udqs %zmm0, %ymm1 {%k1} # encoding: [0x62,0xf5,0xfc,0x49,0x6c,0xc8]
; X86-NEXT:    vmovaps %ymm1, %ymm0 # EVEX TO VEX Compression encoding: [0xc5,0xfc,0x28,0xc1]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i32> @llvm.x86.avx10.mask.vcvttpd2udqs.round.512(<8 x double> %x0, <8 x i32> %src, i8 %mask, i32 4)
  ret <8 x i32> %res
}

define <8 x i32> @test_int_x86_maskz_vcvtt_pd2udqs_512_z(<8 x double> %x0, i8 %mask) {
; X64-LABEL: test_int_x86_maskz_vcvtt_pd2udqs_512_z:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttpd2udqs %zmm0, %ymm0 {%k1} {z} # encoding: [0x62,0xf5,0xfc,0xc9,0x6c,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_maskz_vcvtt_pd2udqs_512_z:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttpd2udqs %zmm0, %ymm0 {%k1} {z} # encoding: [0x62,0xf5,0xfc,0xc9,0x6c,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i32> @llvm.x86.avx10.mask.vcvttpd2udqs.round.512(<8 x double> %x0, <8 x i32> zeroinitializer, i8 %mask, i32 4)
  ret <8 x i32> %res
}

define <8 x i32> @test_int_x86_mask_vcvtt_pd2udqs_512_undef(<8 x double> %x0, i8 %mask) {
; X64-LABEL: test_int_x86_mask_vcvtt_pd2udqs_512_undef:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttpd2udqs %zmm0, %ymm0 {%k1} {z} # encoding: [0x62,0xf5,0xfc,0xc9,0x6c,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_pd2udqs_512_undef:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttpd2udqs %zmm0, %ymm0 {%k1} {z} # encoding: [0x62,0xf5,0xfc,0xc9,0x6c,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i32> @llvm.x86.avx10.mask.vcvttpd2udqs.round.512(<8 x double> %x0, <8 x i32> undef, i8 %mask, i32 4)
  ret <8 x i32> %res
}

define <8 x i32> @test_int_x86_mask_vcvtt_pd2udqs_512_default(<8 x double>* %x0) {
; X64-LABEL: test_int_x86_mask_vcvtt_pd2udqs_512_default:
; X64:       # %bb.0:
; X64-NEXT:    vcvttpd2udqs (%rdi), %ymm0 # encoding: [0x62,0xf5,0xfc,0x48,0x6c,0x07]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_pd2udqs_512_default:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-NEXT:    vcvttpd2udqs (%eax), %ymm0 # encoding: [0x62,0xf5,0xfc,0x48,0x6c,0x00]
; X86-NEXT:    retl # encoding: [0xc3]
  %x10 = load <8 x double>, <8 x double> * %x0
  %res = call <8 x i32> @llvm.x86.avx10.mask.vcvttpd2udqs.round.512(<8 x double> %x10, <8 x i32> undef, i8 -1, i32 4)
  ret <8 x i32> %res
}
declare <8 x i32> @llvm.x86.avx10.mask.vcvttpd2udqs.round.512(<8 x double>, <8 x i32>, i8 , i32)

define <8 x i64> @test_int_x86_mask_vcvtt_pd2qqs_512(<8 x double> %x0, <8 x i64> %src, i8 %mask) {
; X64-LABEL: test_int_x86_mask_vcvtt_pd2qqs_512:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttpd2qqs %zmm0, %zmm1 {%k1} # encoding: [0x62,0xf5,0xfd,0x49,0x6d,0xc8]
; X64-NEXT:    vmovaps %zmm1, %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x28,0xc1]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_pd2qqs_512:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttpd2qqs %zmm0, %zmm1 {%k1} # encoding: [0x62,0xf5,0xfd,0x49,0x6d,0xc8]
; X86-NEXT:    vmovaps %zmm1, %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x28,0xc1]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i64> @llvm.x86.avx10.mask.vcvttpd2qqs.round.512(<8 x double> %x0, <8 x i64> %src, i8 %mask, i32 4)
  ret <8 x i64> %res
}

define <8 x i64> @test_int_x86_maskz_vcvtt_pd2qqs_512_z(<8 x double> %x0, i8 %mask) {
; X64-LABEL: test_int_x86_maskz_vcvtt_pd2qqs_512_z:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttpd2qqs %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0xfd,0xc9,0x6d,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_maskz_vcvtt_pd2qqs_512_z:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttpd2qqs %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0xfd,0xc9,0x6d,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i64> @llvm.x86.avx10.mask.vcvttpd2qqs.round.512(<8 x double> %x0, <8 x i64> zeroinitializer, i8 %mask, i32 4)
  ret <8 x i64> %res
}

define <8 x i64> @test_int_x86_mask_vcvtt_pd2qqs_512_undef(<8 x double> %x0, i8 %mask) {
; X64-LABEL: test_int_x86_mask_vcvtt_pd2qqs_512_undef:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttpd2qqs %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0xfd,0xc9,0x6d,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_pd2qqs_512_undef:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttpd2qqs %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0xfd,0xc9,0x6d,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i64> @llvm.x86.avx10.mask.vcvttpd2qqs.round.512(<8 x double> %x0, <8 x i64> undef, i8 %mask, i32 4)
  ret <8 x i64> %res
}

define <8 x i64> @test_int_x86_mask_vcvtt_pd2qqs_512_default(<8 x double>* %x0) {
; X64-LABEL: test_int_x86_mask_vcvtt_pd2qqs_512_default:
; X64:       # %bb.0:
; X64-NEXT:    vcvttpd2qqs (%rdi), %zmm0 # encoding: [0x62,0xf5,0xfd,0x48,0x6d,0x07]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_pd2qqs_512_default:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-NEXT:    vcvttpd2qqs (%eax), %zmm0 # encoding: [0x62,0xf5,0xfd,0x48,0x6d,0x00]
; X86-NEXT:    retl # encoding: [0xc3]
  %x10 =  load <8 x double>, <8 x double>* %x0
  %res = call <8 x i64> @llvm.x86.avx10.mask.vcvttpd2qqs.round.512(<8 x double> %x10, <8 x i64> undef, i8 -1, i32 4)
  ret <8 x i64> %res
}
declare <8 x i64> @llvm.x86.avx10.mask.vcvttpd2qqs.round.512(<8 x double>, <8 x i64>, i8 , i32)

define <8 x i64> @test_int_x86_mask_vcvtt_pd2uqqs_512(<8 x double> %x0, <8 x i64> %src, i8 %mask) {
; X64-LABEL: test_int_x86_mask_vcvtt_pd2uqqs_512:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttpd2uqqs %zmm0, %zmm1 {%k1} # encoding: [0x62,0xf5,0xfd,0x49,0x6c,0xc8]
; X64-NEXT:    vmovaps %zmm1, %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x28,0xc1]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_pd2uqqs_512:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttpd2uqqs %zmm0, %zmm1 {%k1} # encoding: [0x62,0xf5,0xfd,0x49,0x6c,0xc8]
; X86-NEXT:    vmovaps %zmm1, %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x28,0xc1]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i64> @llvm.x86.avx10.mask.vcvttpd2uqqs.round.512(<8 x double> %x0, <8 x i64> %src, i8 %mask, i32 4)
  ret <8 x i64> %res
}

define <8 x i64> @test_int_x86_maskz_vcvtt_pd2uqqs_512_z(<8 x double> %x0, i8 %mask) {
; X64-LABEL: test_int_x86_maskz_vcvtt_pd2uqqs_512_z:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttpd2uqqs %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0xfd,0xc9,0x6c,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_maskz_vcvtt_pd2uqqs_512_z:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttpd2uqqs %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0xfd,0xc9,0x6c,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i64> @llvm.x86.avx10.mask.vcvttpd2uqqs.round.512(<8 x double> %x0, <8 x i64> zeroinitializer, i8 %mask, i32 4)
  ret <8 x i64> %res
}

define <8 x i64> @test_int_x86_mask_vcvtt_pd2uqqs_512_undef(<8 x double> %x0, i8 %mask) {
; X64-LABEL: test_int_x86_mask_vcvtt_pd2uqqs_512_undef:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttpd2uqqs %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0xfd,0xc9,0x6c,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_pd2uqqs_512_undef:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttpd2uqqs %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0xfd,0xc9,0x6c,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i64> @llvm.x86.avx10.mask.vcvttpd2uqqs.round.512(<8 x double> %x0, <8 x i64> undef, i8 %mask, i32 4)
  ret <8 x i64> %res
}

define <8 x i64> @test_int_x86_mask_vcvtt_pd2uqqs_512_default(<8 x double>* %x0) {
; X64-LABEL: test_int_x86_mask_vcvtt_pd2uqqs_512_default:
; X64:       # %bb.0:
; X64-NEXT:    vcvttpd2uqqs (%rdi), %zmm0 # encoding: [0x62,0xf5,0xfd,0x48,0x6c,0x07]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_pd2uqqs_512_default:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-NEXT:    vcvttpd2uqqs (%eax), %zmm0 # encoding: [0x62,0xf5,0xfd,0x48,0x6c,0x00]
; X86-NEXT:    retl # encoding: [0xc3]
  %x10 =  load <8 x double>, <8 x double>* %x0
  %res = call <8 x i64> @llvm.x86.avx10.mask.vcvttpd2uqqs.round.512(<8 x double> %x10, <8 x i64> undef, i8 -1, i32 4)
  ret <8 x i64> %res
}
declare <8 x i64> @llvm.x86.avx10.mask.vcvttpd2uqqs.round.512(<8 x double>, <8 x i64>, i8 , i32)

define <16 x i32> @test_int_x86_mask_vcvtt_ps2dqs_512(<16 x float> %x0, <16 x i32> %src, i16 %mask) {
; X64-LABEL: test_int_x86_mask_vcvtt_ps2dqs_512:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttps2dqs %zmm0, %zmm1 {%k1} # encoding: [0x62,0xf5,0x7c,0x49,0x6d,0xc8]
; X64-NEXT:    vmovaps %zmm1, %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x28,0xc1]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_ps2dqs_512:
; X86:       # %bb.0:
; X86-NEXT:    kmovw {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf8,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttps2dqs %zmm0, %zmm1 {%k1} # encoding: [0x62,0xf5,0x7c,0x49,0x6d,0xc8]
; X86-NEXT:    vmovaps %zmm1, %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x28,0xc1]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <16 x i32> @llvm.x86.avx10.mask.vcvttps2dqs.round.512(<16 x float> %x0, <16 x i32> %src, i16 %mask, i32 4)
  ret <16 x i32> %res
}

define <16 x i32> @test_int_x86_maskz_vcvtt_ps2dqs_512_z(<16 x float> %x0, i16 %mask) {
; X64-LABEL: test_int_x86_maskz_vcvtt_ps2dqs_512_z:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttps2dqs %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0x7c,0xc9,0x6d,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_maskz_vcvtt_ps2dqs_512_z:
; X86:       # %bb.0:
; X86-NEXT:    kmovw {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf8,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttps2dqs %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0x7c,0xc9,0x6d,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <16 x i32> @llvm.x86.avx10.mask.vcvttps2dqs.round.512(<16 x float> %x0, <16 x i32> zeroinitializer, i16 %mask, i32 4)
  ret <16 x i32> %res
}

define <16 x i32> @test_int_x86_mask_vcvtt_ps2dqs_512_undef(<16 x float> %x0, i16 %mask) {
; X64-LABEL: test_int_x86_mask_vcvtt_ps2dqs_512_undef:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttps2dqs %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0x7c,0xc9,0x6d,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_ps2dqs_512_undef:
; X86:       # %bb.0:
; X86-NEXT:    kmovw {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf8,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttps2dqs %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0x7c,0xc9,0x6d,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <16 x i32> @llvm.x86.avx10.mask.vcvttps2dqs.round.512(<16 x float> %x0, <16 x i32> undef, i16 %mask, i32 4)
  ret <16 x i32> %res
}

define <16 x i32> @test_int_x86_mask_vcvtt_ps2dqs_512_default(<16 x float>* %x0) {
; X64-LABEL: test_int_x86_mask_vcvtt_ps2dqs_512_default:
; X64:       # %bb.0:
; X64-NEXT:    vcvttps2dqs (%rdi), %zmm0 # encoding: [0x62,0xf5,0x7c,0x48,0x6d,0x07]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_ps2dqs_512_default:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-NEXT:    vcvttps2dqs (%eax), %zmm0 # encoding: [0x62,0xf5,0x7c,0x48,0x6d,0x00]
; X86-NEXT:    retl # encoding: [0xc3]
  %x10 =  load <16 x float>, <16 x float>* %x0
  %res = call <16 x i32> @llvm.x86.avx10.mask.vcvttps2dqs.round.512(<16 x float> %x10, <16 x i32> undef, i16 -1, i32 4)
  ret <16 x i32> %res
}
declare <16 x i32> @llvm.x86.avx10.mask.vcvttps2dqs.round.512(<16 x float>, <16 x i32>, i16 , i32)

define <16 x i32> @test_int_x86_mask_vcvtt_ps2udqs_512(<16 x float> %x0, <16 x i32> %src, i16 %mask) {
; X64-LABEL: test_int_x86_mask_vcvtt_ps2udqs_512:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttps2udqs %zmm0, %zmm1 {%k1} # encoding: [0x62,0xf5,0x7c,0x49,0x6c,0xc8]
; X64-NEXT:    vmovaps %zmm1, %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x28,0xc1]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_ps2udqs_512:
; X86:       # %bb.0:
; X86-NEXT:    kmovw {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf8,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttps2udqs %zmm0, %zmm1 {%k1} # encoding: [0x62,0xf5,0x7c,0x49,0x6c,0xc8]
; X86-NEXT:    vmovaps %zmm1, %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x28,0xc1]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <16 x i32> @llvm.x86.avx10.mask.vcvttps2udqs.round.512(<16 x float> %x0, <16 x i32> %src, i16 %mask, i32 4)
  ret <16 x i32> %res
}

define <16 x i32> @test_int_x86_maskz_vcvtt_ps2udqs_512_z(<16 x float> %x0, i16 %mask) {
; X64-LABEL: test_int_x86_maskz_vcvtt_ps2udqs_512_z:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttps2udqs %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0x7c,0xc9,0x6c,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_maskz_vcvtt_ps2udqs_512_z:
; X86:       # %bb.0:
; X86-NEXT:    kmovw {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf8,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttps2udqs %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0x7c,0xc9,0x6c,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <16 x i32> @llvm.x86.avx10.mask.vcvttps2udqs.round.512(<16 x float> %x0, <16 x i32> zeroinitializer, i16 %mask, i32 4)
  ret <16 x i32> %res
}

define <16 x i32> @test_int_x86_mask_vcvtt_ps2udqs_512_undef(<16 x float> %x0, i16 %mask) {
; X64-LABEL: test_int_x86_mask_vcvtt_ps2udqs_512_undef:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttps2udqs %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0x7c,0xc9,0x6c,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_ps2udqs_512_undef:
; X86:       # %bb.0:
; X86-NEXT:    kmovw {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf8,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttps2udqs %zmm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0x7c,0xc9,0x6c,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <16 x i32> @llvm.x86.avx10.mask.vcvttps2udqs.round.512(<16 x float> %x0, <16 x i32> undef, i16 %mask, i32 4)
  ret <16 x i32> %res
}

define <16 x i32> @test_int_x86_mask_vcvtt_ps2udqs_512_default(<16 x float>* %x0) {
; X64-LABEL: test_int_x86_mask_vcvtt_ps2udqs_512_default:
; X64:       # %bb.0:
; X64-NEXT:    vcvttps2dqs (%rdi), %zmm0 # encoding: [0x62,0xf5,0x7c,0x48,0x6d,0x07]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_ps2udqs_512_default:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-NEXT:    vcvttps2dqs (%eax), %zmm0 # encoding: [0x62,0xf5,0x7c,0x48,0x6d,0x00]
; X86-NEXT:    retl # encoding: [0xc3]
  %x10 =  load <16 x float>, <16 x float>* %x0
  %res = call <16 x i32> @llvm.x86.avx10.mask.vcvttps2dqs.round.512(<16 x float> %x10, <16 x i32> undef, i16 -1, i32 4)
  ret <16 x i32> %res
}
declare <16 x i32> @llvm.x86.avx10.mask.vcvttps2udqs.round.512(<16 x float>, <16 x i32>, i16 , i32)

define <8 x i64> @test_int_x86_mask_vcvtt_ps2qqs_512(<8 x float> %x0, <8 x i64> %src, i8 %mask) {
; X64-LABEL: test_int_x86_mask_vcvtt_ps2qqs_512:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttps2qqs %ymm0, %zmm1 {%k1} # encoding: [0x62,0xf5,0x7d,0x49,0x6d,0xc8]
; X64-NEXT:    vmovaps %zmm1, %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x28,0xc1]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_ps2qqs_512:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttps2qqs %ymm0, %zmm1 {%k1} # encoding: [0x62,0xf5,0x7d,0x49,0x6d,0xc8]
; X86-NEXT:    vmovaps %zmm1, %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x28,0xc1]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i64> @llvm.x86.avx10.mask.vcvttps2qqs.round.512(<8 x float> %x0, <8 x i64> %src, i8 %mask, i32 4)
  ret <8 x i64> %res
}

define <8 x i64> @test_int_x86_maskz_vcvtt_ps2qqs_512_z(<8 x float> %x0, i8 %mask) {
; X64-LABEL: test_int_x86_maskz_vcvtt_ps2qqs_512_z:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttps2qqs %ymm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0x7d,0xc9,0x6d,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_maskz_vcvtt_ps2qqs_512_z:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttps2qqs %ymm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0x7d,0xc9,0x6d,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i64> @llvm.x86.avx10.mask.vcvttps2qqs.round.512(<8 x float> %x0, <8 x i64> zeroinitializer, i8 %mask, i32 4)
  ret <8 x i64> %res
}

define <8 x i64> @test_int_x86_mask_vcvtt_ps2qqs_512_undef(<8 x float> %x0, i8 %mask) {
; X64-LABEL: test_int_x86_mask_vcvtt_ps2qqs_512_undef:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttps2qqs %ymm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0x7d,0xc9,0x6d,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_ps2qqs_512_undef:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttps2qqs %ymm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0x7d,0xc9,0x6d,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i64> @llvm.x86.avx10.mask.vcvttps2qqs.round.512(<8 x float> %x0, <8 x i64> undef, i8 %mask, i32 4)
  ret <8 x i64> %res
}

define <8 x i64> @test_int_x86_mask_vcvtt_ps2qqs_512_default(<8 x float> %x0) {
; CHECK-LABEL: test_int_x86_mask_vcvtt_ps2qqs_512_default:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vcvttps2qqs %ymm0, %zmm0 # encoding: [0x62,0xf5,0x7d,0x48,0x6d,0xc0]
; CHECK-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
  %res = call <8 x i64> @llvm.x86.avx10.mask.vcvttps2qqs.round.512(<8 x float> %x0, <8 x i64> undef, i8 -1, i32 4)
  ret <8 x i64> %res
}
declare <8 x i64> @llvm.x86.avx10.mask.vcvttps2qqs.round.512(<8 x float>, <8 x i64>, i8 , i32)

define <8 x i64> @test_int_x86_mask_vcvtt_ps2uqqs_512(<8 x float> %x0, <8 x i64> %src, i8 %mask) {
; X64-LABEL: test_int_x86_mask_vcvtt_ps2uqqs_512:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttps2uqqs %ymm0, %zmm1 {%k1} # encoding: [0x62,0xf5,0x7d,0x49,0x6c,0xc8]
; X64-NEXT:    vmovaps %zmm1, %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x28,0xc1]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_ps2uqqs_512:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttps2uqqs %ymm0, %zmm1 {%k1} # encoding: [0x62,0xf5,0x7d,0x49,0x6c,0xc8]
; X86-NEXT:    vmovaps %zmm1, %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x28,0xc1]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i64> @llvm.x86.avx10.mask.vcvttps2uqqs.round.512(<8 x float> %x0, <8 x i64> %src, i8 %mask, i32 4)
  ret <8 x i64> %res
}

define <8 x i64> @test_int_x86_maskz_vcvtt_ps2uqqs_512_z(<8 x float> %x0, i8 %mask) {
; X64-LABEL: test_int_x86_maskz_vcvtt_ps2uqqs_512_z:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttps2uqqs %ymm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0x7d,0xc9,0x6c,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_maskz_vcvtt_ps2uqqs_512_z:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttps2uqqs %ymm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0x7d,0xc9,0x6c,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i64> @llvm.x86.avx10.mask.vcvttps2uqqs.round.512(<8 x float> %x0, <8 x i64> zeroinitializer, i8 %mask, i32 4)
  ret <8 x i64> %res
}

define <8 x i64> @test_int_x86_mask_vcvtt_ps2uqqs_512_undef(<8 x float> %x0, i8 %mask) {
; X64-LABEL: test_int_x86_mask_vcvtt_ps2uqqs_512_undef:
; X64:       # %bb.0:
; X64-NEXT:    kmovd %edi, %k1 # encoding: [0xc5,0xfb,0x92,0xcf]
; X64-NEXT:    vcvttps2uqqs %ymm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0x7d,0xc9,0x6c,0xc0]
; X64-NEXT:    retq # encoding: [0xc3]
;
; X86-LABEL: test_int_x86_mask_vcvtt_ps2uqqs_512_undef:
; X86:       # %bb.0:
; X86-NEXT:    kmovb {{[0-9]+}}(%esp), %k1 # encoding: [0xc5,0xf9,0x90,0x4c,0x24,0x04]
; X86-NEXT:    vcvttps2uqqs %ymm0, %zmm0 {%k1} {z} # encoding: [0x62,0xf5,0x7d,0xc9,0x6c,0xc0]
; X86-NEXT:    retl # encoding: [0xc3]
  %res = call <8 x i64> @llvm.x86.avx10.mask.vcvttps2uqqs.round.512(<8 x float> %x0, <8 x i64> undef, i8 %mask, i32 4)
  ret <8 x i64> %res
}

define <8 x i64> @test_int_x86_mask_vcvtt_ps2uqqs_512_default(<8 x float> %x0) {
; CHECK-LABEL: test_int_x86_mask_vcvtt_ps2uqqs_512_default:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vcvttps2uqqs %ymm0, %zmm0 # encoding: [0x62,0xf5,0x7d,0x48,0x6c,0xc0]
; CHECK-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
  %res = call <8 x i64> @llvm.x86.avx10.mask.vcvttps2uqqs.round.512(<8 x float> %x0, <8 x i64> undef, i8 -1, i32 4)
  ret <8 x i64> %res
}
declare <8 x i64> @llvm.x86.avx10.mask.vcvttps2uqqs.round.512(<8 x float>, <8 x i64>, i8 , i32)