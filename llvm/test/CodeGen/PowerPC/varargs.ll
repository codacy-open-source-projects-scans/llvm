; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -ppc-asm-full-reg-names < %s -mtriple=powerpc-unknown-linux-gnu | FileCheck -check-prefix=P32 %s
; RUN: llc -verify-machineinstrs -ppc-asm-full-reg-names < %s -mtriple=powerpc64-unknown-linux-gnu | FileCheck -check-prefix=P64 %s
; RUN: llc -verify-machineinstrs -ppc-asm-full-reg-names < %s -mtriple=powerpc64le-unknown-linux-gnu | FileCheck -check-prefix=P64 %s

; PR8327
define ptr @test1(ptr %foo) nounwind {
; P32-LABEL: test1:
; P32:       # %bb.0:
; P32-NEXT:    lbz r5, 0(r3)
; P32-NEXT:    lwz r4, 4(r3)
; P32-NEXT:    addi r6, r5, 1
; P32-NEXT:    cmpwi r5, 8
; P32-NEXT:    stb r6, 0(r3)
; P32-NEXT:    mr r6, r4
; P32-NEXT:    bge cr0, .LBB0_3
; P32-NEXT:  # %bb.1:
; P32-NEXT:    stw r6, 4(r3)
; P32-NEXT:    blt cr0, .LBB0_4
; P32-NEXT:  .LBB0_2:
; P32-NEXT:    lwz r3, 0(r4)
; P32-NEXT:    blr
; P32-NEXT:  .LBB0_3:
; P32-NEXT:    addi r6, r4, 4
; P32-NEXT:    stw r6, 4(r3)
; P32-NEXT:    bge cr0, .LBB0_2
; P32-NEXT:  .LBB0_4:
; P32-NEXT:    lwz r3, 8(r3)
; P32-NEXT:    slwi r4, r5, 2
; P32-NEXT:    add r4, r3, r4
; P32-NEXT:    lwz r3, 0(r4)
; P32-NEXT:    blr
;
; P64-LABEL: test1:
; P64:       # %bb.0:
; P64-NEXT:    ld r4, 0(r3)
; P64-NEXT:    addi r5, r4, 8
; P64-NEXT:    std r5, 0(r3)
; P64-NEXT:    ld r3, 0(r4)
; P64-NEXT:    blr
  %A = va_arg ptr %foo, ptr
  ret ptr %A
}

