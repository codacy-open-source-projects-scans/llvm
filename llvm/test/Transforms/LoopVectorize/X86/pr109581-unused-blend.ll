; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -p loop-vectorize -S %s | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Test case for https://github.com/llvm/llvm-project/issues/109581.
define i32 @unused_blend_after_unrolling(ptr %p, i32 %a, i1 %c.1, i16 %x, i16 %y) {
; CHECK-LABEL: define i32 @unused_blend_after_unrolling(
; CHECK-SAME: ptr [[P:%.*]], i32 [[A:%.*]], i1 [[C_1:%.*]], i16 [[X:%.*]], i16 [[Y:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    [[C:%.*]] = icmp eq i32 [[A]], 0
; CHECK-NEXT:    br i1 false, label %[[SCALAR_PH:.*]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <4 x i1> poison, i1 [[C_1]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <4 x i1> [[BROADCAST_SPLATINSERT]], <4 x i1> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT16:%.*]] = insertelement <4 x i1> poison, i1 [[C]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT17:%.*]] = shufflevector <4 x i1> [[BROADCAST_SPLATINSERT16]], <4 x i1> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK:       [[VECTOR_BODY]]:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[PRED_SDIV_CONTINUE15:.*]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i1> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP24:%.*]], %[[PRED_SDIV_CONTINUE15]] ]
; CHECK-NEXT:    [[VEC_PHI1:%.*]] = phi <4 x i1> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP25:%.*]], %[[PRED_SDIV_CONTINUE15]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = xor <4 x i1> [[BROADCAST_SPLAT]], <i1 true, i1 true, i1 true, i1 true>
; CHECK-NEXT:    [[TMP1:%.*]] = xor <4 x i1> [[BROADCAST_SPLAT]], <i1 true, i1 true, i1 true, i1 true>
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <4 x i1> [[TMP0]], i32 0
; CHECK-NEXT:    br i1 [[TMP2]], label %[[PRED_SDIV_IF:.*]], label %[[PRED_SDIV_CONTINUE:.*]]
; CHECK:       [[PRED_SDIV_IF]]:
; CHECK-NEXT:    br label %[[PRED_SDIV_CONTINUE]]
; CHECK:       [[PRED_SDIV_CONTINUE]]:
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <4 x i1> [[TMP0]], i32 1
; CHECK-NEXT:    br i1 [[TMP3]], label %[[PRED_SDIV_IF2:.*]], label %[[PRED_SDIV_CONTINUE3:.*]]
; CHECK:       [[PRED_SDIV_IF2]]:
; CHECK-NEXT:    br label %[[PRED_SDIV_CONTINUE3]]
; CHECK:       [[PRED_SDIV_CONTINUE3]]:
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <4 x i1> [[TMP0]], i32 2
; CHECK-NEXT:    br i1 [[TMP4]], label %[[PRED_SDIV_IF4:.*]], label %[[PRED_SDIV_CONTINUE5:.*]]
; CHECK:       [[PRED_SDIV_IF4]]:
; CHECK-NEXT:    br label %[[PRED_SDIV_CONTINUE5]]
; CHECK:       [[PRED_SDIV_CONTINUE5]]:
; CHECK-NEXT:    [[TMP5:%.*]] = extractelement <4 x i1> [[TMP0]], i32 3
; CHECK-NEXT:    br i1 [[TMP5]], label %[[PRED_SDIV_IF6:.*]], label %[[PRED_SDIV_CONTINUE7:.*]]
; CHECK:       [[PRED_SDIV_IF6]]:
; CHECK-NEXT:    br label %[[PRED_SDIV_CONTINUE7]]
; CHECK:       [[PRED_SDIV_CONTINUE7]]:
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <4 x i1> [[TMP1]], i32 0
; CHECK-NEXT:    br i1 [[TMP6]], label %[[PRED_SDIV_IF8:.*]], label %[[PRED_SDIV_CONTINUE9:.*]]
; CHECK:       [[PRED_SDIV_IF8]]:
; CHECK-NEXT:    [[TMP7:%.*]] = sdiv i16 [[X]], [[Y]]
; CHECK-NEXT:    [[TMP8:%.*]] = insertelement <4 x i16> poison, i16 [[TMP7]], i32 0
; CHECK-NEXT:    br label %[[PRED_SDIV_CONTINUE9]]
; CHECK:       [[PRED_SDIV_CONTINUE9]]:
; CHECK-NEXT:    [[TMP9:%.*]] = phi <4 x i16> [ poison, %[[PRED_SDIV_CONTINUE7]] ], [ [[TMP8]], %[[PRED_SDIV_IF8]] ]
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <4 x i1> [[TMP1]], i32 1
; CHECK-NEXT:    br i1 [[TMP10]], label %[[PRED_SDIV_IF10:.*]], label %[[PRED_SDIV_CONTINUE11:.*]]
; CHECK:       [[PRED_SDIV_IF10]]:
; CHECK-NEXT:    [[TMP11:%.*]] = sdiv i16 [[X]], [[Y]]
; CHECK-NEXT:    [[TMP12:%.*]] = insertelement <4 x i16> [[TMP9]], i16 [[TMP11]], i32 1
; CHECK-NEXT:    br label %[[PRED_SDIV_CONTINUE11]]
; CHECK:       [[PRED_SDIV_CONTINUE11]]:
; CHECK-NEXT:    [[TMP13:%.*]] = phi <4 x i16> [ [[TMP9]], %[[PRED_SDIV_CONTINUE9]] ], [ [[TMP12]], %[[PRED_SDIV_IF10]] ]
; CHECK-NEXT:    [[TMP14:%.*]] = extractelement <4 x i1> [[TMP1]], i32 2
; CHECK-NEXT:    br i1 [[TMP14]], label %[[PRED_SDIV_IF12:.*]], label %[[PRED_SDIV_CONTINUE13:.*]]
; CHECK:       [[PRED_SDIV_IF12]]:
; CHECK-NEXT:    [[TMP15:%.*]] = sdiv i16 [[X]], [[Y]]
; CHECK-NEXT:    [[TMP16:%.*]] = insertelement <4 x i16> [[TMP13]], i16 [[TMP15]], i32 2
; CHECK-NEXT:    br label %[[PRED_SDIV_CONTINUE13]]
; CHECK:       [[PRED_SDIV_CONTINUE13]]:
; CHECK-NEXT:    [[TMP17:%.*]] = phi <4 x i16> [ [[TMP13]], %[[PRED_SDIV_CONTINUE11]] ], [ [[TMP16]], %[[PRED_SDIV_IF12]] ]
; CHECK-NEXT:    [[TMP18:%.*]] = extractelement <4 x i1> [[TMP1]], i32 3
; CHECK-NEXT:    br i1 [[TMP18]], label %[[PRED_SDIV_IF14:.*]], label %[[PRED_SDIV_CONTINUE15]]
; CHECK:       [[PRED_SDIV_IF14]]:
; CHECK-NEXT:    [[TMP19:%.*]] = sdiv i16 [[X]], [[Y]]
; CHECK-NEXT:    [[TMP20:%.*]] = insertelement <4 x i16> [[TMP17]], i16 [[TMP19]], i32 3
; CHECK-NEXT:    br label %[[PRED_SDIV_CONTINUE15]]
; CHECK:       [[PRED_SDIV_CONTINUE15]]:
; CHECK-NEXT:    [[TMP21:%.*]] = phi <4 x i16> [ [[TMP17]], %[[PRED_SDIV_CONTINUE13]] ], [ [[TMP20]], %[[PRED_SDIV_IF14]] ]
; CHECK-NEXT:    [[PREDPHI:%.*]] = select <4 x i1> [[BROADCAST_SPLAT]], <4 x i16> zeroinitializer, <4 x i16> [[TMP21]]
; CHECK-NEXT:    [[TMP22:%.*]] = xor <4 x i1> [[BROADCAST_SPLAT17]], <i1 true, i1 true, i1 true, i1 true>
; CHECK-NEXT:    [[TMP23:%.*]] = xor <4 x i1> [[BROADCAST_SPLAT17]], <i1 true, i1 true, i1 true, i1 true>
; CHECK-NEXT:    [[TMP24]] = or <4 x i1> [[VEC_PHI]], [[TMP22]]
; CHECK-NEXT:    [[TMP25]] = or <4 x i1> [[VEC_PHI1]], [[TMP23]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 8
; CHECK-NEXT:    [[TMP26:%.*]] = icmp eq i32 [[INDEX_NEXT]], 96
; CHECK-NEXT:    br i1 [[TMP26]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       [[MIDDLE_BLOCK]]:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = or <4 x i1> [[TMP25]], [[TMP24]]
; CHECK-NEXT:    [[TMP27:%.*]] = call i1 @llvm.vector.reduce.or.v4i1(<4 x i1> [[BIN_RDX]])
; CHECK-NEXT:    [[TMP28:%.*]] = freeze i1 [[TMP27]]
; CHECK-NEXT:    [[RDX_SELECT:%.*]] = select i1 [[TMP28]], i32 0, i32 0
; CHECK-NEXT:    [[TMP29:%.*]] = extractelement <4 x i16> [[PREDPHI]], i32 3
; CHECK-NEXT:    br i1 false, label %[[EXIT:.*]], label %[[SCALAR_PH]]
; CHECK:       [[SCALAR_PH]]:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ 97, %[[MIDDLE_BLOCK]] ], [ 1, %[[ENTRY]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i32 [ [[RDX_SELECT]], %[[MIDDLE_BLOCK]] ], [ 0, %[[ENTRY]] ]
; CHECK-NEXT:    br label %[[LOOP_HEADER:.*]]
; CHECK:       [[LOOP_HEADER]]:
; CHECK-NEXT:    [[B:%.*]] = phi i32 [ [[BC_MERGE_RDX]], %[[SCALAR_PH]] ], [ [[SEL:%.*]], %[[LOOP_LATCH:.*]] ]
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], %[[LOOP_LATCH]] ]
; CHECK-NEXT:    br i1 [[C_1]], label %[[LOOP_LATCH]], label %[[THEN:.*]]
; CHECK:       [[THEN]]:
; CHECK-NEXT:    [[DIV:%.*]] = sdiv i16 [[X]], [[Y]]
; CHECK-NEXT:    br label %[[LOOP_LATCH]]
; CHECK:       [[LOOP_LATCH]]:
; CHECK-NEXT:    [[BLEND:%.*]] = phi i16 [ [[DIV]], %[[THEN]] ], [ 0, %[[LOOP_HEADER]] ]
; CHECK-NEXT:    [[SEL]] = select i1 [[C]], i32 [[B]], i32 0
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    [[EC:%.*]] = icmp eq i32 [[IV]], 100
; CHECK-NEXT:    br i1 [[EC]], label %[[EXIT]], label %[[LOOP_HEADER]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       [[EXIT]]:
; CHECK-NEXT:    [[BLEND_LCSSA:%.*]] = phi i16 [ [[BLEND]], %[[LOOP_LATCH]] ], [ [[TMP29]], %[[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    [[SEL_LCSSA:%.*]] = phi i32 [ [[SEL]], %[[LOOP_LATCH]] ], [ [[RDX_SELECT]], %[[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    store i16 [[BLEND_LCSSA]], ptr [[P]], align 2
; CHECK-NEXT:    ret i32 [[SEL_LCSSA]]
;
entry:
  %c = icmp eq i32 %a, 0
  br label %loop.header

loop.header:
  %b = phi i32 [ 0, %entry ], [ %sel, %loop.latch ]
  %iv = phi i32 [ 1, %entry ], [ %iv.next, %loop.latch ]
  br i1 %c.1, label %loop.latch, label %then

then:
  %div = sdiv i16 %x, %y
  br label %loop.latch

loop.latch:
  %blend = phi i16 [ %div, %then ], [ 0, %loop.header ]
  %sel = select i1 %c, i32 %b, i32 0
  %iv.next = add i32 %iv, 1
  %ec = icmp eq i32 %iv, 100
  br i1 %ec, label %exit, label %loop.header

exit:
  store i16 %blend, ptr %p, align 2
  ret i32 %sel
}
;.
; CHECK: [[LOOP0]] = distinct !{[[LOOP0]], [[META1:![0-9]+]], [[META2:![0-9]+]]}
; CHECK: [[META1]] = !{!"llvm.loop.isvectorized", i32 1}
; CHECK: [[META2]] = !{!"llvm.loop.unroll.runtime.disable"}
; CHECK: [[LOOP3]] = distinct !{[[LOOP3]], [[META2]], [[META1]]}
;.