*&---------------------------------------------------------------------*
*& Report ZPRG_STRING_EXPRESSION_ORDH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_string_expression_ordh.

* String Expression as a Replacement of CONCATENATE.
*--------------------------------------------------------------------*

* CONCATENATE STATEMENT
*--------------------------------------------------------------------*

DATA: lv_ono TYPE zdeono_28.

TYPES: BEGIN OF lty_ordh,
         ono TYPE zdeono_28,
         ta  TYPE zdeta_28,
       END OF lty_ordh.

DATA: lt_ordh TYPE TABLE OF lty_ordh.
DATA: lwa_ordh TYPE lty_ordh.
*DATA: lv_output(50) TYPE c.
*DATA: lv_amount(20) TYPE c.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.
SELECT-OPTIONS: s_ono FOR lv_ono.
SELECTION-SCREEN END OF BLOCK b1.

SELECT ono ta
  FROM zordh_28
  INTO TABLE lt_ordh
  WHERE ono IN s_ono.

*LOOP AT lt_ordh INTO lwa_ordh.
*  lv_amount = lwa_ordh-ta.  " Type Casting
*  CONDENSE lv_amount.
*  CONCATENATE lwa_ordh-ono lv_amount INTO lv_output SEPARATED BY space.
*  WRITE: / lv_output.
*ENDLOOP.



* String Expression.
*--------------------------------------------------------------------*

LOOP AT lt_ordh INTO lwa_ordh.
  DATA(lv_output) = | { lwa_ordh-ono } { lwa_ordh-ta } |. " No Need for Type Casting and SEPARATED BY.
  WRITE: / lv_output.
ENDLOOP.
