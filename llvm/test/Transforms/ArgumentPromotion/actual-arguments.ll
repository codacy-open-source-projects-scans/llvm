; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes
; RUN: opt -S -passes=argpromotion < %s | FileCheck %s

; In the following tests, the call to @callee may invalidate ptr %test_c and so
; prohibit removing loads of %test_c following the call, preventing Argument
; Promotion of %test_c in the general case.

; This is called by @caller_ptr_args, from which we cannot prove anything about
; whether %test_c may alias %p and so we cannot promote %test_c.
;
define internal i32 @test_cannot_promote_1(ptr %p, ptr nocapture readonly %test_c) {
; CHECK-LABEL: define {{[^@]+}}@test_cannot_promote_1
; CHECK-SAME: (ptr [[P:%.*]], ptr nocapture readonly [[TEST_C:%.*]]) {
; CHECK-NEXT:    [[TEST_C_VAL:%.*]] = load i32, ptr [[TEST_C]], align 4
; CHECK-NEXT:    [[RES:%.*]] = call i32 @callee(ptr [[P]], i32 [[TEST_C_VAL]])
; CHECK-NEXT:    [[LTEST_C:%.*]] = load i32, ptr [[TEST_C]], align 4
; CHECK-NEXT:    [[SUM:%.*]] = add i32 [[LTEST_C]], [[RES]]
; CHECK-NEXT:    ret i32 [[SUM]]
;
  %res = call i32 @callee(ptr %p, ptr %test_c)

  %ltest_c = load i32, ptr %test_c

  %sum = add i32 %ltest_c, %res

  ret i32 %sum
}

; This is called by @caller_aliased_args, from which we can see that %test_c may
; alias %p and so we cannot promote %test_c.
;
define internal i32 @test_cannot_promote_2(ptr %p, ptr nocapture readonly %test_c) {
; CHECK-LABEL: define {{[^@]+}}@test_cannot_promote_2
; CHECK-SAME: (ptr [[P:%.*]], ptr nocapture readonly [[TEST_C:%.*]]) {
; CHECK-NEXT:    [[TEST_C_VAL:%.*]] = load i32, ptr [[TEST_C]], align 4
; CHECK-NEXT:    [[RES:%.*]] = call i32 @callee(ptr [[P]], i32 [[TEST_C_VAL]])
; CHECK-NEXT:    [[LTEST_C:%.*]] = load i32, ptr [[TEST_C]], align 4
; CHECK-NEXT:    [[SUM:%.*]] = add i32 [[LTEST_C]], [[RES]]
; CHECK-NEXT:    ret i32 [[SUM]]
;
  %res = call i32 @callee(ptr %p, ptr %test_c)

  %ltest_c = load i32, ptr %test_c

  %sum = add i32 %ltest_c, %res

  ret i32 %sum
}

; This is called by @caller_safe_args_1, but also from @caller_aliased_args, so
; we cannot promote %test_c.
;
define internal i32 @test_cannot_promote_3(ptr %p, ptr nocapture readonly %test_c) {
; CHECK-LABEL: define {{[^@]+}}@test_cannot_promote_3
; CHECK-SAME: (ptr [[P:%.*]], ptr nocapture readonly [[TEST_C:%.*]]) {
; CHECK-NEXT:    [[TEST_C_VAL:%.*]] = load i32, ptr [[TEST_C]], align 4
; CHECK-NEXT:    [[RES:%.*]] = call i32 @callee(ptr [[P]], i32 [[TEST_C_VAL]])
; CHECK-NEXT:    [[LTEST_C:%.*]] = load i32, ptr [[TEST_C]], align 4
; CHECK-NEXT:    [[SUM:%.*]] = add i32 [[LTEST_C]], [[RES]]
; CHECK-NEXT:    ret i32 [[SUM]]
;
  %res = call i32 @callee(ptr %p, ptr %test_c)

  %ltest_c = load i32, ptr %test_c

  %sum = add i32 %ltest_c, %res

  ret i32 %sum
}

; This is called only by @caller_safe_args_1, from which we can prove that
; %test_c does not alias %p for any Call to the function, so we can promote it.
;
define internal i32 @test_can_promote_1(ptr %p, ptr nocapture readonly %test_c) {
; CHECK-LABEL: define {{[^@]+}}@test_can_promote_1
; CHECK-SAME: (ptr [[P:%.*]], i32 [[TEST_C_0_VAL:%.*]]) {
; CHECK-NEXT:    [[RES:%.*]] = call i32 @callee(ptr [[P]], i32 [[TEST_C_0_VAL]])
; CHECK-NEXT:    [[SUM:%.*]] = add i32 [[TEST_C_0_VAL]], [[RES]]
; CHECK-NEXT:    ret i32 [[SUM]]
;
  %res = call i32 @callee(ptr %p, ptr %test_c)

  %ltest_c = load i32, ptr %test_c

  %sum = add i32 %ltest_c, %res

  ret i32 %sum
}

; This is called by multiple callers (@caller_safe_args_1, @caller_safe_args_2),
; from which we can prove that %test_c does not alias %p for any Call to the
; function, so we can promote it.
;
define internal i32 @test_can_promote_2(ptr %p, ptr nocapture readonly %test_c) {
; CHECK-LABEL: define {{[^@]+}}@test_can_promote_2
; CHECK-SAME: (ptr [[P:%.*]], i32 [[TEST_C_0_VAL:%.*]]) {
; CHECK-NEXT:    [[RES:%.*]] = call i32 @callee(ptr [[P]], i32 [[TEST_C_0_VAL]])
; CHECK-NEXT:    [[SUM:%.*]] = add i32 [[TEST_C_0_VAL]], [[RES]]
; CHECK-NEXT:    ret i32 [[SUM]]
;
  %res = call i32 @callee(ptr %p, ptr %test_c)

  %ltest_c = load i32, ptr %test_c

  %sum = add i32 %ltest_c, %res

  ret i32 %sum
}

; Called by @test_XXX
define internal i32 @callee(ptr %p, ptr nocapture readonly %callee_c) {
; CHECK-LABEL: define {{[^@]+}}@callee
; CHECK-SAME: (ptr [[P:%.*]], i32 [[CALLEE_C_0_VAL:%.*]]) {
; CHECK-NEXT:    [[A:%.*]] = load i32, ptr [[P]], align 4
; CHECK-NEXT:    [[SUM:%.*]] = add i32 [[A]], [[CALLEE_C_0_VAL]]
; CHECK-NEXT:    store i32 [[SUM]], ptr [[P]], align 4
; CHECK-NEXT:    ret i32 [[SUM]]
;
  %a = load i32, ptr %p

  %lcallee_c = load i32, ptr %callee_c

  %sum = add i32 %a, %lcallee_c

  store i32 %sum, ptr %p

  ret i32 %sum
}

; Calls @test_cannot_promote_1
define i32 @caller_ptr_args(i64 %n, ptr %p1, ptr %p2) {
; CHECK-LABEL: define {{[^@]+}}@caller_ptr_args
; CHECK-SAME: (i64 [[N:%.*]], ptr [[P1:%.*]], ptr [[P2:%.*]]) {
; CHECK-NEXT:    call void @memset(ptr [[P1]], i64 0, i64 [[N]])
; CHECK-NEXT:    store i32 5, ptr [[P2]], align 4
; CHECK-NEXT:    [[RES:%.*]] = call i32 @test_cannot_promote_1(ptr [[P1]], ptr [[P2]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  call void @memset(ptr %p1, i64 0, i64 %n)

  store i32 5, ptr %p2

  %res = call i32 @test_cannot_promote_1(ptr %p1, ptr %p2)

  ret i32 %res
}

; Calls @test_cannot_promote_2
; Calls @test_cannot_promote_3
define i32 @caller_aliased_args() {
; CHECK-LABEL: define {{[^@]+}}@caller_aliased_args() {
; CHECK-NEXT:    [[CALLER_C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i32 5, ptr [[CALLER_C]], align 4
; CHECK-NEXT:    [[RES1:%.*]] = call i32 @test_cannot_promote_2(ptr [[CALLER_C]], ptr [[CALLER_C]])
; CHECK-NEXT:    [[RES2:%.*]] = call i32 @test_cannot_promote_3(ptr [[CALLER_C]], ptr [[CALLER_C]])
; CHECK-NEXT:    [[RES:%.*]] = add i32 [[RES1]], [[RES2]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %caller_c = alloca i32
  store i32 5, ptr %caller_c

  %res1 = call i32 @test_cannot_promote_2(ptr %caller_c, ptr %caller_c)
  %res2 = call i32 @test_cannot_promote_3(ptr %caller_c, ptr %caller_c)

  %res = add i32 %res1, %res2

  ret i32 %res
}

; Calls @test_cannot_promote_3
; Calls @test_can_promote_1
; Calls @test_can_promote_2
define i32 @caller_safe_args_1(i64 %n) {
; CHECK-LABEL: define {{[^@]+}}@caller_safe_args_1
; CHECK-SAME: (i64 [[N:%.*]]) {
; CHECK-NEXT:    [[P:%.*]] = alloca [5 x double], i64 [[N]], align 8
; CHECK-NEXT:    call void @memset(ptr [[P]], i64 0, i64 [[N]])
; CHECK-NEXT:    [[CALLER_C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i32 5, ptr [[CALLER_C]], align 4
; CHECK-NEXT:    [[RES1:%.*]] = call i32 @test_cannot_promote_3(ptr [[P]], ptr [[CALLER_C]])
; CHECK-NEXT:    [[CALLER_C_VAL:%.*]] = load i32, ptr [[CALLER_C]], align 4
; CHECK-NEXT:    [[RES2:%.*]] = call i32 @test_can_promote_1(ptr [[P]], i32 [[CALLER_C_VAL]])
; CHECK-NEXT:    [[CALLER_C_VAL1:%.*]] = load i32, ptr [[CALLER_C]], align 4
; CHECK-NEXT:    [[RES3:%.*]] = call i32 @test_can_promote_2(ptr [[P]], i32 [[CALLER_C_VAL1]])
; CHECK-NEXT:    [[RES12:%.*]] = add i32 [[RES1]], [[RES2]]
; CHECK-NEXT:    [[RES:%.*]] = add i32 [[RES12]], [[RES3]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %p = alloca [5 x double], i64 %n
  call void @memset(ptr %p, i64 0, i64 %n)

  %caller_c = alloca i32
  store i32 5, ptr %caller_c

  %res1 = call i32 @test_cannot_promote_3(ptr %p, ptr %caller_c)
  %res2 = call i32 @test_can_promote_1(ptr %p, ptr %caller_c)
  %res3 = call i32 @test_can_promote_2(ptr %p, ptr %caller_c)

  %res12 = add i32 %res1, %res2
  %res = add i32 %res12, %res3

  ret i32 %res
}

; Calls @test_can_promote_2
define i32 @caller_safe_args_2(i64 %n, ptr %p) {
; CHECK-LABEL: define {{[^@]+}}@caller_safe_args_2
; CHECK-SAME: (i64 [[N:%.*]], ptr [[P:%.*]]) {
; CHECK-NEXT:    call void @memset(ptr [[P]], i64 0, i64 [[N]])
; CHECK-NEXT:    [[CALLER_C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i32 5, ptr [[CALLER_C]], align 4
; CHECK-NEXT:    [[CALLER_C_VAL:%.*]] = load i32, ptr [[CALLER_C]], align 4
; CHECK-NEXT:    [[RES:%.*]] = call i32 @test_can_promote_2(ptr [[P]], i32 [[CALLER_C_VAL]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  call void @memset(ptr %p, i64 0, i64 %n)

  %caller_c = alloca i32
  store i32 5, ptr %caller_c

  %res = call i32 @test_can_promote_2(ptr %p, ptr %caller_c)

  ret i32 %res
}

declare void @memset(ptr, i64, i64)