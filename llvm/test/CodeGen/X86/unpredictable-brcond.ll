; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py UTC_ARGS: --version 5
; Make sure MIR generated for conditional branch with unpredictable metadata has unpredictable flag.
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -stop-after=finalize-isel < %s | FileCheck %s

define void @cond_branch_1(i1 %cond) {
  ; CHECK-LABEL: name: cond_branch_1
  ; CHECK: bb.0.entry:
  ; CHECK-NEXT:   successors: %bb.1(0x40000000), %bb.2(0x40000000)
  ; CHECK-NEXT:   liveins: $edi
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:gr32 = COPY $edi
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:gr8 = COPY [[COPY]].sub_8bit
  ; CHECK-NEXT:   TEST8ri killed [[COPY1]], 1, implicit-def $eflags
  ; CHECK-NEXT:   unpredictable JCC_1 %bb.2, 4, implicit $eflags
  ; CHECK-NEXT:   JMP_1 %bb.1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.1.then:
  ; CHECK-NEXT:   ADJCALLSTACKDOWN64 0, 0, 0, implicit-def dead $rsp, implicit-def dead $eflags, implicit-def dead $ssp, implicit $rsp, implicit $ssp
  ; CHECK-NEXT:   CALL64pcrel32 target-flags(x86-plt) @f1, csr_64, implicit $rsp, implicit $ssp, implicit-def $rsp, implicit-def $ssp
  ; CHECK-NEXT:   ADJCALLSTACKUP64 0, 0, implicit-def dead $rsp, implicit-def dead $eflags, implicit-def dead $ssp, implicit $rsp, implicit $ssp
  ; CHECK-NEXT:   RET 0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2.else:
  ; CHECK-NEXT:   ADJCALLSTACKDOWN64 0, 0, 0, implicit-def dead $rsp, implicit-def dead $eflags, implicit-def dead $ssp, implicit $rsp, implicit $ssp
  ; CHECK-NEXT:   CALL64pcrel32 target-flags(x86-plt) @f2, csr_64, implicit $rsp, implicit $ssp, implicit-def $rsp, implicit-def $ssp
  ; CHECK-NEXT:   ADJCALLSTACKUP64 0, 0, implicit-def dead $rsp, implicit-def dead $eflags, implicit-def dead $ssp, implicit $rsp, implicit $ssp
  ; CHECK-NEXT:   RET 0
entry:
  br i1 %cond, label %then, label %else, !unpredictable !0
then:
  call void @f1()
  ret void
else:
  call void @f2()
  ret void
}

define void @cond_branch_2(double %a, double %b, i32 %c, i32 %d) nounwind {
  ; CHECK-LABEL: name: cond_branch_2
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   successors: %bb.1(0x40000000), %bb.2(0x40000000)
  ; CHECK-NEXT:   liveins: $xmm0, $xmm1, $edi, $esi
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:gr32 = COPY $esi
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:gr32 = COPY $edi
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:fr64 = COPY $xmm1
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:fr64 = COPY $xmm0
  ; CHECK-NEXT:   nofpexcept UCOMISDrr [[COPY2]], [[COPY3]], implicit-def $eflags, implicit $mxcsr
  ; CHECK-NEXT:   [[SETCCr:%[0-9]+]]:gr8 = SETCCr 3, implicit $eflags
  ; CHECK-NEXT:   [[SUB32rr:%[0-9]+]]:gr32 = SUB32rr [[COPY1]], [[COPY]], implicit-def $eflags
  ; CHECK-NEXT:   [[SETCCr1:%[0-9]+]]:gr8 = SETCCr 6, implicit $eflags
  ; CHECK-NEXT:   [[OR8rr:%[0-9]+]]:gr8 = OR8rr [[SETCCr]], killed [[SETCCr1]], implicit-def dead $eflags
  ; CHECK-NEXT:   TEST8rr [[OR8rr]], [[OR8rr]], implicit-def $eflags
  ; CHECK-NEXT:   unpredictable JCC_1 %bb.2, 5, implicit $eflags
  ; CHECK-NEXT:   JMP_1 %bb.1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.1.true:
  ; CHECK-NEXT:   ADJCALLSTACKDOWN64 0, 0, 0, implicit-def dead $rsp, implicit-def dead $eflags, implicit-def dead $ssp, implicit $rsp, implicit $ssp
  ; CHECK-NEXT:   CALL64pcrel32 target-flags(x86-plt) @f1, csr_64, implicit $rsp, implicit $ssp, implicit-def $rsp, implicit-def $ssp
  ; CHECK-NEXT:   ADJCALLSTACKUP64 0, 0, implicit-def dead $rsp, implicit-def dead $eflags, implicit-def dead $ssp, implicit $rsp, implicit $ssp
  ; CHECK-NEXT:   RET 0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2.false:
  ; CHECK-NEXT:   ADJCALLSTACKDOWN64 0, 0, 0, implicit-def dead $rsp, implicit-def dead $eflags, implicit-def dead $ssp, implicit $rsp, implicit $ssp
  ; CHECK-NEXT:   CALL64pcrel32 target-flags(x86-plt) @f2, csr_64, implicit $rsp, implicit $ssp, implicit-def $rsp, implicit-def $ssp
  ; CHECK-NEXT:   ADJCALLSTACKUP64 0, 0, implicit-def dead $rsp, implicit-def dead $eflags, implicit-def dead $ssp, implicit $rsp, implicit $ssp
  ; CHECK-NEXT:   RET 0
  %cond1 = fcmp ugt double %a, %b
  %cond2 = icmp ugt i32 %c, %d
  %cond = and i1 %cond1, %cond2
  br i1 %cond, label %true, label %false, !unpredictable !0
true:
  call void @f1()
  ret void
false:
  call void @f2()
  ret void
}

define void @isint_branch(double %d) nounwind {
  ; CHECK-LABEL: name: isint_branch
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   successors: %bb.1(0x50000000), %bb.2(0x30000000)
  ; CHECK-NEXT:   liveins: $xmm0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:fr64 = COPY $xmm0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:vr128 = COPY [[COPY]]
  ; CHECK-NEXT:   [[CVTTPD2DQrr:%[0-9]+]]:vr128 = nofpexcept CVTTPD2DQrr killed [[COPY1]], implicit $mxcsr
  ; CHECK-NEXT:   [[CVTDQ2PDrr:%[0-9]+]]:vr128 = CVTDQ2PDrr killed [[CVTTPD2DQrr]]
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:fr64 = COPY [[CVTDQ2PDrr]]
  ; CHECK-NEXT:   nofpexcept UCOMISDrr [[COPY]], killed [[COPY2]], implicit-def $eflags, implicit $mxcsr
  ; CHECK-NEXT:   unpredictable JCC_1 %bb.2, 5, implicit $eflags
  ; CHECK-NEXT:   unpredictable JCC_1 %bb.2, 10, implicit $eflags
  ; CHECK-NEXT:   JMP_1 %bb.1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.1.true:
  ; CHECK-NEXT:   ADJCALLSTACKDOWN64 0, 0, 0, implicit-def dead $rsp, implicit-def dead $eflags, implicit-def dead $ssp, implicit $rsp, implicit $ssp
  ; CHECK-NEXT:   CALL64pcrel32 target-flags(x86-plt) @f1, csr_64, implicit $rsp, implicit $ssp, implicit-def $rsp, implicit-def $ssp
  ; CHECK-NEXT:   ADJCALLSTACKUP64 0, 0, implicit-def dead $rsp, implicit-def dead $eflags, implicit-def dead $ssp, implicit $rsp, implicit $ssp
  ; CHECK-NEXT:   RET 0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2.false:
  ; CHECK-NEXT:   ADJCALLSTACKDOWN64 0, 0, 0, implicit-def dead $rsp, implicit-def dead $eflags, implicit-def dead $ssp, implicit $rsp, implicit $ssp
  ; CHECK-NEXT:   CALL64pcrel32 target-flags(x86-plt) @f2, csr_64, implicit $rsp, implicit $ssp, implicit-def $rsp, implicit-def $ssp
  ; CHECK-NEXT:   ADJCALLSTACKUP64 0, 0, implicit-def dead $rsp, implicit-def dead $eflags, implicit-def dead $ssp, implicit $rsp, implicit $ssp
  ; CHECK-NEXT:   RET 0
  %i = fptosi double %d to i32
  %e = sitofp i32 %i to double
  %c = fcmp oeq double %d, %e
  br i1 %c, label %true, label %false, !unpredictable !0
true:
  call void @f1()
  ret void
false:
  call void @f2()
  ret void
}

declare void @f1()
declare void @f2()

!0 = !{}