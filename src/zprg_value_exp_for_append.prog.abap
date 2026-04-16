*&---------------------------------------------------------------------*
*& Report ZPRG_VALUE_EXP_FOR_APPEND
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_value_exp_for_append.

* Value Expression as Replacement of APPEND Statement.
*--------------------------------------------------------------------*

*TYPES: BEGIN OF lty_data,
*         eid(10)   TYPE n,
*         ename(40) TYPE c,
*       END OF lty_data.

*DATA: lt_data TYPE TABLE OF lty_data.
*DATA: lwa_data TYPE lty_data.

*lwa_data-eid = 1.
*lwa_data-ename = 'Mustermann'.
*APPEND lwa_data TO lt_data.
*CLEAR lwa_data.
*
*lwa_data-eid = 2.
*lwa_data-ename = 'Musterfrau'.
*APPEND lwa_data TO lt_data.
*CLEAR lwa_data.
*
*lwa_data-eid = 3.
*lwa_data-ename = 'Müller'.
*APPEND lwa_data TO lt_data.
*CLEAR lwa_data.

*LOOP AT lt_data INTO lwa_data.
*  WRITE: / lwa_data-eid, lwa_data-ename.
*ENDLOOP.

* Value Expression
*--------------------------------------------------------------------*

*TYPES: BEGIN OF lty_data,
*         eid(10)   TYPE n,
*         ename(40) TYPE c,
*       END OF lty_data.
*
*TYPES: ltty_data TYPE TABLE OF lty_data WITH EMPTY KEY.
*
*DATA(lwa_data) = VALUE lty_data(  eid = 1 ename = 'Mustermann' ).
*
*DATA(lt_data) = VALUE ltty_data( ( eid = 1 ename = 'Mustermann' ) ( eid = 2 ename = 'Musterfrau' )  ( eid = 3 ename = 'Müller' )  ).
*
*LOOP AT lt_data INTO DATA(lwa_data1).
*  WRITE: / lwa_data1-eid, lwa_data1-ename.
*ENDLOOP.

* Value Expression using ( # )
*--------------------------------------------------------------------*

TYPES: BEGIN OF lty_data,
         eid(10)   TYPE n,
         ename(40) TYPE c,
       END OF lty_data.

DATA: lt_data TYPE TABLE OF lty_data.


lt_data = VALUE #( ( eid = 1 ename = 'Mustermann' ) ( eid = 2 ename = 'Musterfrau' )  ( eid = 3 ename = 'Müller' )  ).

lt_data = VALUE #( BASE lt_data ( eid = 4 ename = 'Manfred' ) ). " will not overwrite the previous Records

*lt_data = VALUE #( ( eid = 4 ename = 'Manfred' ) ). " It will overwrite the pervious Records

LOOP AT lt_data INTO DATA(lwa_data).
  WRITE: / lwa_data-eid, lwa_data-ename.
ENDLOOP.
