*&---------------------------------------------------------------------*
*& Report ZPRG_COND_FOR_IF
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_cond_for_if.

DATA: lv_ono TYPE zdeono_28.
DATA: lv_text TYPE char20.

TYPES: BEGIN OF lty_ordh,
         ono TYPE zdeono_28,
         ta  TYPE zdeta_28,
       END OF lty_ordh.

DATA: lt_ordh TYPE TABLE OF lty_ordh.
DATA: lwa_ordh TYPE lty_ordh.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.
SELECT-OPTIONS: s_ono FOR lv_ono.
SELECTION-SCREEN END OF BLOCK b1.

SELECT ono ta
  FROM zordh_28
  INTO TABLE lt_ordh
  WHERE ono IN s_ono.

* If Statement
*----------------------------------------------------*

*LOOP AT lt_ordh INTO lwa_ordh.
*  IF lwa_ordh-ta GE 0 AND lwa_ordh-ta LE 5000.
*    lv_text = TEXT-001.
*  ELSEIF lwa_ordh-ta > 5000 AND lwa_ordh-ta LE 10000.
*    lv_text = TEXT-002.
*  ELSE.
*    lv_text = TEXT-003.
*  ENDIF.
*   WRITE: / lwa_ordh-ono, lv_text.
*ENDLOOP.

* COND Statement.
*----------------------------------------------------*

*LOOP AT lt_ordh INTO lwa_ordh.
*  DATA(lv_text) = COND char20( WHEN lwa_ordh-ta GE 0 AND lwa_ordh-ta LE 5000 THEN TEXT-001
*                               WHEN lwa_ordh-ta > 5000 AND lwa_ordh-ta LE 10000 THEN TEXT-002
*                               ELSE TEXT-003 ).
*  WRITE: / lwa_ordh-ono, lv_text.
*ENDLOOP.



LOOP AT lt_ordh INTO lwa_ordh.
  lv_text = COND #( WHEN lwa_ordh-ta GE 0 AND lwa_ordh-ta LE 5000 THEN TEXT-001
                    WHEN lwa_ordh-ta > 5000 AND lwa_ordh-ta LE 10000 THEN TEXT-002
                    ELSE TEXT-003 ).
  WRITE: / lwa_ordh-ono, lv_text.
ENDLOOP.
