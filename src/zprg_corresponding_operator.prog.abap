*&---------------------------------------------------------------------*
*& Report ZPRG_CORRESPONDING_OPERATOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_corresponding_operator.

DATA: lv_ono TYPE zdeono_28.

TYPES: BEGIN OF lty_ordh,
         ono   TYPE zdeono_28,
         odate TYPE zdeodate_28,
         dno   TYPE zdedn_28,
         ddate TYPE zdeddate_28,
         ta    TYPE zdeta_28,
         curr  TYPE zdecurr_28,
       END OF lty_ordh.

DATA: lt_ordh TYPE TABLE OF lty_ordh.
DATA: lt_ordh2 TYPE TABLE OF lty_ordh.
DATA: lwa_ordh TYPE lty_ordh.

TYPES: BEGIN OF lty_ordh1,
         ono    TYPE zdeono_28,
         odate  TYPE zdeodate_28,
         amount TYPE zdeta_28,
         curr   TYPE zdecurr_28,
       END OF lty_ordh1.

*DATA: lt_ordh1 TYPE TABLE OF lty_ordh1.
DATA: lwa_ordh1 TYPE lty_ordh1.

TYPES: ltty_ordh1 TYPE TABLE OF lty_ordh1 WITH EMPTY KEY.

SELECTION-SCREEN BEGIN OF BLOCK blc WITH FRAME TITLE TEXT-000.
SELECT-OPTIONS: s_ono FOR lv_ono.
SELECTION-SCREEN END OF BLOCK blc.

SELECT ono odate dno ddate ta curr
  FROM zordh_28
  INTO TABLE lt_ordh
  WHERE ono IN s_ono.

*lt_ordh2 = lt_ordh.  "Same Structure
*  APPEND LINES OF lt_ordh to lt_ordh2.

*lt_ordh1 = lt_ordh.  " Different Structure

*LOOP AT lt_ordh INTO lwa_ordh.
*  lwa_ordh1-ono = lwa_ordh-ono.
*  lwa_ordh1-odate = lwa_ordh-odate.
*  lwa_ordh1-amount = lwa_ordh-ta.
*  lwa_ordh1-curr = lwa_ordh-curr.
*  APPEND lwa_ordh1 TO lt_ordh1.
*ENDLOOP.

* Corresponding Operator to move data from one internal table to an other
*-------------------------------------------------------------------------*

*lt_ordh1 = CORRESPONDING #( lt_ordh MAPPING amount = ta EXCEPT odate ).

DATA(lt_ordh1) = CORRESPONDING ltty_ordh1( lt_ordh MAPPING amount = ta EXCEPT odate ).

LOOP AT lt_ordh1 INTO lwa_ordh1.
  WRITE: / lwa_ordh1-ono,lwa_ordh1-odate, lwa_ordh1-amount, lwa_ordh1-curr.
ENDLOOP.
