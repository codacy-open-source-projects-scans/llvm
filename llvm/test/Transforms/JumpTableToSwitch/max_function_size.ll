; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt < %s -passes=jump-table-to-switch -jump-table-to-switch-function-size-threshold=1 -verify-dom-info -S | FileCheck %s

@func_array0 = constant [2 x ptr] [ptr @func0, ptr @large_func]

define i32 @func0() {
  ret i32 1
}

define i32 @large_func() {
  %x = add i32 1, 2
  ret i32 %x
}

define i32 @function_with_jump_table_with_large_func(i32 %index) {
; CHECK-LABEL: define i32 @function_with_jump_table_with_large_func(
; CHECK-SAME: i32 [[INDEX:%.*]]) {
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds [2 x ptr], ptr @func_array0, i32 0, i32 [[INDEX]]
; CHECK-NEXT:    [[FUNC_PTR:%.*]] = load ptr, ptr [[GEP]], align 8
; CHECK-NEXT:    [[RESULT:%.*]] = call i32 [[FUNC_PTR]]()
; CHECK-NEXT:    ret i32 [[RESULT]]
;
  %gep = getelementptr inbounds [2 x ptr], ptr @func_array0, i32 0, i32 %index
  %func_ptr = load ptr, ptr %gep, align 8
  %result = call i32 %func_ptr()
  ret i32 %result
}
