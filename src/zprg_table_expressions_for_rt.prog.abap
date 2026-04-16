*&---------------------------------------------------------------------*
*& Report ZPRG_TABLE_EXPRESSIONS_FOR_RT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_table_expressions_for_rt.

*--------------------------------------------------------------------*
*   NEW SYNTAX TABLE EXPRESSIONS US REPLACEMENT OF READ TABLE
*--------------------------------------------------------------------*


DATA: lv_ono TYPE zdeono_28.
DATA: lo_object TYPE REF TO cx_root.
DATA: lv_result TYPE string.


SELECT-OPTIONS: s_ono FOR lv_ono.

SELECT ono, odate, creaby, ta  " separated by comma
  FROM zordh_28
  INTO TABLE @DATA(lt_ordh)    " Inline Declaration of internal table
  WHERE ono IN @s_ono. " Host Variables prefixed with @, ono is Guest variable

*READ TABLE lt_ordh INTO DATA(lwa_ordh) INDEX 3.
*IF sy-subrc = 0.
*  WRITE: / lwa_ordh-ono, lwa_ordh-odate, lwa_ordh-creaby, lwa_ordh-ta.
*ENDIF.

*IF line_exists( lt_ordh[ 3 ] ).  " Check if Record exists Class CX_SY_ITAB_LINE_NOT_FOUND, try and catch or Value Expression
*  DATA(lwa_ordh) = lt_ordh[ 3 ].  " No Significance of sy-subrc, if the record does not exists-> Run Time Error
*  WRITE: / lwa_ordh-ono, lwa_ordh-odate, lwa_ordh-creaby, lwa_ordh-ta.
*ELSE.
*  WRITE: TEXT-000.
*ENDIF.

DATA(lwa_ordh) = VALUE #( lt_ordh[ 3 ] OPTIONAL ). " Value Expression with key word OPTIONAL to check if line exists
IF lwa_ordh IS NOT INITIAL.
  WRITE: / lwa_ordh-ono, lwa_ordh-odate, lwa_ordh-creaby, lwa_ordh-ta.
ELSE.
  WRITE: / TEXT-000.
ENDIF.


*TRY.
*    DATA(lwa_ordh) = lt_ordh[ 3 ].
*  CATCH cx_sy_itab_line_not_found INTO lo_object.
*    CALL METHOD lo_object->if_message~get_text
*      RECEIVING
*        result = lv_result.
*ENDTRY.
*
*IF lwa_ordh IS NOT INITIAL.
*  WRITE: / lwa_ordh-ono, lwa_ordh-odate, lwa_ordh-creaby, lwa_ordh-ta.
*ELSE.
*  WRITE: lv_result.
*ENDIF.

CLEAR lwa_ordh.
ULINE.


*--------------------------------------------------------------------*

*READ TABLE lt_ordh INTO lwa_ordh WITH KEY creaby = 'DEVELOPER'.
*IF sy-subrc = 0.
*  WRITE: / lwa_ordh-ono, lwa_ordh-odate, lwa_ordh-creaby, lwa_ordh-ta.
*ENDIF.


IF line_exists( lt_ordh[ creaby = 'DEVELOPER' ] ).
  lwa_ordh = lt_ordh[ creaby = 'DEVELOPER' ].
  WRITE: / lwa_ordh-ono, lwa_ordh-odate, lwa_ordh-creaby, lwa_ordh-ta.
ELSE.
  WRITE: TEXT-000.
ENDIF.

CLEAR lwa_ordh.
ULINE.

LOOP AT lt_ordh INTO lwa_ordh.   " Inline Declaration of work area
  WRITE: / lwa_ordh-ono, lwa_ordh-odate, lwa_ordh-creaby, lwa_ordh-ta.
ENDLOOP.
