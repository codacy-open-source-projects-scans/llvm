; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=aarch64 -mattr=+sve < %s -o - | FileCheck --check-prefixes=CHECK,SVE %s
; RUN: llc -mtriple=aarch64 -mattr=+sve2 < %s -o - | FileCheck --check-prefixes=CHECK,SVE2 %s

define <vscale x 16 x i8> @testLeftGood16x8(<vscale x 16 x i8> %src1, <vscale x 16 x i8> %src2) {
; SVE-LABEL: testLeftGood16x8:
; SVE:       // %bb.0:
; SVE-NEXT:    and z0.b, z0.b, #0x7
; SVE-NEXT:    lsl z1.b, z1.b, #3
; SVE-NEXT:    orr z0.d, z0.d, z1.d
; SVE-NEXT:    ret
;
; SVE2-LABEL: testLeftGood16x8:
; SVE2:       // %bb.0:
; SVE2-NEXT:    sli z0.b, z1.b, #3
; SVE2-NEXT:    ret
  %and.i = and <vscale x 16 x i8> %src1, splat(i8 7)
  %vshl_n = shl <vscale x 16 x i8> %src2, splat(i8 3)
  %result = or <vscale x 16 x i8> %and.i, %vshl_n
  ret <vscale x 16 x i8> %result
}

define <vscale x 16 x i8> @testLeftBad16x8(<vscale x 16 x i8> %src1, <vscale x 16 x i8> %src2) {
; CHECK-LABEL: testLeftBad16x8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z2.b, #-91 // =0xffffffffffffffa5
; CHECK-NEXT:    lsl z1.b, z1.b, #1
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %and.i = and <vscale x 16 x i8> %src1, splat(i8 165)
  %vshl_n = shl <vscale x 16 x i8> %src2, splat(i8 1)
  %result = or <vscale x 16 x i8> %and.i, %vshl_n
  ret <vscale x 16 x i8> %result
}

define <vscale x 16 x i8> @testRightGood16x8(<vscale x 16 x i8> %src1, <vscale x 16 x i8> %src2) {
; SVE-LABEL: testRightGood16x8:
; SVE:       // %bb.0:
; SVE-NEXT:    and z0.b, z0.b, #0xe0
; SVE-NEXT:    lsr z1.b, z1.b, #3
; SVE-NEXT:    orr z0.d, z0.d, z1.d
; SVE-NEXT:    ret
;
; SVE2-LABEL: testRightGood16x8:
; SVE2:       // %bb.0:
; SVE2-NEXT:    sri z0.b, z1.b, #3
; SVE2-NEXT:    ret
  %and.i = and <vscale x 16 x i8> %src1, splat(i8 224)
  %vshl_n = lshr <vscale x 16 x i8> %src2, splat(i8 3)
  %result = or <vscale x 16 x i8> %and.i, %vshl_n
  ret <vscale x 16 x i8> %result
}

define <vscale x 16 x i8> @testRightBad16x8(<vscale x 16 x i8> %src1, <vscale x 16 x i8> %src2) {
; CHECK-LABEL: testRightBad16x8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z2.b, #-91 // =0xffffffffffffffa5
; CHECK-NEXT:    lsr z1.b, z1.b, #1
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %and.i = and <vscale x 16 x i8> %src1, splat(i8 165)
  %vshl_n = lshr <vscale x 16 x i8> %src2, splat(i8 1)
  %result = or <vscale x 16 x i8> %and.i, %vshl_n
  ret <vscale x 16 x i8> %result
}

define <vscale x 8 x i16> @testLeftGood8x16(<vscale x 8 x i16> %src1, <vscale x 8 x i16> %src2) {
; SVE-LABEL: testLeftGood8x16:
; SVE:       // %bb.0:
; SVE-NEXT:    and z0.h, z0.h, #0x3fff
; SVE-NEXT:    lsl z1.h, z1.h, #14
; SVE-NEXT:    orr z0.d, z0.d, z1.d
; SVE-NEXT:    ret
;
; SVE2-LABEL: testLeftGood8x16:
; SVE2:       // %bb.0:
; SVE2-NEXT:    sli z0.h, z1.h, #14
; SVE2-NEXT:    ret
  %and.i = and <vscale x 8 x i16> %src1, splat(i16 16383)
  %vshl_n = shl <vscale x 8 x i16> %src2, splat(i16 14)
  %result = or <vscale x 8 x i16> %and.i, %vshl_n
  ret <vscale x 8 x i16> %result
}

define <vscale x 8 x i16> @testLeftBad8x16(<vscale x 8 x i16> %src1, <vscale x 8 x i16> %src2) {
; CHECK-LABEL: testLeftBad8x16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #16500 // =0x4074
; CHECK-NEXT:    lsl z1.h, z1.h, #14
; CHECK-NEXT:    mov z2.h, w8
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %and.i = and <vscale x 8 x i16> %src1, splat(i16 16500)
  %vshl_n = shl <vscale x 8 x i16> %src2, splat(i16 14)
  %result = or <vscale x 8 x i16> %and.i, %vshl_n
  ret <vscale x 8 x i16> %result
}

define <vscale x 8 x i16> @testRightGood8x16(<vscale x 8 x i16> %src1, <vscale x 8 x i16> %src2) {
; SVE-LABEL: testRightGood8x16:
; SVE:       // %bb.0:
; SVE-NEXT:    and z0.h, z0.h, #0xfffc
; SVE-NEXT:    lsr z1.h, z1.h, #14
; SVE-NEXT:    orr z0.d, z0.d, z1.d
; SVE-NEXT:    ret
;
; SVE2-LABEL: testRightGood8x16:
; SVE2:       // %bb.0:
; SVE2-NEXT:    sri z0.h, z1.h, #14
; SVE2-NEXT:    ret
  %and.i = and <vscale x 8 x i16> %src1, splat(i16 65532)
  %vshl_n = lshr <vscale x 8 x i16> %src2, splat(i16 14)
  %result = or <vscale x 8 x i16> %and.i, %vshl_n
  ret <vscale x 8 x i16> %result
}

define <vscale x 8 x i16> @testRightBad8x16(<vscale x 8 x i16> %src1, <vscale x 8 x i16> %src2) {
; CHECK-LABEL: testRightBad8x16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #16500 // =0x4074
; CHECK-NEXT:    lsr z1.h, z1.h, #14
; CHECK-NEXT:    mov z2.h, w8
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %and.i = and <vscale x 8 x i16> %src1, splat(i16 16500)
  %vshl_n = lshr <vscale x 8 x i16> %src2, splat(i16 14)
  %result = or <vscale x 8 x i16> %and.i, %vshl_n
  ret <vscale x 8 x i16> %result
}

define <vscale x 4 x i32> @testLeftGood4x32(<vscale x 4 x i32> %src1, <vscale x 4 x i32> %src2) {
; SVE-LABEL: testLeftGood4x32:
; SVE:       // %bb.0:
; SVE-NEXT:    and z0.s, z0.s, #0x3fffff
; SVE-NEXT:    lsl z1.s, z1.s, #22
; SVE-NEXT:    orr z0.d, z0.d, z1.d
; SVE-NEXT:    ret
;
; SVE2-LABEL: testLeftGood4x32:
; SVE2:       // %bb.0:
; SVE2-NEXT:    sli z0.s, z1.s, #22
; SVE2-NEXT:    ret
  %and.i = and <vscale x 4 x i32> %src1, splat(i32 4194303)
  %vshl_n = shl <vscale x 4 x i32> %src2, splat(i32 22)
  %result = or <vscale x 4 x i32> %and.i, %vshl_n
  ret <vscale x 4 x i32> %result
}

define <vscale x 4 x i32> @testLeftBad4x32(<vscale x 4 x i32> %src1, <vscale x 4 x i32> %src2) {
; CHECK-LABEL: testLeftBad4x32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and z0.s, z0.s, #0x3ffffc
; CHECK-NEXT:    lsl z1.s, z1.s, #22
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %and.i = and <vscale x 4 x i32> %src1, splat(i32 4194300)
  %vshl_n = shl <vscale x 4 x i32> %src2, splat(i32 22)
  %result = or <vscale x 4 x i32> %and.i, %vshl_n
  ret <vscale x 4 x i32> %result
}

define <vscale x 4 x i32> @testRightGood4x32(<vscale x 4 x i32> %src1, <vscale x 4 x i32> %src2) {
; SVE-LABEL: testRightGood4x32:
; SVE:       // %bb.0:
; SVE-NEXT:    and z0.s, z0.s, #0xfffffc00
; SVE-NEXT:    lsr z1.s, z1.s, #22
; SVE-NEXT:    orr z0.d, z0.d, z1.d
; SVE-NEXT:    ret
;
; SVE2-LABEL: testRightGood4x32:
; SVE2:       // %bb.0:
; SVE2-NEXT:    sri z0.s, z1.s, #22
; SVE2-NEXT:    ret
  %and.i = and <vscale x 4 x i32> %src1, splat(i32 4294966272)
  %vshl_n = lshr <vscale x 4 x i32> %src2, splat(i32 22)
  %result = or <vscale x 4 x i32> %and.i, %vshl_n
  ret <vscale x 4 x i32> %result
}

define <vscale x 4 x i32> @testRightBad4x32(<vscale x 4 x i32> %src1, <vscale x 4 x i32> %src2) {
; CHECK-LABEL: testRightBad4x32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and z0.s, z0.s, #0x3ffffc
; CHECK-NEXT:    lsr z1.s, z1.s, #22
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %and.i = and <vscale x 4 x i32> %src1, splat(i32 4194300)
  %vshl_n = lshr <vscale x 4 x i32> %src2, splat(i32 22)
  %result = or <vscale x 4 x i32> %and.i, %vshl_n
  ret <vscale x 4 x i32> %result
}

define <vscale x 2 x i64> @testLeftGood2x64(<vscale x 2 x i64> %src1, <vscale x 2 x i64> %src2) {
; SVE-LABEL: testLeftGood2x64:
; SVE:       // %bb.0:
; SVE-NEXT:    and z0.d, z0.d, #0xffffffffffff
; SVE-NEXT:    lsl z1.d, z1.d, #48
; SVE-NEXT:    orr z0.d, z0.d, z1.d
; SVE-NEXT:    ret
;
; SVE2-LABEL: testLeftGood2x64:
; SVE2:       // %bb.0:
; SVE2-NEXT:    sli z0.d, z1.d, #48
; SVE2-NEXT:    ret
  %and.i = and <vscale x 2 x i64> %src1, splat(i64 281474976710655)
  %vshl_n = shl <vscale x 2 x i64> %src2, splat(i64 48)
  %result = or <vscale x 2 x i64> %and.i, %vshl_n
  ret <vscale x 2 x i64> %result
}

define <vscale x 2 x i64> @testLeftBad2x64(<vscale x 2 x i64> %src1, <vscale x 2 x i64> %src2) {
; CHECK-LABEL: testLeftBad2x64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #10 // =0xa
; CHECK-NEXT:    lsl z1.d, z1.d, #48
; CHECK-NEXT:    movk x8, #1, lsl #48
; CHECK-NEXT:    mov z2.d, x8
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %and.i = and <vscale x 2 x i64> %src1, splat(i64 281474976710666)
  %vshl_n = shl <vscale x 2 x i64> %src2, splat(i64 48)
  %result = or <vscale x 2 x i64> %and.i, %vshl_n
  ret <vscale x 2 x i64> %result
}

define <vscale x 2 x i64> @testRightGood2x64(<vscale x 2 x i64> %src1, <vscale x 2 x i64> %src2) {
; SVE-LABEL: testRightGood2x64:
; SVE:       // %bb.0:
; SVE-NEXT:    and z0.d, z0.d, #0xffffffffffff0000
; SVE-NEXT:    lsr z1.d, z1.d, #48
; SVE-NEXT:    orr z0.d, z0.d, z1.d
; SVE-NEXT:    ret
;
; SVE2-LABEL: testRightGood2x64:
; SVE2:       // %bb.0:
; SVE2-NEXT:    sri z0.d, z1.d, #48
; SVE2-NEXT:    ret
  %and.i = and <vscale x 2 x i64> %src1, splat(i64 18446744073709486080)
  %vshl_n = lshr <vscale x 2 x i64> %src2, splat(i64 48)
  %result = or <vscale x 2 x i64> %and.i, %vshl_n
  ret <vscale x 2 x i64> %result
}

define <vscale x 2 x i64> @testRightBad2x64(<vscale x 2 x i64> %src1, <vscale x 2 x i64> %src2) {
; CHECK-LABEL: testRightBad2x64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #10 // =0xa
; CHECK-NEXT:    lsr z1.d, z1.d, #48
; CHECK-NEXT:    movk x8, #1, lsl #48
; CHECK-NEXT:    mov z2.d, x8
; CHECK-NEXT:    and z0.d, z0.d, z2.d
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %and.i = and <vscale x 2 x i64> %src1, splat(i64 281474976710666)
  %vshl_n = lshr <vscale x 2 x i64> %src2, splat(i64 48)
  %result = or <vscale x 2 x i64> %and.i, %vshl_n
  ret <vscale x 2 x i64> %result
}