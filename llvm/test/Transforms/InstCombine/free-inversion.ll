; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

declare i8 @llvm.smin.i8(i8, i8)
declare i8 @llvm.umin.i8(i8, i8)
declare i8 @llvm.smax.i8(i8, i8)
declare i8 @llvm.umax.i8(i8, i8)

declare void @llvm.assume(i1)

declare void @use.i8(i8)
declare void @use.i1(i1)

define i8 @xor_1(i8 %a, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @xor_1(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], -124
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[C:%.*]], i8 [[X:%.*]], i8 [[TMP1]]
; CHECK-NEXT:    [[NOT_BA:%.*]] = xor i8 [[TMP2]], [[A:%.*]]
; CHECK-NEXT:    ret i8 [[NOT_BA]]
;
  %nx = xor i8 %x, -1
  %yy = xor i8 %y, 123
  %b = select i1 %c, i8 %nx, i8 %yy
  %ba = xor i8 %b, %a
  %not_ba = xor i8 %ba, -1
  ret i8 %not_ba
}

define i8 @xor_2(i8 %a, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @xor_2(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], -124
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[C:%.*]], i8 [[X:%.*]], i8 [[TMP1]]
; CHECK-NEXT:    [[NOT_AB:%.*]] = xor i8 [[A:%.*]], [[TMP2]]
; CHECK-NEXT:    ret i8 [[NOT_AB]]
;
  %nx = xor i8 %x, -1
  %yy = xor i8 %y, 123
  %b = select i1 %c, i8 %nx, i8 %yy
  %ab = xor i8 %a, %b
  %not_ab = xor i8 %ab, -1
  ret i8 %not_ab
}

define i8 @xor_fail(i8 %a, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @xor_fail(
; CHECK-NEXT:    [[NX:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    [[B:%.*]] = select i1 [[C:%.*]], i8 [[NX]], i8 [[Y:%.*]]
; CHECK-NEXT:    [[AB:%.*]] = xor i8 [[A:%.*]], [[B]]
; CHECK-NEXT:    [[NOT_AB:%.*]] = xor i8 [[AB]], -1
; CHECK-NEXT:    ret i8 [[NOT_AB]]
;
  %nx = xor i8 %x, -1
  %b = select i1 %c, i8 %nx, i8 %y
  %ab = xor i8 %a, %b
  %not_ab = xor i8 %ab, -1
  ret i8 %not_ab
}

define i8 @add_1(i8 %a, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @add_1(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], -124
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[C:%.*]], i8 [[X:%.*]], i8 [[TMP1]]
; CHECK-NEXT:    [[NOT_BA:%.*]] = sub i8 [[TMP2]], [[A:%.*]]
; CHECK-NEXT:    ret i8 [[NOT_BA]]
;
  %nx = xor i8 %x, -1
  %yy = xor i8 %y, 123
  %b = select i1 %c, i8 %nx, i8 %yy
  %ba = add i8 %b, %a
  %not_ba = xor i8 %ba, -1
  ret i8 %not_ba
}

define i8 @add_2(i8 %a, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @add_2(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], -124
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[C:%.*]], i8 [[X:%.*]], i8 [[TMP1]]
; CHECK-NEXT:    [[NOT_AB:%.*]] = sub i8 [[TMP2]], [[A:%.*]]
; CHECK-NEXT:    ret i8 [[NOT_AB]]
;
  %nx = xor i8 %x, -1
  %yy = xor i8 %y, 123
  %b = select i1 %c, i8 %nx, i8 %yy
  %ab = add i8 %a, %b
  %not_ab = xor i8 %ab, -1
  ret i8 %not_ab
}

define i8 @add_fail(i8 %a, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @add_fail(
; CHECK-NEXT:    [[NX:%.*]] = xor i8 [[X:%.*]], [[A:%.*]]
; CHECK-NEXT:    [[YY:%.*]] = xor i8 [[Y:%.*]], 123
; CHECK-NEXT:    [[B:%.*]] = select i1 [[C:%.*]], i8 [[NX]], i8 [[YY]]
; CHECK-NEXT:    [[AB:%.*]] = add i8 [[A]], [[B]]
; CHECK-NEXT:    [[NOT_AB:%.*]] = xor i8 [[AB]], -1
; CHECK-NEXT:    ret i8 [[NOT_AB]]
;
  %nx = xor i8 %x, %a
  %yy = xor i8 %y, 123
  %b = select i1 %c, i8 %nx, i8 %yy
  %ab = add i8 %a, %b
  %not_ab = xor i8 %ab, -1
  ret i8 %not_ab
}

define i8 @sub_1(i8 %a, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @sub_1(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], -124
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[C:%.*]], i8 [[X:%.*]], i8 [[TMP1]]
; CHECK-NEXT:    [[NOT_BA:%.*]] = add i8 [[TMP2]], [[A:%.*]]
; CHECK-NEXT:    ret i8 [[NOT_BA]]
;
  %nx = xor i8 %x, -1
  %yy = xor i8 %y, 123
  %b = select i1 %c, i8 %nx, i8 %yy
  %ba = sub i8 %b, %a
  %not_ba = xor i8 %ba, -1
  ret i8 %not_ba
}

define i8 @sub_2(i8 %a, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @sub_2(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], -124
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[C:%.*]], i8 [[X:%.*]], i8 [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = add i8 [[TMP2]], [[A:%.*]]
; CHECK-NEXT:    [[NOT_AB:%.*]] = sub i8 -2, [[TMP3]]
; CHECK-NEXT:    ret i8 [[NOT_AB]]
;
  %nx = xor i8 %x, -1
  %yy = xor i8 %y, 123
  %b = select i1 %c, i8 %nx, i8 %yy
  %ab = sub i8 %a, %b
  %not_ab = xor i8 %ab, -1
  ret i8 %not_ab
}

; Same as above but with a type larger than i64 to make sure we create -2
; correctly.
define i128 @sub_3(i128 %a, i1 %c, i128 %x, i128 %y) {
; CHECK-LABEL: @sub_3(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i128 [[Y:%.*]], -124
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[C:%.*]], i128 [[X:%.*]], i128 [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = add i128 [[TMP2]], [[A:%.*]]
; CHECK-NEXT:    [[NOT_AB:%.*]] = sub i128 -2, [[TMP3]]
; CHECK-NEXT:    ret i128 [[NOT_AB]]
;
  %nx = xor i128 %x, -1
  %yy = xor i128 %y, 123
  %b = select i1 %c, i128 %nx, i128 %yy
  %ab = sub i128 %a, %b
  %not_ab = xor i128 %ab, -1
  ret i128 %not_ab
}

define i8 @sub_fail(i8 %a, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @sub_fail(
; CHECK-NEXT:    [[NX:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    call void @use.i8(i8 [[NX]])
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], -124
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[C:%.*]], i8 [[X]], i8 [[TMP1]]
; CHECK-NEXT:    [[NOT_BA:%.*]] = add i8 [[TMP2]], [[A:%.*]]
; CHECK-NEXT:    ret i8 [[NOT_BA]]
;
  %nx = xor i8 %x, -1
  %yy = xor i8 %y, 123
  call void @use.i8(i8 %nx)
  %b = select i1 %c, i8 %nx, i8 %yy
  %ba = sub i8 %b, %a
  %not_ba = xor i8 %ba, -1
  ret i8 %not_ba
}

define i8 @ashr_1(i8 %a, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @ashr_1(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], -124
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[C:%.*]], i8 [[X:%.*]], i8 [[TMP1]]
; CHECK-NEXT:    [[NOT_BA:%.*]] = ashr i8 [[TMP2]], [[A:%.*]]
; CHECK-NEXT:    ret i8 [[NOT_BA]]
;
  %nx = xor i8 %x, -1
  %yy = xor i8 %y, 123
  %b = select i1 %c, i8 %nx, i8 %yy
  %ba = ashr i8 %b, %a
  %not_ba = xor i8 %ba, -1
  ret i8 %not_ba
}

define i8 @ashr_2_fail(i8 %a, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @ashr_2_fail(
; CHECK-NEXT:    [[NX:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    [[YY:%.*]] = xor i8 [[Y:%.*]], 123
; CHECK-NEXT:    [[B:%.*]] = select i1 [[C:%.*]], i8 [[NX]], i8 [[YY]]
; CHECK-NEXT:    [[AB:%.*]] = ashr i8 [[A:%.*]], [[B]]
; CHECK-NEXT:    [[NOT_AB:%.*]] = xor i8 [[AB]], -1
; CHECK-NEXT:    ret i8 [[NOT_AB]]
;
  %nx = xor i8 %x, -1
  %yy = xor i8 %y, 123
  %b = select i1 %c, i8 %nx, i8 %yy
  %ab = ashr i8 %a, %b
  %not_ab = xor i8 %ab, -1
  ret i8 %not_ab
}

define i8 @select_1(i1 %cc, i8 %na, i8 %aa, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @select_1(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[NA:%.*]], [[AA:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = xor i8 [[TMP1]], -46
; CHECK-NEXT:    [[TMP3:%.*]] = xor i8 [[Y:%.*]], -124
; CHECK-NEXT:    [[TMP4:%.*]] = select i1 [[C:%.*]], i8 [[X:%.*]], i8 [[TMP3]]
; CHECK-NEXT:    [[NOT_AB:%.*]] = select i1 [[CC:%.*]], i8 [[TMP2]], i8 [[TMP4]]
; CHECK-NEXT:    ret i8 [[NOT_AB]]
;
  %nx = xor i8 %x, -1
  %yy = xor i8 %y, 123
  %b = select i1 %c, i8 %nx, i8 %yy
  %nna = xor i8 %na, 45
  %a = xor i8 %aa, %nna
  %ab = select i1 %cc, i8 %a, i8 %b
  %not_ab = xor i8 %ab, -1
  ret i8 %not_ab
}

define i8 @select_2(i1 %cc, i8 %na, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @select_2(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], -124
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[C:%.*]], i8 [[X:%.*]], i8 [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = xor i8 [[NA:%.*]], -46
; CHECK-NEXT:    [[NOT_BA:%.*]] = select i1 [[CC:%.*]], i8 [[TMP2]], i8 [[TMP3]]
; CHECK-NEXT:    ret i8 [[NOT_BA]]
;
  %nx = xor i8 %x, -1
  %yy = xor i8 %y, 123
  %b = select i1 %c, i8 %nx, i8 %yy
  %a = xor i8 %na, 45
  %ba = select i1 %cc, i8 %b, i8 %a
  %not_ba = xor i8 %ba, -1
  ret i8 %not_ba
}

define i1 @select_logic_or_fail(i1 %cc, i1 %c, i1 %x, i8 %y) {
; CHECK-LABEL: @select_logic_or_fail(
; CHECK-NEXT:    [[NX:%.*]] = xor i1 [[X:%.*]], true
; CHECK-NEXT:    [[YY:%.*]] = icmp eq i8 [[Y:%.*]], 123
; CHECK-NEXT:    [[B:%.*]] = select i1 [[C:%.*]], i1 [[NX]], i1 [[YY]]
; CHECK-NEXT:    [[AB:%.*]] = select i1 [[CC:%.*]], i1 [[B]], i1 false
; CHECK-NEXT:    [[NOT_AB:%.*]] = xor i1 [[AB]], true
; CHECK-NEXT:    ret i1 [[NOT_AB]]
;
  %nx = xor i1 %x, -1
  %yy = icmp eq i8 %y, 123
  %b = select i1 %c, i1 %nx, i1 %yy
  %ab = select i1 %cc, i1 %b, i1 false
  %not_ab = xor i1 %ab, -1
  ret i1 %not_ab
}

define i1 @select_logic_and_fail(i1 %cc, i1 %c, i1 %x, i8 %y) {
; CHECK-LABEL: @select_logic_and_fail(
; CHECK-NEXT:    [[NX:%.*]] = xor i1 [[X:%.*]], true
; CHECK-NEXT:    [[YY:%.*]] = icmp eq i8 [[Y:%.*]], 123
; CHECK-NEXT:    [[B:%.*]] = select i1 [[C:%.*]], i1 [[NX]], i1 [[YY]]
; CHECK-NEXT:    [[AB:%.*]] = select i1 [[CC:%.*]], i1 true, i1 [[B]]
; CHECK-NEXT:    [[NOT_AB:%.*]] = xor i1 [[AB]], true
; CHECK-NEXT:    ret i1 [[NOT_AB]]
;
  %nx = xor i1 %x, -1
  %yy = icmp eq i8 %y, 123
  %b = select i1 %c, i1 %nx, i1 %yy
  %ab = select i1 %cc, i1 true, i1 %b
  %not_ab = xor i1 %ab, -1
  ret i1 %not_ab
}

define i8 @smin_1(i8 %aa, i8 %na, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @smin_1(
; CHECK-NEXT:    [[TMP1:%.*]] = sub i8 [[NA:%.*]], [[AA:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = xor i8 [[Y:%.*]], -124
; CHECK-NEXT:    [[TMP3:%.*]] = select i1 [[C:%.*]], i8 [[X:%.*]], i8 [[TMP2]]
; CHECK-NEXT:    [[NOT_AB:%.*]] = call i8 @llvm.smax.i8(i8 [[TMP1]], i8 [[TMP3]])
; CHECK-NEXT:    ret i8 [[NOT_AB]]
;
  %nx = xor i8 %x, -1
  %yy = xor i8 %y, 123
  %b = select i1 %c, i8 %nx, i8 %yy
  %nna = xor i8 %na, -1
  %a = add i8 %aa, %nna
  %ab = call i8 @llvm.smin.i8(i8 %a, i8 %b)
  %not_ab = xor i8 %ab, -1
  ret i8 %not_ab
}

define i8 @smin_1_fail(i8 %a, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @smin_1_fail(
; CHECK-NEXT:    [[NX:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    [[YY:%.*]] = xor i8 [[Y:%.*]], 123
; CHECK-NEXT:    [[B:%.*]] = select i1 [[C:%.*]], i8 [[NX]], i8 [[YY]]
; CHECK-NEXT:    [[AB:%.*]] = call i8 @llvm.smin.i8(i8 [[A:%.*]], i8 [[B]])
; CHECK-NEXT:    [[NOT_AB:%.*]] = xor i8 [[AB]], -1
; CHECK-NEXT:    ret i8 [[NOT_AB]]
;
  %nx = xor i8 %x, -1
  %yy = xor i8 %y, 123
  %b = select i1 %c, i8 %nx, i8 %yy
  %ab = call i8 @llvm.smin.i8(i8 %a, i8 %b)
  %not_ab = xor i8 %ab, -1
  ret i8 %not_ab
}

define i8 @umin_1_fail(i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @umin_1_fail(
; CHECK-NEXT:    [[NX:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    [[B:%.*]] = select i1 [[C:%.*]], i8 [[NX]], i8 [[Y:%.*]]
; CHECK-NEXT:    [[BA:%.*]] = call i8 @llvm.umin.i8(i8 [[B]], i8 85)
; CHECK-NEXT:    [[NOT_BA:%.*]] = xor i8 [[BA]], -1
; CHECK-NEXT:    ret i8 [[NOT_BA]]
;
  %nx = xor i8 %x, -1
  %b = select i1 %c, i8 %nx, i8 %y
  %ba = call i8 @llvm.umin.i8(i8 %b, i8 85)
  %not_ba = xor i8 %ba, -1
  ret i8 %not_ba
}

define i8 @smax_1(i8 %aa, i8 %na, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @smax_1(
; CHECK-NEXT:    [[TMP1:%.*]] = add i8 [[NA:%.*]], [[AA:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = xor i8 [[Y:%.*]], -124
; CHECK-NEXT:    [[TMP3:%.*]] = select i1 [[C:%.*]], i8 [[X:%.*]], i8 [[TMP2]]
; CHECK-NEXT:    [[NOT_AB:%.*]] = call i8 @llvm.smin.i8(i8 [[TMP1]], i8 [[TMP3]])
; CHECK-NEXT:    ret i8 [[NOT_AB]]
;
  %nx = xor i8 %x, -1
  %yy = xor i8 %y, 123
  %b = select i1 %c, i8 %nx, i8 %yy
  %nna = xor i8 %na, -1
  %a = sub i8 %nna, %aa
  %ab = call i8 @llvm.smax.i8(i8 %a, i8 %b)
  %not_ab = xor i8 %ab, -1
  ret i8 %not_ab
}

define i8 @smax_1_fail(i8 %aa, i8 %na, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @smax_1_fail(
; CHECK-NEXT:    [[NX:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    [[YY:%.*]] = xor i8 [[Y:%.*]], 123
; CHECK-NEXT:    call void @use.i8(i8 [[YY]])
; CHECK-NEXT:    [[B:%.*]] = select i1 [[C:%.*]], i8 [[NX]], i8 [[YY]]
; CHECK-NEXT:    [[NNA:%.*]] = xor i8 [[NA:%.*]], -1
; CHECK-NEXT:    [[A:%.*]] = sub i8 [[NNA]], [[AA:%.*]]
; CHECK-NEXT:    [[AB:%.*]] = call i8 @llvm.smax.i8(i8 [[A]], i8 [[B]])
; CHECK-NEXT:    [[NOT_AB:%.*]] = xor i8 [[AB]], -1
; CHECK-NEXT:    ret i8 [[NOT_AB]]
;
  %nx = xor i8 %x, -1
  %yy = xor i8 %y, 123
  call void @use.i8(i8 %yy)
  %b = select i1 %c, i8 %nx, i8 %yy
  %nna = xor i8 %na, -1
  %a = sub i8 %nna, %aa
  %ab = call i8 @llvm.smax.i8(i8 %a, i8 %b)
  %not_ab = xor i8 %ab, -1
  ret i8 %not_ab
}

define i8 @umax_1(i8 %na, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @umax_1(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], -124
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[C:%.*]], i8 [[X:%.*]], i8 [[TMP1]]
; CHECK-NEXT:    [[NOT_BA:%.*]] = call i8 @llvm.umin.i8(i8 [[TMP2]], i8 -86)
; CHECK-NEXT:    ret i8 [[NOT_BA]]
;
  %nx = xor i8 %x, -1
  %yy = xor i8 %y, 123
  %b = select i1 %c, i8 %nx, i8 %yy
  %ba = call i8 @llvm.umax.i8(i8 %b, i8 85)
  %not_ba = xor i8 %ba, -1
  ret i8 %not_ba
}

define i8 @umax_1_fail(i8 %na, i1 %c, i8 %x, i8 %y) {
; CHECK-LABEL: @umax_1_fail(
; CHECK-NEXT:    [[NX:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    [[YY:%.*]] = xor i8 [[Y:%.*]], 123
; CHECK-NEXT:    [[B:%.*]] = select i1 [[C:%.*]], i8 [[NX]], i8 [[YY]]
; CHECK-NEXT:    call void @use.i8(i8 [[B]])
; CHECK-NEXT:    [[BA:%.*]] = call i8 @llvm.umax.i8(i8 [[B]], i8 85)
; CHECK-NEXT:    [[NOT_BA:%.*]] = xor i8 [[BA]], -1
; CHECK-NEXT:    ret i8 [[NOT_BA]]
;
  %nx = xor i8 %x, -1
  %yy = xor i8 %y, 123
  %b = select i1 %c, i8 %nx, i8 %yy
  call void @use.i8(i8 %b)
  %ba = call i8 @llvm.umax.i8(i8 %b, i8 85)
  %not_ba = xor i8 %ba, -1
  ret i8 %not_ba
}

define i8 @sub_both_freely_invertable_always(i8 %x, i8 %y) {
; CHECK-LABEL: @sub_both_freely_invertable_always(
; CHECK-NEXT:    [[XX:%.*]] = xor i8 [[X:%.*]], 123
; CHECK-NEXT:    [[YY:%.*]] = xor i8 [[Y:%.*]], 45
; CHECK-NEXT:    [[R:%.*]] = sub i8 [[XX]], [[YY]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %xx = xor i8 %x, 123
  %yy = xor i8 %y, 45
  %r = sub i8 %xx, %yy
  ret i8 %r
}

define i8 @add_both_freely_invertable_always(i8 %x, i8 %y) {
; CHECK-LABEL: @add_both_freely_invertable_always(
; CHECK-NEXT:    [[XX:%.*]] = xor i8 [[X:%.*]], 123
; CHECK-NEXT:    [[YY:%.*]] = xor i8 [[Y:%.*]], 45
; CHECK-NEXT:    [[R:%.*]] = add i8 [[XX]], [[YY]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %xx = xor i8 %x, 123
  %yy = xor i8 %y, 45
  %r = add i8 %xx, %yy
  ret i8 %r
}

define i8 @xor_both_freely_invertable_always(i8 %x, i8 %y) {
; CHECK-LABEL: @xor_both_freely_invertable_always(
; CHECK-NEXT:    [[XX:%.*]] = add i8 [[X:%.*]], 123
; CHECK-NEXT:    [[YY:%.*]] = add i8 [[Y:%.*]], 45
; CHECK-NEXT:    [[R:%.*]] = xor i8 [[XX]], [[YY]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %xx = add i8 %x, 123
  %yy = add i8 %y, 45
  %r = xor i8 %xx, %yy
  ret i8 %r
}

define i8 @ashr_both_freely_invertable_always(i8 %x, i8 %y) {
; CHECK-LABEL: @ashr_both_freely_invertable_always(
; CHECK-NEXT:    [[XX:%.*]] = xor i8 [[X:%.*]], 123
; CHECK-NEXT:    [[YY:%.*]] = xor i8 [[Y:%.*]], 45
; CHECK-NEXT:    [[R:%.*]] = ashr i8 [[XX]], [[YY]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %xx = xor i8 %x, 123
  %yy = xor i8 %y, 45
  %r = ashr i8 %xx, %yy
  ret i8 %r
}

define i8 @select_both_freely_invertable_always(i1 %cc, i8 %x, i8 %y) {
; CHECK-LABEL: @select_both_freely_invertable_always(
; CHECK-NEXT:    [[XX:%.*]] = xor i8 [[X:%.*]], 123
; CHECK-NEXT:    [[YY:%.*]] = xor i8 [[Y:%.*]], 45
; CHECK-NEXT:    [[R:%.*]] = select i1 [[CC:%.*]], i8 [[XX]], i8 [[YY]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %xx = xor i8 %x, 123
  %yy = xor i8 %y, 45
  %r = select i1 %cc, i8 %xx, i8 %yy
  ret i8 %r
}

define i8 @umin_both_freely_invertable_always(i8 %x, i8 %y) {
; CHECK-LABEL: @umin_both_freely_invertable_always(
; CHECK-NEXT:    [[XX:%.*]] = xor i8 [[X:%.*]], 123
; CHECK-NEXT:    [[YY:%.*]] = xor i8 [[Y:%.*]], 45
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.umin.i8(i8 [[XX]], i8 [[YY]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %xx = xor i8 %x, 123
  %yy = xor i8 %y, 45
  %r = call i8 @llvm.umin.i8(i8 %xx, i8 %yy)
  ret i8 %r
}

define i8 @umax_both_freely_invertable_always(i8 %x, i8 %y) {
; CHECK-LABEL: @umax_both_freely_invertable_always(
; CHECK-NEXT:    [[XX:%.*]] = xor i8 [[X:%.*]], 123
; CHECK-NEXT:    [[YY:%.*]] = xor i8 [[Y:%.*]], 45
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.umax.i8(i8 [[XX]], i8 [[YY]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %xx = xor i8 %x, 123
  %yy = xor i8 %y, 45
  %r = call i8 @llvm.umax.i8(i8 %xx, i8 %yy)
  ret i8 %r
}

define i8 @smin_both_freely_invertable_always(i8 %x, i8 %y) {
; CHECK-LABEL: @smin_both_freely_invertable_always(
; CHECK-NEXT:    [[XX:%.*]] = xor i8 [[X:%.*]], 123
; CHECK-NEXT:    [[YY:%.*]] = xor i8 [[Y:%.*]], 45
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.smin.i8(i8 [[XX]], i8 [[YY]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %xx = xor i8 %x, 123
  %yy = xor i8 %y, 45
  %r = call i8 @llvm.smin.i8(i8 %xx, i8 %yy)
  ret i8 %r
}

define i8 @smax_both_freely_invertable_always(i8 %x, i8 %y) {
; CHECK-LABEL: @smax_both_freely_invertable_always(
; CHECK-NEXT:    [[XX:%.*]] = xor i8 [[X:%.*]], 123
; CHECK-NEXT:    [[YY:%.*]] = xor i8 [[Y:%.*]], 45
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.smax.i8(i8 [[XX]], i8 [[YY]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %xx = xor i8 %x, 123
  %yy = xor i8 %y, 45
  %r = call i8 @llvm.smax.i8(i8 %xx, i8 %yy)
  ret i8 %r
}

define i8 @lshr_nneg(i8 %x, i8 %y) {
; CHECK-LABEL: @lshr_nneg(
; CHECK-NEXT:    [[NEG:%.*]] = icmp slt i8 [[X:%.*]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[NEG]])
; CHECK-NEXT:    [[SHR_NOT:%.*]] = ashr i8 [[X]], [[Y:%.*]]
; CHECK-NEXT:    ret i8 [[SHR_NOT]]
;
  %neg = icmp slt i8 %x, 0
  call void @llvm.assume(i1 %neg)
  %x.not = xor i8 %x, -1
  %shr = lshr i8 %x.not, %y
  %shr.not = xor i8 %shr, -1
  ret i8 %shr.not
}

define i8 @lshr_not_nneg(i8 %x, i8 %y) {
; CHECK-LABEL: @lshr_not_nneg(
; CHECK-NEXT:    [[X_NOT:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    [[SHR:%.*]] = lshr i8 [[X_NOT]], [[Y:%.*]]
; CHECK-NEXT:    [[SHR_NOT:%.*]] = xor i8 [[SHR]], -1
; CHECK-NEXT:    ret i8 [[SHR_NOT]]
;
  %x.not = xor i8 %x, -1
  %shr = lshr i8 %x.not, %y
  %shr.not = xor i8 %shr, -1
  ret i8 %shr.not
}

define i8 @lshr_not_nneg2(i8 %x) {
; CHECK-LABEL: @lshr_not_nneg2(
; CHECK-NEXT:    [[SHR:%.*]] = lshr i8 [[X:%.*]], 1
; CHECK-NEXT:    [[SHR_NOT:%.*]] = or disjoint i8 [[SHR]], -128
; CHECK-NEXT:    ret i8 [[SHR_NOT]]
;
  %x.not = xor i8 %x, -1
  %shr = lshr i8 %x.not, 1
  %shr.not = xor i8 %shr, -1
  ret i8 %shr.not
}

define i1 @test_inv_free(i1 %c1, i1 %c2, i1 %c3, i1 %c4) {
; CHECK-LABEL: @test_inv_free(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C1:%.*]], label [[B1:%.*]], label [[B2:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    br i1 [[C2:%.*]], label [[EXIT:%.*]], label [[B3:%.*]]
; CHECK:       b2:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       b3:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[VAL_NOT:%.*]] = phi i1 [ false, [[B1]] ], [ true, [[B2]] ], [ [[C3:%.*]], [[B3]] ]
; CHECK-NEXT:    [[COND_NOT:%.*]] = and i1 [[VAL_NOT]], [[C4:%.*]]
; CHECK-NEXT:    br i1 [[COND_NOT]], label [[B5:%.*]], label [[B4:%.*]]
; CHECK:       b4:
; CHECK-NEXT:    ret i1 true
; CHECK:       b5:
; CHECK-NEXT:    ret i1 false
;
entry:
  br i1 %c1, label %b1, label %b2
b1:
  br i1 %c2, label %exit, label %b3
b2:
  br label %exit
b3:
  %invc3 = xor i1 %c3, true
  br label %exit
exit:
  %val = phi i1 [ true, %b1 ], [ false, %b2 ], [ %invc3, %b3 ]
  %inv = xor i1 %c4, true
  %cond = or i1 %val, %inv
  br i1 %cond, label %b4, label %b5
b4:
  ret i1 true
b5:
  ret i1 false
}

define i32 @test_inv_free_i32(i1 %c1, i1 %c2, i32 %c3, i32 %c4) {
; CHECK-LABEL: @test_inv_free_i32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C1:%.*]], label [[B1:%.*]], label [[B2:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    br i1 [[C2:%.*]], label [[EXIT:%.*]], label [[B3:%.*]]
; CHECK:       b2:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       b3:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[TMP0:%.*]] = phi i32 [ 0, [[B1]] ], [ -1, [[B2]] ], [ [[C3:%.*]], [[B3]] ]
; CHECK-NEXT:    [[COND:%.*]] = xor i32 [[C4:%.*]], [[TMP0]]
; CHECK-NEXT:    ret i32 [[COND]]
;
entry:
  br i1 %c1, label %b1, label %b2
b1:
  br i1 %c2, label %exit, label %b3
b2:
  br label %exit
b3:
  %invc3 = xor i32 %c3, -1
  br label %exit
exit:
  %val = phi i32 [ -1, %b1 ], [ 0, %b2 ], [ %invc3, %b3 ]
  %inv = xor i32 %c4, -1
  %cond = xor i32 %val, %inv
  ret i32 %cond
}

; Negative tests

define i1 @test_inv_free_multiuse(i1 %c1, i1 %c2, i1 %c3, i1 %c4) {
; CHECK-LABEL: @test_inv_free_multiuse(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C1:%.*]], label [[B1:%.*]], label [[B2:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    br i1 [[C2:%.*]], label [[EXIT:%.*]], label [[B3:%.*]]
; CHECK:       b2:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       b3:
; CHECK-NEXT:    [[INVC3:%.*]] = xor i1 [[C3:%.*]], true
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[VAL:%.*]] = phi i1 [ true, [[B1]] ], [ false, [[B2]] ], [ [[INVC3]], [[B3]] ]
; CHECK-NEXT:    call void @use.i1(i1 [[VAL]])
; CHECK-NEXT:    [[INV:%.*]] = xor i1 [[C4:%.*]], true
; CHECK-NEXT:    [[COND:%.*]] = or i1 [[VAL]], [[INV]]
; CHECK-NEXT:    br i1 [[COND]], label [[B4:%.*]], label [[B5:%.*]]
; CHECK:       b4:
; CHECK-NEXT:    ret i1 true
; CHECK:       b5:
; CHECK-NEXT:    ret i1 false
;
entry:
  br i1 %c1, label %b1, label %b2
b1:
  br i1 %c2, label %exit, label %b3
b2:
  br label %exit
b3:
  %invc3 = xor i1 %c3, true
  br label %exit
exit:
  %val = phi i1 [ true, %b1 ], [ false, %b2 ], [ %invc3, %b3 ]
  call void @use.i1(i1 %val)
  %inv = xor i1 %c4, true
  %cond = or i1 %val, %inv
  br i1 %cond, label %b4, label %b5
b4:
  ret i1 true
b5:
  ret i1 false
}

define i32 @test_inv_free_i32_newinst(i1 %c1, i1 %c2, i32 %c3, i32 %c4) {
; CHECK-LABEL: @test_inv_free_i32_newinst(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C1:%.*]], label [[B1:%.*]], label [[B2:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    br i1 [[C2:%.*]], label [[EXIT:%.*]], label [[B3:%.*]]
; CHECK:       b2:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       b3:
; CHECK-NEXT:    [[ASHR:%.*]] = ashr i32 -8, [[C3:%.*]]
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[VAL:%.*]] = phi i32 [ -1, [[B1]] ], [ 0, [[B2]] ], [ [[ASHR]], [[B3]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = xor i32 [[C4:%.*]], [[VAL]]
; CHECK-NEXT:    [[COND:%.*]] = xor i32 [[TMP0]], -1
; CHECK-NEXT:    ret i32 [[COND]]
;
entry:
  br i1 %c1, label %b1, label %b2
b1:
  br i1 %c2, label %exit, label %b3
b2:
  br label %exit
b3:
  %ashr = ashr i32 -8, %c3
  br label %exit
exit:
  %val = phi i32 [ -1, %b1 ], [ 0, %b2 ], [ %ashr, %b3 ]
  %inv = xor i32 %c4, -1
  %cond = xor i32 %val, %inv
  ret i32 %cond
}

define i1 @test_inv_free_loop(i1 %c1, i1 %c2, i1 %c3, i1 %c4) {
; CHECK-LABEL: @test_inv_free_loop(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C1:%.*]], label [[B1:%.*]], label [[B2:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    br i1 [[C2:%.*]], label [[EXIT:%.*]], label [[B3:%.*]]
; CHECK:       b2:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       b3:
; CHECK-NEXT:    [[INVC3:%.*]] = xor i1 [[C3:%.*]], true
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[VAL:%.*]] = phi i1 [ true, [[B1]] ], [ false, [[B2]] ], [ [[INVC3]], [[B3]] ], [ [[NOT:%.*]], [[EXIT]] ]
; CHECK-NEXT:    [[INV:%.*]] = xor i1 [[C4:%.*]], true
; CHECK-NEXT:    [[COND:%.*]] = or i1 [[VAL]], [[INV]]
; CHECK-NEXT:    [[NOT]] = xor i1 [[VAL]], true
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT]], label [[B4:%.*]]
; CHECK:       b4:
; CHECK-NEXT:    ret i1 true
;
entry:
  br i1 %c1, label %b1, label %b2
b1:
  br i1 %c2, label %exit, label %b3
b2:
  br label %exit
b3:
  %invc3 = xor i1 %c3, true
  br label %exit
exit:
  %val = phi i1 [ true, %b1 ], [ false, %b2 ], [ %invc3, %b3 ], [ %not, %exit ]
  %inv = xor i1 %c4, true
  %cond = or i1 %val, %inv
  %not = xor i1 %val, true
  br i1 %cond, label %exit, label %b4
b4:
  ret i1 true
}