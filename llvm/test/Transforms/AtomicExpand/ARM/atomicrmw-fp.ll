; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=armv7-apple-ios7.0 -passes=atomic-expand %s | FileCheck %s

define float @test_atomicrmw_fadd_f32(ptr %ptr, float %value) {
; CHECK-LABEL: @test_atomicrmw_fadd_f32(
; CHECK-NEXT:    call void @llvm.arm.dmb(i32 11)
; CHECK-NEXT:    [[TMP1:%.*]] = load float, ptr [[PTR:%.*]], align 4
; CHECK-NEXT:    br label [[ATOMICRMW_START:%.*]]
; CHECK:       atomicrmw.start:
; CHECK-NEXT:    [[LOADED:%.*]] = phi float [ [[TMP1]], [[TMP0:%.*]] ], [ [[TMP5:%.*]], [[ATOMICRMW_START]] ]
; CHECK-NEXT:    [[NEW:%.*]] = fadd float [[LOADED]], [[VALUE:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast float [[NEW]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast float [[LOADED]] to i32
; CHECK-NEXT:    [[TMP4:%.*]] = cmpxchg ptr [[PTR]], i32 [[TMP3]], i32 [[TMP2]] monotonic monotonic, align 4
; CHECK-NEXT:    [[SUCCESS:%.*]] = extractvalue { i32, i1 } [[TMP4]], 1
; CHECK-NEXT:    [[NEWLOADED:%.*]] = extractvalue { i32, i1 } [[TMP4]], 0
; CHECK-NEXT:    [[TMP5]] = bitcast i32 [[NEWLOADED]] to float
; CHECK-NEXT:    br i1 [[SUCCESS]], label [[ATOMICRMW_END:%.*]], label [[ATOMICRMW_START]]
; CHECK:       atomicrmw.end:
; CHECK-NEXT:    call void @llvm.arm.dmb(i32 11)
; CHECK-NEXT:    ret float [[TMP5]]
;
  %res = atomicrmw fadd ptr %ptr, float %value seq_cst
  ret float %res
}

define float @test_atomicrmw_fsub_f32(ptr %ptr, float %value) {
; CHECK-LABEL: @test_atomicrmw_fsub_f32(
; CHECK-NEXT:    call void @llvm.arm.dmb(i32 11)
; CHECK-NEXT:    [[TMP1:%.*]] = load float, ptr [[PTR:%.*]], align 4
; CHECK-NEXT:    br label [[ATOMICRMW_START:%.*]]
; CHECK:       atomicrmw.start:
; CHECK-NEXT:    [[LOADED:%.*]] = phi float [ [[TMP1]], [[TMP0:%.*]] ], [ [[TMP5:%.*]], [[ATOMICRMW_START]] ]
; CHECK-NEXT:    [[NEW:%.*]] = fsub float [[LOADED]], [[VALUE:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast float [[NEW]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast float [[LOADED]] to i32
; CHECK-NEXT:    [[TMP4:%.*]] = cmpxchg ptr [[PTR]], i32 [[TMP3]], i32 [[TMP2]] monotonic monotonic, align 4
; CHECK-NEXT:    [[SUCCESS:%.*]] = extractvalue { i32, i1 } [[TMP4]], 1
; CHECK-NEXT:    [[NEWLOADED:%.*]] = extractvalue { i32, i1 } [[TMP4]], 0
; CHECK-NEXT:    [[TMP5]] = bitcast i32 [[NEWLOADED]] to float
; CHECK-NEXT:    br i1 [[SUCCESS]], label [[ATOMICRMW_END:%.*]], label [[ATOMICRMW_START]]
; CHECK:       atomicrmw.end:
; CHECK-NEXT:    call void @llvm.arm.dmb(i32 11)
; CHECK-NEXT:    ret float [[TMP5]]
;
  %res = atomicrmw fsub ptr %ptr, float %value seq_cst
  ret float %res
}
