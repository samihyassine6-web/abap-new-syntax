*&---------------------------------------------------------------------*
*& Report ZPRG_SWITCH_FOR_CASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_switch_for_case.

DATA: lv_month TYPE char40.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-000.
PARAMETERS: p_input TYPE i.
SELECTION-SCREEN END OF BLOCK b2.

* Case Statement
*------------------------*

*CASE p_input.
*  WHEN 1.
*    lv_month = TEXT-001.
*  WHEN 2.
*    lv_month = TEXT-002.
*  WHEN 3.
*    lv_month = TEXT-003.
*  WHEN 4.
*    lv_month = TEXT-004.
*  WHEN 5.
*    lv_month = TEXT-005.
*  WHEN 6.
*    lv_month = TEXT-006.
*  WHEN 7.
*    lv_month = TEXT-007.
*  WHEN 8.
*    lv_month = TEXT-008.
*  WHEN 9.
*    lv_month = TEXT-009.
*  WHEN 10.
*    lv_month = TEXT-010.
*  WHEN 11.
*    lv_month = TEXT-011.
*  WHEN 12.
*    lv_month = TEXT-012.
**  WHEN OTHERS.
**    MESSAGE: e012(zmessage) WITH p_input.
*ENDCASE.


* Switch Statement.
*------------------------------------------*

*DATA(lv_month) = SWITCH char40( p_input WHEN 1  THEN TEXT-001
*                                        WHEN 2  THEN TEXT-002
*                                        WHEN 3  THEN TEXT-003
*                                        WHEN 4  THEN TEXT-004
*                                        WHEN 5  THEN TEXT-005
*                                        WHEN 6  THEN TEXT-006
*                                        WHEN 7  THEN TEXT-007
*                                        WHEN 8  THEN TEXT-008
*                                        WHEN 9  THEN TEXT-009
*                                        WHEN 10 THEN TEXT-010
*                                        WHEN 11 THEN TEXT-011
*                                        WHEN 12 THEN TEXT-012
*                                        ELSE TEXT-013 ).

lv_month = SWITCH #( p_input WHEN 1  THEN TEXT-001
                             WHEN 2  THEN TEXT-002
                             WHEN 3  THEN TEXT-003
                             WHEN 4  THEN TEXT-004
                             WHEN 5  THEN TEXT-005
                             WHEN 6  THEN TEXT-006
                             WHEN 7  THEN TEXT-007
                             WHEN 8  THEN TEXT-008
                             WHEN 9  THEN TEXT-009
                             WHEN 10 THEN TEXT-010
                             WHEN 11 THEN TEXT-011
                             WHEN 12 THEN TEXT-012
                             ELSE TEXT-013 ).


START-OF-SELECTION.

  WRITE: lv_month.

AT SELECTION-SCREEN.

  IF p_input > 12 OR p_input IS INITIAL.
    MESSAGE: e012(zmessage) WITH p_input.
  ENDIF.
