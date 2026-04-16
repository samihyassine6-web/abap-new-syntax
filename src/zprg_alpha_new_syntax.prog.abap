*&---------------------------------------------------------------------*
*& Report ZPRG_ALPHA_NEW_SYNTAX
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_alpha_new_syntax.

DATA: lv_input1(10) TYPE c.
DATA: lv_input2(10) TYPE c.

lv_input1 = '12345'.
lv_input2 = '0000012345'.

* Adding the leading Zeros

*CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
*  EXPORTING
*    input  = lv_input1
*  IMPORTING
*    output = lv_input1.
*
*WRITE: lv_input1.
*
** To remove the leading Zeros
*
*CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
*  EXPORTING
*    input  = lv_input2
*  IMPORTING
*    output = lv_input2.
*
*WRITE: / lv_input2.

* New Syntax
*--------------------------------------------------------------------*

lv_input1 = |{ lv_input1 ALPHA = IN }|.

WRITE: lv_input1.

lv_input2 = |{ lv_input2 ALPHA = OUT }|.

WRITE: / lv_input2.
