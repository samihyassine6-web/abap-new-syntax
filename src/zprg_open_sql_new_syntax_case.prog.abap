*&---------------------------------------------------------------------*
*& Report ZPRG_OPEN_SQL_NEW_SYNTAX_CASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_open_sql_new_syntax_case.

DATA: lv_ono TYPE zdeono_28.

SELECT-OPTIONS: s_ono FOR lv_ono.

*TYPES: BEGIN OF lty_ordh,
*         ono    TYPE zdeono_28,
*         odate  TYPE zdeodate_28,
*         creaby TYPE zdecrby_28,
*         pm     TYPE zdepm_28,
*         ta     TYPE zdeta_28,
*       END OF lty_ordh.
*
*TYPES: BEGIN OF lty_ordh1,
*         ono         TYPE zdeono_28,
*         odate       TYPE zdeodate_28,
*         creaby      TYPE zdecrby_28,
*         description TYPE char40,
*         ta          TYPE zdeta_28,
*       END OF lty_ordh1.
*
*DATA: lt_ordh TYPE TABLE OF lty_ordh.
*DATA: lwa_ordh TYPE lty_ordh.
*DATA: lt_ordh1 TYPE TABLE OF lty_ordh1.
*DATA: lwa_ordh1 TYPE lty_ordh1.
*
*SELECT ono odate creaby pm ta
*  FROM zordh_28
*  INTO TABLE lt_ordh
*  WHERE ono IN s_ono.
*
*LOOP AT lt_ordh INTO lwa_ordh.
*  MOVE-CORRESPONDING lwa_ordh TO lwa_ordh1.
*  IF lwa_ordh-pm = 'C'.
*    lwa_ordh1-description = 'Payment with Credit Card'.
*  ELSEIF
*    lwa_ordh-pm = 'D'.
*    lwa_ordh1-description = 'Payment with Debit Card'.
*  ELSE.
*    lwa_ordh1-description = 'Payment with Net Banking'.
*  ENDIF.
*  APPEND lwa_ordh1 TO lt_ordh1.
*  CLEAR lwa_ordh1.
*ENDLOOP.
*
*cl_demo_output=>display(
*  EXPORTING
*    data =    lt_ordh1              " Text  oder Daten
*    name =    'DATA'
*).

*--------------------------------------------------------------------*
*              New SYNTAX
*--------------------------------------------------------------------*

SELECT ono, odate, creaby, pm, ta,
 CASE pm
  WHEN 'C' THEN 'Payment with Credit Card'
  WHEN 'D' THEN 'Payment with Debit Card'
  ELSE 'Payment with Net Banking'
  END AS description " Alias
  FROM zordh_28
  INTO TABLE @DATA(lt_ordh)
  WHERE ono IN @s_ono.

LOOP AT  lt_ordh INTO DATA(lwa_ordh).
  WRITE: / lwa_ordh-ono, lwa_ordh-odate, lwa_ordh-creaby, lwa_ordh-description, lwa_ordh-ta.
ENDLOOP.
