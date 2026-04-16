*&---------------------------------------------------------------------*
*& Report ZPRG_INLINE_DECLARATION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_inline_declaration.

* Explicit data Declaration
*------------------------------*

*DATA: lv_input1(2) TYPE n.
*DATA: lv_input2(2) TYPE n.
*DATA: lv_output(3) TYPE n.
*
*lv_input1 = 10.
*lv_input2 = 30.
*lv_output = lv_input1 + lv_input2.

* Inline Declaration
*---------------------------*

DATA(lv_input1) = 10.
DATA(lv_input2) = 30.
DATA(lv_output) = lv_input1 + lv_input2.





WRITE: lv_output.
