*&---------------------------------------------------------------------*
*& Report ZPRG_NEW_FEATURES_ELEMENT_LIST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_new_features_element_list.

DATA: lv_ono TYPE zdeono_28.

SELECT-OPTIONS: s_ono FOR lv_ono.


*SELECT ono, odate
*  FROM zordh_28
*  INTO TABLE @DATA(lt_ordh)
*  WHERE ono IN @s_ono.


SELECT FROM zordh_28
  FIELDS ono, odate
  WHERE ono IN @s_ono
  INTO TABLE @DATA(lt_ordh).
