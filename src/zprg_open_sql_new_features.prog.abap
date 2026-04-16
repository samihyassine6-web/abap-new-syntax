*&---------------------------------------------------------------------*
*& Report ZPRG_OPEN_SQL_NEW_FEATURES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_open_sql_new_features.

DATA: lv_ono TYPE zdeono_28.

SELECT-OPTIONS: s_ono FOR lv_ono.

*TYPES: BEGIN OF lty_ordh,
*         ono    TYPE zdeono_28,
*         odate  TYPE zdeodate_28,
*         creaby TYPE zdecrby_28,
*         ta     TYPE zdeta_28,
*       END OF lty_ordh.

*DATA: lt_ordh TYPE TABLE OF lty_ordh.
*DATA: lwa_ordh TYPE lty_ordh.

*SELECT ono odate creaby ta
*  FROM zordh_28
*  INTO TABLE lt_ordh
*  WHERE ono IN s_ono.

*LOOP AT lt_ordh INTO lwa_ordh.                                         " WHERE creaby = 'TERMINATOR'.
*  WRITE: / lwa_ordh-ono, lwa_ordh-odate, lwa_ordh-creaby, lwa_ordh-ta.
*ENDLOOP.

*--------------------------------------------------------------------*
*                NEW SYNTAX
*--------------------------------------------------------------------*

SELECT ono, odate, creaby, ta  " separated by comma
  FROM zordh_28
  INTO TABLE @DATA(lt_ordh)    " Inline Declaration of internal table
  WHERE ono IN @s_ono. " Host Variables prefixed with @, ono is Guest variable

LOOP AT lt_ordh INTO DATA(lwa_ordh).   " Inline Declaration of work area
  WRITE: / lwa_ordh-ono, lwa_ordh-odate, lwa_ordh-creaby, lwa_ordh-ta.
ENDLOOP.
