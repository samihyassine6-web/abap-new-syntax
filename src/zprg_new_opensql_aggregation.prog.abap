*&---------------------------------------------------------------------*
*& Report ZPRG_NEW_OPENSQL_AGGREGATION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_new_opensql_aggregation.

DATA: lv_odate TYPE zdeodate_28.

*TYPES: BEGIN OF lty_data,
*         odate TYPE zdeodate_28,
*         ta    TYPE zdeta_28,
*       END OF lty_data.
*
*DATA: lt_data TYPE TABLE OF lty_data.
*DATA: lt_temp_data TYPE TABLE OF lty_data.
*DATA: lwa_data TYPE lty_data.


SELECT-OPTIONS: s_odate FOR lv_odate.
PARAMETERS: p_ta TYPE zdeta_28.

*SELECT odate ta
*  FROM zordh_28
*  INTO TABLE lt_data
*  WHERE odate IN s_odate.
*
*LOOP AT lt_data INTO lwa_data.
*  COLLECT lwa_data INTO lt_temp_data. " To make Sum of TA
*  CLEAR: lwa_data.
*ENDLOOP.
*
*LOOP AT lt_temp_data INTO lwa_data.
*  WRITE: / lwa_data-odate, lwa_data-ta.
*ENDLOOP.

*--------------------------------------------------------------------*
*        NEW SYNTAX CODE PUSH DOWN
*--------------------------------------------------------------------*

*SELECT odate, pm, SUM( ta ) AS amount    " Alias is obligatory
*  FROM zordh_28
*  INTO TABLE @DATA(lt_data)
*  WHERE odate IN @s_odate
*  GROUP BY odate, pm.

SELECT odate, SUM( ta ) AS amount    " Alias is obligatory " SUM; COUNT; MAX; AVG
  FROM zordh_28
  INTO TABLE @DATA(lt_data)
  WHERE odate IN @s_odate
  GROUP BY odate HAVING SUM( ta ) > @p_ta.  " Filter Condition

SORT lt_data BY odate .

LOOP AT lt_data INTO DATA(lwa_data).
  WRITE: / lwa_data-odate, lwa_data-amount.
ENDLOOP.
