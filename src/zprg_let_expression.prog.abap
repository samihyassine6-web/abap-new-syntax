*&---------------------------------------------------------------------*
*& Report ZPRG_LET_EXPRESSION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_let_expression.

TYPES: BEGIN OF lty_data,
         col1(2) TYPE n,
         col2(3) TYPE n,
       END OF lty_data.

DATA: lwa_data TYPE lty_data.
*DATA(x) = 10.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.
PARAMETERS: p_input TYPE numc2.
SELECTION-SCREEN END OF BLOCK b1.

DO p_input TIMES.
*  lwa_data = VALUE #( col1 = sy-index col2 = sy-index + x ).
  lwa_data = VALUE #( LET x = 10 IN  col1 = sy-index col2 = sy-index + x ).
  WRITE: / lwa_data-col1, lwa_data-col2.
ENDDO.
