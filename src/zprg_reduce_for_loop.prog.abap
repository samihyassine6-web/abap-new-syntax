*&---------------------------------------------------------------------*
*& Report ZPRG_REDUCE_FOR_LOOP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_reduce_for_loop.

*DATA(value1) = REDUCE i( INIT sum = 0 FOR int = 1 THEN int + 1 UNTIL int > 5 NEXT sum = sum + int ).
*
*WRITE: value1.

TYPES: BEGIN OF lty_ordh,
         ono  TYPE zdeono_28,
         pm   TYPE zdepm_28,
         ta   TYPE zdeta_28,
         curr TYPE zdecurr_28,
       END OF lty_ordh.

DATA: lt_ordh TYPE TABLE OF lty_ordh.
*DATA: lwa_ordh TYPE lty_ordh.
DATA: lv_date TYPE zdeodate_28.
DATA: lv_count1 TYPE i.
DATA: lv_count2 TYPE i.
DATA: lv_count3 TYPE i.

SELECTION-SCREEN BEGIN OF BLOCK blc WITH FRAME TITLE TEXT-000.
SELECT-OPTIONS: s_date FOR lv_date.
SELECTION-SCREEN END OF BLOCK blc.

SELECT ono pm ta curr
  FROM zordh_28
  INTO TABLE lt_ordh
  WHERE odate IN s_date.

*LOOP AT lt_ordh INTO lwa_ordh.
*  IF lwa_ordh-pm = 'C'.
*    lv_count1 = lv_count1 + 1.
*  ENDIF.
*
*  IF lwa_ordh-pm = 'D'.
*    lv_count2 = lv_count2 + 1.
*  ENDIF.
*
*  IF lwa_ordh-pm = 'N'.
*    lv_count3 = lv_count3 + 1.
*  ENDIF.
*
*ENDLOOP.

*data(lv_count1) = REDUCE i( INIT count = 0 FOR lwa_ordh IN lt_ordh WHERE ( pm = 'C' ) NEXT count = count + 1 ). " Inline Declaration and implizit converting

lv_count1 = REDUCE #( INIT count = 0 FOR lwa_ordh IN lt_ordh WHERE ( pm = 'C' ) NEXT count = count + 1 ).
WRITE: TEXT-001, lv_count1.
lv_count2 = REDUCE #( INIT count = 0 FOR lwa_ordh IN lt_ordh WHERE ( pm = 'D' ) NEXT count = count + 1 ).
WRITE: / TEXT-002, lv_count2.
lv_count3 = REDUCE #( INIT count = 0 FOR lwa_ordh IN lt_ordh WHERE ( pm = 'N' ) NEXT count = count + 1 ).
WRITE: / TEXT-003 , lv_count3.
