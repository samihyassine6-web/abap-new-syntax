*&---------------------------------------------------------------------*
*& Report ZPRG_NEW_OPENSQL_LITERALS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_new_opensql_literals.

*TYPES: BEGIN OF lty_ordh,
*         ono    TYPE zdeono_28,
*         odate  TYPE zdeodate_28,
*         creaby TYPE zdecrby_28,
*         pm     TYPE zdepm_28,
*         ta     TYPE zdeta_28,
*         curr   TYPE zdecurr_28,
*       END OF lty_ordh.
*
*DATA: lt_ordh TYPE TABLE OF lty_ordh.
*DATA: lwa_ordh TYPE lty_ordh.
*
*TYPES: BEGIN OF lty_user,
*         uname TYPE uname,
*       END OF lty_user.
*
*DATA: lt_user TYPE TABLE OF lty_user.
*DATA: lwa_user TYPE lty_user.
*
DATA: lv_ono TYPE zdeono_28.

SELECT-OPTIONS: s_ono FOR lv_ono.
*
*AT SELECTION-SCREEN.
*
*  SELECT uname
*    FROM zusers
*    INTO TABLE lt_user
*    WHERE uname = sy-uname.
*
*  IF sy-subrc NE 0.
*    MESSAGE e014(zmessage).
*  ENDIF.
*
*START-OF-SELECTION.
*
*  SELECT ono odate creaby pm ta curr
*    FROM zordh_28
*    INTO TABLE lt_ordh
*    WHERE ono IN s_ono.
*
*  LOOP AT lt_ordh INTO lwa_ordh.
*    WRITE: / lwa_ordh-ono, lwa_ordh-odate, lwa_ordh-creaby, lwa_ordh-pm, lwa_ordh-ta, lwa_ordh-curr.
*  ENDLOOP.

*--------------------------------------------------------------------*
*            NEW SYNTAX LITERALS TO CHECK IF ENTRIES EXISTS
*--------------------------------------------------------------------*
AT SELECTION-SCREEN.

  SELECT SINGLE 'X'
    FROM zusers
    INTO @DATA(lv_exists)
    WHERE uname = @sy-uname.

  IF sy-subrc NE 0.
    MESSAGE e014(zmessage).
  ENDIF.

START-OF-SELECTION.

  SELECT ono, odate, creaby, pm, ta, curr
   FROM zordh_28
   INTO TABLE @DATA(lt_ordh)
   WHERE ono IN @s_ono.

  LOOP AT lt_ordh INTO DATA(lwa_ordh).
    WRITE: / lwa_ordh-ono, lwa_ordh-odate, lwa_ordh-creaby, lwa_ordh-pm, lwa_ordh-ta, lwa_ordh-curr.
  ENDLOOP.
