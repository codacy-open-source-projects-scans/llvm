@ Check a single .fpu directive.

@ RUN: llvm-mc -triple arm-eabi -filetype obj %s \
@ RUN:   | llvm-readobj --arch-specific - \
@ RUN:   | FileCheck %s -check-prefix CHECK-ATTR

  .fpu vfp

@ CHECK-ATTR: FileAttributes {
@ CHECK-ATTR:   Attribute {
@ CHECK-ATTR:     TagName: FP_arch
@ CHECK-ATTR:     Description: VFPv2
@ CHECK-ATTR:   }
@ CHECK-ATTR: }
