*&---------------------------------------------------------------------*
*& Report ZPRG_NEX_SYNTAX_JOIN_IMPROVE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_nex_syntax_join_improve.

DATA: lv_ono TYPE zdeono_28.

*TYPES: BEGIN OF lty_data,
*         ono    TYPE zdeono_28,
*         odate  TYPE zdeodate_28,
*         creaby TYPE zdecrby_28,
*         oin    TYPE zdeoin_28,
*         itemid TYPE zdeitemid_28,
*         odesc  TYPE zdeodesc_28,
*         meng   TYPE zdemeng_28,
*         icost  TYPE zdeicost_28,
*       END OF lty_data.
*
*DATA: lt_final TYPE TABLE OF lty_data.
**DATA: lwa_data TYPE lty_data.



SELECT-OPTIONS: s_ono FOR lv_ono.

SELECT a~ono, a~odate, a~creaby, b~*                                           " oin b~itemid b~odesc b~meng b~icost
  FROM zordh_28 AS a JOIN zordi_28 AS b
  ON a~ono = b~ono
  INTO TABLE @DATA(lt_data)
  WHERE a~ono IN @s_ono.



*LOOP AT lt_data INTO DATA(lwa_data).
*  lt_final = VALUE #( BASE lt_final ( ono = lwa_data-ono odate = lwa_data-odate creaby = lwa_data-creaby
*                                    oin = lwa_data-b-oin itemid = lwa_data-b-itemid odesc = lwa_data-b-odesc
*                                    meng = lwa_data-b-meng icost = lwa_data-b-icost )
*                                  ).
*ENDLOOP.
*
*WRITE 1.

LOOP AT lt_data INTO DATA(lwa_data).
  WRITE: / lwa_data-ono, lwa_data-odate, lwa_data-creaby, lwa_data-b-oin,
           lwa_data-b-itemid, lwa_data-b-odesc, lwa_data-b-meng, lwa_data-b-icost.
ENDLOOP.
