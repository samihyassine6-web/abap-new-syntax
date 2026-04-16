*&---------------------------------------------------------------------*
*& Report ZPRG_NEW_KEYWORD_FOR_CR_OBJECT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_new_keyword_for_cr_object.

DATA: lo_object TYPE REF TO zclass_sum.
DATA: lv_output TYPE numc3.

PARAMETERS: p_input1 TYPE numc2.
PARAMETERS: p_input2 TYPE numc2.

*CREATE OBJECT lo_object
*EXPORTING
*  pvalue = 'X'.

lo_object = NEW zclass_sum( pvalue = 'X' ). " New Syntax to create a Object

CALL METHOD lo_object->sum
  EXPORTING
    pinput1 = p_input1
    pinput2 = p_input2
  IMPORTING
    poutput = lv_output.

WRITE: / lv_output.
