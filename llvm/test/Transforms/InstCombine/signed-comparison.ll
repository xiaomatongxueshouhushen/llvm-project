; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

; Convert the zext+slt into a simple ult.

define i1 @scalar_zext_slt(i16 %t4) {
; CHECK-LABEL: @scalar_zext_slt(
; CHECK-NEXT:    [[T6:%.*]] = icmp ult i16 %t4, 500
; CHECK-NEXT:    ret i1 [[T6]]
;
  %t5 = zext i16 %t4 to i32
  %t6 = icmp slt i32 %t5, 500
  ret i1 %t6
}

; FIXME: Vector compare should work the same as scalar.

define <4 x i1> @vector_zext_slt(<4 x i16> %t4) {
; CHECK-LABEL: @vector_zext_slt(
; CHECK-NEXT:    [[T5:%.*]] = zext <4 x i16> %t4 to <4 x i32>
; CHECK-NEXT:    [[T6:%.*]] = icmp ult <4 x i32> [[T5]], <i32 500, i32 0, i32 501, i32 65535>
; CHECK-NEXT:    ret <4 x i1> [[T6]]
;
  %t5 = zext <4 x i16> %t4 to <4 x i32>
  %t6 = icmp slt <4 x i32> %t5, <i32 500, i32 0, i32 501, i32 65535>
  ret <4 x i1> %t6
}

