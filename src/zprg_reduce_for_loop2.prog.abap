*&---------------------------------------------------------------------*
*& Report ZPRG_REDUCE_FOR_LOOP2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_reduce_for_loop2.

TYPES: BEGIN OF lty_ordh,
         pm TYPE zdepm_28,
         ta TYPE zdeta_28,
       END OF lty_ordh.

DATA: lt_ordh TYPE TABLE OF lty_ordh.
*DATA: lwa_ordh TYPE lty_ordh.
DATA: lv_date TYPE zdeodate_28.
DATA: lv_ta1 TYPE zdeta_28.
DATA: lv_ta2 TYPE zdeta_28.
DATA: lv_ta3 TYPE zdeta_28.

SELECTION-SCREEN BEGIN OF BLOCK blc WITH FRAME TITLE TEXT-000.
SELECT-OPTIONS: s_date FOR lv_date.
SELECTION-SCREEN END OF BLOCK blc.


SELECT pm ta
  FROM zordh_28
  INTO TABLE lt_ordh
  WHERE odate IN s_date.

*LOOP AT lt_ordh INTO lwa_ordh.
*  IF lwa_ordh-pm = 'C'.
*    lv_ta1 = lv_ta1 + lwa_ordh-ta.
*  ENDIF.
*
*  IF lwa_ordh-pm = 'D'.
*    lv_ta2 = lv_ta2 + lwa_ordh-ta.
*  ENDIF.
*
*  IF lwa_ordh-pm = 'N'.
*    lv_ta3 = lv_ta3 + lwa_ordh-ta.
*  ENDIF.
*ENDLOOP.

*WRITE: / TEXT-001, lv_ta1.
*WRITE: / TEXT-002, lv_ta2.
*WRITE: / TEXT-003, lv_ta3.

lv_ta1 = REDUCE #( INIT sum = 0 FOR lwa_ordh IN lt_ordh WHERE ( pm = 'C' ) NEXT sum = sum + lwa_ordh-ta ).
WRITE:   TEXT-001, lv_ta1.
lv_ta2 = REDUCE #( INIT sum = 0 FOR lwa_ordh IN lt_ordh WHERE ( pm = 'D' ) NEXT sum = sum + lwa_ordh-ta ).
WRITE: / TEXT-002, lv_ta2.
lv_ta3 = REDUCE #( INIT sum = 0 FOR lwa_ordh IN lt_ordh WHERE ( pm = 'N' ) NEXT sum = sum + lwa_ordh-ta ).
WRITE: / TEXT-003 , lv_ta3.
