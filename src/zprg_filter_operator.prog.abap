*&---------------------------------------------------------------------*
*& Report ZPRG_FILTER_OPERATOR
*&---------------------------------------------------------------------*
*&  Filter using single value
*&---------------------------------------------------------------------*
REPORT zprg_filter_operator.

DATA: lv_odate TYPE zdeodate_28.

SELECT-OPTIONS: s_odate FOR lv_odate.

TYPES: BEGIN OF lty_ordh,
         ono TYPE zdeono_28,
         pm  TYPE zdepm_28,
       END OF lty_ordh.

TYPES: BEGIN OF lty_filter,
         pm TYPE zdepm_28,
       END OF lty_filter.

DATA: lt_filter TYPE SORTED TABLE OF lty_filter WITH UNIQUE KEY pm. " Important Unique Values.

*DATA: lt_ordh TYPE TABLE OF lty_ordh.
DATA: lt_ordh TYPE SORTED TABLE OF lty_ordh WITH NON-UNIQUE KEY pm. " Important for using Filter Operator, Sorted or Hashesd.
DATA: lt_temp_ordh TYPE TABLE OF lty_ordh.
DATA: lwa_ordh TYPE lty_ordh.

SELECT ono pm
  FROM zordh_28
  INTO TABLE lt_ordh
  WHERE odate IN s_odate.


*LOOP AT lt_ordh INTO lwa_ordh.
*  IF lwa_ordh-pm = 'C'.
*    APPEND lwa_ordh TO lt_temp_ordh.
*    CLEAR lwa_ordh.
*  ENDIF.
*ENDLOOP.

*lt_temp_ordh = FILTER #( lt_ordh WHERE pm = 'C' ).         " will filter the records having payment mode 'C'.
*lt_temp_ordh = FILTER #( lt_ordh EXCEPT WHERE pm = 'C' ). " will Except payment mode 'C'.

lt_filter = VALUE #( ( pm = 'C') ( pm = 'N')  ).  " Insert data into lt_filter for filtering using multiple Values.

*lt_temp_ordh = FILTER #( lt_ordh IN lt_filter WHERE pm = pm ).
lt_temp_ordh = FILTER #( lt_ordh EXCEPT IN lt_filter WHERE pm = pm ).

LOOP AT lt_temp_ordh INTO lwa_ordh.
  WRITE: / lwa_ordh-ono, lwa_ordh-pm.
ENDLOOP.
