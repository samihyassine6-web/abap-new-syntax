*&---------------------------------------------------------------------*
*& Report ZPRG_STRING_EXPRESSION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_string_expression.

* String Expression as a Replacement of CONCATENATE.
*--------------------------------------------------------------------*

* CONCATENATE STATEMENT
*--------------------------------------------------------------------*

*DATA: lv_output(20) TYPE c.
*
*CONCATENATE 'Welcome' 'To' 'Home' INTO lv_output SEPARATED BY space.
*
*WRITE: lv_output.

*DATA: lv_input1(10) TYPE c VALUE 'Welcome'.
*DATA: lv_input2(10) TYPE c VALUE 'To'.
*DATA: lv_input3(10) TYPE c VALUE 'Home'.
*DATA: lv_output(20) TYPE c.

*CONCATENATE lv_input1 lv_input2 lv_input3 INTO lv_output SEPARATED BY space.
*WRITE: lv_output.


* String Expression
*--------------------------------------------------------------------*

*data(lv_output) = |Wllome To Home|.  " No Need to use SEPARATED BY
*
*WRITE: lv_output.

DATA(lv_input1) = 'Welcome'.
DATA(lv_input2) = 'To'.
DATA(lv_input3) = 'Home'.

DATA(lv_output) = | { lv_input1 } { lv_input2 } { lv_input3 } |.

WRITE: lv_output.
