; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown -mattr=+sse4.1 -show-mc-encoding | FileCheck %s --check-prefixes=SSE,X86-SSE
; RUN: llc < %s -mtriple=i686-unknown -mattr=+avx -show-mc-encoding | FileCheck %s --check-prefixes=AVX,X86-AVX
; RUN: llc < %s -mtriple=i686-unknown -mattr=+avx512vl -show-mc-encoding | FileCheck %s --check-prefixes=AVX512VL,X86-AVX512VL
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+sse4.1 -show-mc-encoding | FileCheck %s --check-prefixes=SSE,X64-SSE
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx -show-mc-encoding | FileCheck %s --check-prefixes=AVX,X64-AVX
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx512vl -show-mc-encoding | FileCheck %s --check-prefixes=AVX512VL,X64-AVX512VL

define <2 x double> @fpext_4f32_to_2f64(<4 x float> %a) {
; SSE-LABEL: fpext_4f32_to_2f64:
; SSE:       # %bb.0:
; SSE-NEXT:    cvtps2pd %xmm0, %xmm0 # encoding: [0x0f,0x5a,0xc0]
; SSE-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
;
; AVX-LABEL: fpext_4f32_to_2f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvtps2pd %xmm0, %xmm0 # encoding: [0xc5,0xf8,0x5a,0xc0]
; AVX-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
;
; AVX512VL-LABEL: fpext_4f32_to_2f64:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vcvtps2pd %xmm0, %xmm0 # EVEX TO VEX Compression encoding: [0xc5,0xf8,0x5a,0xc0]
; AVX512VL-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
  %cvt = fpext <4 x float> %a to <4 x double>
  %shuf = shufflevector <4 x double> %cvt, <4 x double> undef, <2 x i32> <i32 0, i32 1>
  ret <2 x double> %shuf
}

define <2 x double> @fpext_8f32_to_2f64(<8 x float> %a) {
; SSE-LABEL: fpext_8f32_to_2f64:
; SSE:       # %bb.0:
; SSE-NEXT:    cvtps2pd %xmm0, %xmm0 # encoding: [0x0f,0x5a,0xc0]
; SSE-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
;
; AVX-LABEL: fpext_8f32_to_2f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvtps2pd %xmm0, %xmm0 # encoding: [0xc5,0xf8,0x5a,0xc0]
; AVX-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; AVX-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
;
; AVX512VL-LABEL: fpext_8f32_to_2f64:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vcvtps2pd %ymm0, %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x5a,0xc0]
; AVX512VL-NEXT:    # kill: def $xmm0 killed $xmm0 killed $zmm0
; AVX512VL-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; AVX512VL-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
  %cvt = fpext <8 x float> %a to <8 x double>
  %shuf = shufflevector <8 x double> %cvt, <8 x double> undef, <2 x i32> <i32 0, i32 1>
  ret <2 x double> %shuf
}

define <4 x double> @fpext_8f32_to_4f64(<8 x float> %a) {
; SSE-LABEL: fpext_8f32_to_4f64:
; SSE:       # %bb.0:
; SSE-NEXT:    cvtps2pd %xmm0, %xmm2 # encoding: [0x0f,0x5a,0xd0]
; SSE-NEXT:    movhlps %xmm0, %xmm0 # encoding: [0x0f,0x12,0xc0]
; SSE-NEXT:    # xmm0 = xmm0[1,1]
; SSE-NEXT:    cvtps2pd %xmm0, %xmm1 # encoding: [0x0f,0x5a,0xc8]
; SSE-NEXT:    movaps %xmm2, %xmm0 # encoding: [0x0f,0x28,0xc2]
; SSE-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
;
; AVX-LABEL: fpext_8f32_to_4f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvtps2pd %xmm0, %ymm0 # encoding: [0xc5,0xfc,0x5a,0xc0]
; AVX-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
;
; AVX512VL-LABEL: fpext_8f32_to_4f64:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vcvtps2pd %ymm0, %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x5a,0xc0]
; AVX512VL-NEXT:    # kill: def $ymm0 killed $ymm0 killed $zmm0
; AVX512VL-NEXT:    ret{{[l|q]}} # encoding: [0xc3]
  %cvt = fpext <8 x float> %a to <8 x double>
  %shuf = shufflevector <8 x double> %cvt, <8 x double> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  ret <4 x double> %shuf
}

; PR11674
define void @fpext_frommem(ptr %in, ptr %out) {
; X86-SSE-LABEL: fpext_frommem:
; X86-SSE:       # %bb.0: # %entry
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x08]
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x04]
; X86-SSE-NEXT:    cvtps2pd (%ecx), %xmm0 # encoding: [0x0f,0x5a,0x01]
; X86-SSE-NEXT:    movups %xmm0, (%eax) # encoding: [0x0f,0x11,0x00]
; X86-SSE-NEXT:    retl # encoding: [0xc3]
;
; X86-AVX-LABEL: fpext_frommem:
; X86-AVX:       # %bb.0: # %entry
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x08]
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x04]
; X86-AVX-NEXT:    vcvtps2pd (%ecx), %xmm0 # encoding: [0xc5,0xf8,0x5a,0x01]
; X86-AVX-NEXT:    vmovups %xmm0, (%eax) # encoding: [0xc5,0xf8,0x11,0x00]
; X86-AVX-NEXT:    retl # encoding: [0xc3]
;
; X86-AVX512VL-LABEL: fpext_frommem:
; X86-AVX512VL:       # %bb.0: # %entry
; X86-AVX512VL-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x08]
; X86-AVX512VL-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x04]
; X86-AVX512VL-NEXT:    vcvtps2pd (%ecx), %xmm0 # EVEX TO VEX Compression encoding: [0xc5,0xf8,0x5a,0x01]
; X86-AVX512VL-NEXT:    vmovups %xmm0, (%eax) # EVEX TO VEX Compression encoding: [0xc5,0xf8,0x11,0x00]
; X86-AVX512VL-NEXT:    retl # encoding: [0xc3]
;
; X64-SSE-LABEL: fpext_frommem:
; X64-SSE:       # %bb.0: # %entry
; X64-SSE-NEXT:    cvtps2pd (%rdi), %xmm0 # encoding: [0x0f,0x5a,0x07]
; X64-SSE-NEXT:    movups %xmm0, (%rsi) # encoding: [0x0f,0x11,0x06]
; X64-SSE-NEXT:    retq # encoding: [0xc3]
;
; X64-AVX-LABEL: fpext_frommem:
; X64-AVX:       # %bb.0: # %entry
; X64-AVX-NEXT:    vcvtps2pd (%rdi), %xmm0 # encoding: [0xc5,0xf8,0x5a,0x07]
; X64-AVX-NEXT:    vmovups %xmm0, (%rsi) # encoding: [0xc5,0xf8,0x11,0x06]
; X64-AVX-NEXT:    retq # encoding: [0xc3]
;
; X64-AVX512VL-LABEL: fpext_frommem:
; X64-AVX512VL:       # %bb.0: # %entry
; X64-AVX512VL-NEXT:    vcvtps2pd (%rdi), %xmm0 # EVEX TO VEX Compression encoding: [0xc5,0xf8,0x5a,0x07]
; X64-AVX512VL-NEXT:    vmovups %xmm0, (%rsi) # EVEX TO VEX Compression encoding: [0xc5,0xf8,0x11,0x06]
; X64-AVX512VL-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = load <2 x float>, ptr %in, align 8
  %1 = fpext <2 x float> %0 to <2 x double>
  store <2 x double> %1, ptr %out, align 1
  ret void
}

define void @fpext_frommem4(ptr %in, ptr %out) {
; X86-SSE-LABEL: fpext_frommem4:
; X86-SSE:       # %bb.0: # %entry
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x08]
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x04]
; X86-SSE-NEXT:    cvtps2pd (%ecx), %xmm0 # encoding: [0x0f,0x5a,0x01]
; X86-SSE-NEXT:    cvtps2pd 8(%ecx), %xmm1 # encoding: [0x0f,0x5a,0x49,0x08]
; X86-SSE-NEXT:    movups %xmm1, 16(%eax) # encoding: [0x0f,0x11,0x48,0x10]
; X86-SSE-NEXT:    movups %xmm0, (%eax) # encoding: [0x0f,0x11,0x00]
; X86-SSE-NEXT:    retl # encoding: [0xc3]
;
; X86-AVX-LABEL: fpext_frommem4:
; X86-AVX:       # %bb.0: # %entry
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x08]
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x04]
; X86-AVX-NEXT:    vcvtps2pd (%ecx), %ymm0 # encoding: [0xc5,0xfc,0x5a,0x01]
; X86-AVX-NEXT:    vmovups %ymm0, (%eax) # encoding: [0xc5,0xfc,0x11,0x00]
; X86-AVX-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X86-AVX-NEXT:    retl # encoding: [0xc3]
;
; X86-AVX512VL-LABEL: fpext_frommem4:
; X86-AVX512VL:       # %bb.0: # %entry
; X86-AVX512VL-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x08]
; X86-AVX512VL-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x04]
; X86-AVX512VL-NEXT:    vcvtps2pd (%ecx), %ymm0 # EVEX TO VEX Compression encoding: [0xc5,0xfc,0x5a,0x01]
; X86-AVX512VL-NEXT:    vmovups %ymm0, (%eax) # EVEX TO VEX Compression encoding: [0xc5,0xfc,0x11,0x00]
; X86-AVX512VL-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X86-AVX512VL-NEXT:    retl # encoding: [0xc3]
;
; X64-SSE-LABEL: fpext_frommem4:
; X64-SSE:       # %bb.0: # %entry
; X64-SSE-NEXT:    cvtps2pd (%rdi), %xmm0 # encoding: [0x0f,0x5a,0x07]
; X64-SSE-NEXT:    cvtps2pd 8(%rdi), %xmm1 # encoding: [0x0f,0x5a,0x4f,0x08]
; X64-SSE-NEXT:    movups %xmm1, 16(%rsi) # encoding: [0x0f,0x11,0x4e,0x10]
; X64-SSE-NEXT:    movups %xmm0, (%rsi) # encoding: [0x0f,0x11,0x06]
; X64-SSE-NEXT:    retq # encoding: [0xc3]
;
; X64-AVX-LABEL: fpext_frommem4:
; X64-AVX:       # %bb.0: # %entry
; X64-AVX-NEXT:    vcvtps2pd (%rdi), %ymm0 # encoding: [0xc5,0xfc,0x5a,0x07]
; X64-AVX-NEXT:    vmovups %ymm0, (%rsi) # encoding: [0xc5,0xfc,0x11,0x06]
; X64-AVX-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X64-AVX-NEXT:    retq # encoding: [0xc3]
;
; X64-AVX512VL-LABEL: fpext_frommem4:
; X64-AVX512VL:       # %bb.0: # %entry
; X64-AVX512VL-NEXT:    vcvtps2pd (%rdi), %ymm0 # EVEX TO VEX Compression encoding: [0xc5,0xfc,0x5a,0x07]
; X64-AVX512VL-NEXT:    vmovups %ymm0, (%rsi) # EVEX TO VEX Compression encoding: [0xc5,0xfc,0x11,0x06]
; X64-AVX512VL-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X64-AVX512VL-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = load <4 x float>, ptr %in
  %1 = fpext <4 x float> %0 to <4 x double>
  store <4 x double> %1, ptr %out, align 1
  ret void
}

define void @fpext_frommem8(ptr %in, ptr %out) {
; X86-SSE-LABEL: fpext_frommem8:
; X86-SSE:       # %bb.0: # %entry
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x08]
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x04]
; X86-SSE-NEXT:    cvtps2pd 8(%ecx), %xmm0 # encoding: [0x0f,0x5a,0x41,0x08]
; X86-SSE-NEXT:    cvtps2pd (%ecx), %xmm1 # encoding: [0x0f,0x5a,0x09]
; X86-SSE-NEXT:    cvtps2pd 24(%ecx), %xmm2 # encoding: [0x0f,0x5a,0x51,0x18]
; X86-SSE-NEXT:    cvtps2pd 16(%ecx), %xmm3 # encoding: [0x0f,0x5a,0x59,0x10]
; X86-SSE-NEXT:    movups %xmm3, 32(%eax) # encoding: [0x0f,0x11,0x58,0x20]
; X86-SSE-NEXT:    movups %xmm2, 48(%eax) # encoding: [0x0f,0x11,0x50,0x30]
; X86-SSE-NEXT:    movups %xmm1, (%eax) # encoding: [0x0f,0x11,0x08]
; X86-SSE-NEXT:    movups %xmm0, 16(%eax) # encoding: [0x0f,0x11,0x40,0x10]
; X86-SSE-NEXT:    retl # encoding: [0xc3]
;
; X86-AVX-LABEL: fpext_frommem8:
; X86-AVX:       # %bb.0: # %entry
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x08]
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x04]
; X86-AVX-NEXT:    vcvtps2pd (%ecx), %ymm0 # encoding: [0xc5,0xfc,0x5a,0x01]
; X86-AVX-NEXT:    vcvtps2pd 16(%ecx), %ymm1 # encoding: [0xc5,0xfc,0x5a,0x49,0x10]
; X86-AVX-NEXT:    vmovups %ymm1, 32(%eax) # encoding: [0xc5,0xfc,0x11,0x48,0x20]
; X86-AVX-NEXT:    vmovups %ymm0, (%eax) # encoding: [0xc5,0xfc,0x11,0x00]
; X86-AVX-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X86-AVX-NEXT:    retl # encoding: [0xc3]
;
; X86-AVX512VL-LABEL: fpext_frommem8:
; X86-AVX512VL:       # %bb.0: # %entry
; X86-AVX512VL-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x08]
; X86-AVX512VL-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x04]
; X86-AVX512VL-NEXT:    vcvtps2pd (%ecx), %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x5a,0x01]
; X86-AVX512VL-NEXT:    vmovups %zmm0, (%eax) # encoding: [0x62,0xf1,0x7c,0x48,0x11,0x00]
; X86-AVX512VL-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X86-AVX512VL-NEXT:    retl # encoding: [0xc3]
;
; X64-SSE-LABEL: fpext_frommem8:
; X64-SSE:       # %bb.0: # %entry
; X64-SSE-NEXT:    cvtps2pd 8(%rdi), %xmm0 # encoding: [0x0f,0x5a,0x47,0x08]
; X64-SSE-NEXT:    cvtps2pd (%rdi), %xmm1 # encoding: [0x0f,0x5a,0x0f]
; X64-SSE-NEXT:    cvtps2pd 24(%rdi), %xmm2 # encoding: [0x0f,0x5a,0x57,0x18]
; X64-SSE-NEXT:    cvtps2pd 16(%rdi), %xmm3 # encoding: [0x0f,0x5a,0x5f,0x10]
; X64-SSE-NEXT:    movups %xmm3, 32(%rsi) # encoding: [0x0f,0x11,0x5e,0x20]
; X64-SSE-NEXT:    movups %xmm2, 48(%rsi) # encoding: [0x0f,0x11,0x56,0x30]
; X64-SSE-NEXT:    movups %xmm1, (%rsi) # encoding: [0x0f,0x11,0x0e]
; X64-SSE-NEXT:    movups %xmm0, 16(%rsi) # encoding: [0x0f,0x11,0x46,0x10]
; X64-SSE-NEXT:    retq # encoding: [0xc3]
;
; X64-AVX-LABEL: fpext_frommem8:
; X64-AVX:       # %bb.0: # %entry
; X64-AVX-NEXT:    vcvtps2pd (%rdi), %ymm0 # encoding: [0xc5,0xfc,0x5a,0x07]
; X64-AVX-NEXT:    vcvtps2pd 16(%rdi), %ymm1 # encoding: [0xc5,0xfc,0x5a,0x4f,0x10]
; X64-AVX-NEXT:    vmovups %ymm1, 32(%rsi) # encoding: [0xc5,0xfc,0x11,0x4e,0x20]
; X64-AVX-NEXT:    vmovups %ymm0, (%rsi) # encoding: [0xc5,0xfc,0x11,0x06]
; X64-AVX-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X64-AVX-NEXT:    retq # encoding: [0xc3]
;
; X64-AVX512VL-LABEL: fpext_frommem8:
; X64-AVX512VL:       # %bb.0: # %entry
; X64-AVX512VL-NEXT:    vcvtps2pd (%rdi), %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x5a,0x07]
; X64-AVX512VL-NEXT:    vmovups %zmm0, (%rsi) # encoding: [0x62,0xf1,0x7c,0x48,0x11,0x06]
; X64-AVX512VL-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X64-AVX512VL-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = load <8 x float>, ptr %in
  %1 = fpext <8 x float> %0 to <8 x double>
  store <8 x double> %1, ptr %out, align 1
  ret void
}

define <2 x double> @fpext_fromconst() {
; X86-SSE-LABEL: fpext_fromconst:
; X86-SSE:       # %bb.0: # %entry
; X86-SSE-NEXT:    movaps {{.*#+}} xmm0 = [1.0E+0,-2.0E+0]
; X86-SSE-NEXT:    # encoding: [0x0f,0x28,0x05,A,A,A,A]
; X86-SSE-NEXT:    # fixup A - offset: 3, value: {{\.?LCPI[0-9]+_[0-9]+}}, kind: FK_Data_4
; X86-SSE-NEXT:    retl # encoding: [0xc3]
;
; X86-AVX-LABEL: fpext_fromconst:
; X86-AVX:       # %bb.0: # %entry
; X86-AVX-NEXT:    vmovaps {{.*#+}} xmm0 = [1.0E+0,-2.0E+0]
; X86-AVX-NEXT:    # encoding: [0xc5,0xf8,0x28,0x05,A,A,A,A]
; X86-AVX-NEXT:    # fixup A - offset: 4, value: {{\.?LCPI[0-9]+_[0-9]+}}, kind: FK_Data_4
; X86-AVX-NEXT:    retl # encoding: [0xc3]
;
; X86-AVX512VL-LABEL: fpext_fromconst:
; X86-AVX512VL:       # %bb.0: # %entry
; X86-AVX512VL-NEXT:    vmovaps {{.*#+}} xmm0 = [1.0E+0,-2.0E+0]
; X86-AVX512VL-NEXT:    # EVEX TO VEX Compression encoding: [0xc5,0xf8,0x28,0x05,A,A,A,A]
; X86-AVX512VL-NEXT:    # fixup A - offset: 4, value: {{\.?LCPI[0-9]+_[0-9]+}}, kind: FK_Data_4
; X86-AVX512VL-NEXT:    retl # encoding: [0xc3]
;
; X64-SSE-LABEL: fpext_fromconst:
; X64-SSE:       # %bb.0: # %entry
; X64-SSE-NEXT:    movaps {{.*#+}} xmm0 = [1.0E+0,-2.0E+0]
; X64-SSE-NEXT:    # encoding: [0x0f,0x28,0x05,A,A,A,A]
; X64-SSE-NEXT:    # fixup A - offset: 3, value: {{\.?LCPI[0-9]+_[0-9]+}}-4, kind: reloc_riprel_4byte
; X64-SSE-NEXT:    retq # encoding: [0xc3]
;
; X64-AVX-LABEL: fpext_fromconst:
; X64-AVX:       # %bb.0: # %entry
; X64-AVX-NEXT:    vmovaps {{.*#+}} xmm0 = [1.0E+0,-2.0E+0]
; X64-AVX-NEXT:    # encoding: [0xc5,0xf8,0x28,0x05,A,A,A,A]
; X64-AVX-NEXT:    # fixup A - offset: 4, value: {{\.?LCPI[0-9]+_[0-9]+}}-4, kind: reloc_riprel_4byte
; X64-AVX-NEXT:    retq # encoding: [0xc3]
;
; X64-AVX512VL-LABEL: fpext_fromconst:
; X64-AVX512VL:       # %bb.0: # %entry
; X64-AVX512VL-NEXT:    vmovaps {{.*#+}} xmm0 = [1.0E+0,-2.0E+0]
; X64-AVX512VL-NEXT:    # EVEX TO VEX Compression encoding: [0xc5,0xf8,0x28,0x05,A,A,A,A]
; X64-AVX512VL-NEXT:    # fixup A - offset: 4, value: {{\.?LCPI[0-9]+_[0-9]+}}-4, kind: reloc_riprel_4byte
; X64-AVX512VL-NEXT:    retq # encoding: [0xc3]
entry:
  %0  = insertelement <2 x float> undef, float 1.0, i32 0
  %1  = insertelement <2 x float> %0, float -2.0, i32 1
  %2  = fpext <2 x float> %1 to <2 x double>
  ret <2 x double> %2
}

; Make sure we don't narrow a volatile load.
define <2 x double> @PR42079(ptr %x) {
; X86-SSE-LABEL: PR42079:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-SSE-NEXT:    movaps (%eax), %xmm0 # encoding: [0x0f,0x28,0x00]
; X86-SSE-NEXT:    cvtps2pd %xmm0, %xmm0 # encoding: [0x0f,0x5a,0xc0]
; X86-SSE-NEXT:    retl # encoding: [0xc3]
;
; X86-AVX-LABEL: PR42079:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-AVX-NEXT:    vmovaps (%eax), %xmm0 # encoding: [0xc5,0xf8,0x28,0x00]
; X86-AVX-NEXT:    vcvtps2pd %xmm0, %xmm0 # encoding: [0xc5,0xf8,0x5a,0xc0]
; X86-AVX-NEXT:    retl # encoding: [0xc3]
;
; X86-AVX512VL-LABEL: PR42079:
; X86-AVX512VL:       # %bb.0:
; X86-AVX512VL-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-AVX512VL-NEXT:    vmovaps (%eax), %xmm0 # EVEX TO VEX Compression encoding: [0xc5,0xf8,0x28,0x00]
; X86-AVX512VL-NEXT:    vcvtps2pd %xmm0, %xmm0 # EVEX TO VEX Compression encoding: [0xc5,0xf8,0x5a,0xc0]
; X86-AVX512VL-NEXT:    retl # encoding: [0xc3]
;
; X64-SSE-LABEL: PR42079:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movaps (%rdi), %xmm0 # encoding: [0x0f,0x28,0x07]
; X64-SSE-NEXT:    cvtps2pd %xmm0, %xmm0 # encoding: [0x0f,0x5a,0xc0]
; X64-SSE-NEXT:    retq # encoding: [0xc3]
;
; X64-AVX-LABEL: PR42079:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovaps (%rdi), %xmm0 # encoding: [0xc5,0xf8,0x28,0x07]
; X64-AVX-NEXT:    vcvtps2pd %xmm0, %xmm0 # encoding: [0xc5,0xf8,0x5a,0xc0]
; X64-AVX-NEXT:    retq # encoding: [0xc3]
;
; X64-AVX512VL-LABEL: PR42079:
; X64-AVX512VL:       # %bb.0:
; X64-AVX512VL-NEXT:    vmovaps (%rdi), %xmm0 # EVEX TO VEX Compression encoding: [0xc5,0xf8,0x28,0x07]
; X64-AVX512VL-NEXT:    vcvtps2pd %xmm0, %xmm0 # EVEX TO VEX Compression encoding: [0xc5,0xf8,0x5a,0xc0]
; X64-AVX512VL-NEXT:    retq # encoding: [0xc3]
  %a = load volatile <4 x float>, ptr %x
  %b = shufflevector <4 x float> %a, <4 x float> %a, <2 x i32> <i32 0, i32 1>
  %c = fpext <2 x float> %b to <2 x double>
  ret <2 x double> %c
}