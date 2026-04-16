*&---------------------------------------------------------------------*
*& Report ZPRG_SALES_ORDER_JOIN_NEW_SYNT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_sales_order_join_new_synt.

DATA: lt_fieldcat TYPE slis_t_fieldcat_alv.  " FM 'REUSE_ALV_FIELDCATALOG_MERGE

DATA: lv_odate TYPE zdeodate_28.

SELECTION-SCREEN BEGIN OF BLOCK blc WITH FRAME TITLE TEXT-000.
SELECT-OPTIONS: s_odate FOR lv_odate.
SELECTION-SCREEN END OF BLOCK blc.

*--------------------------------------------------------------------*
*  INNER JOIN TO FETCH ONLY MATCHING DATA
*--------------------------------------------------------------------*

SELECT a~ono, b~oin, b~itemid, b~meng, b~icost, c~itemdesc
FROM zordh_28 AS a JOIN zordi_28 AS b
ON a~ono = b~ono
JOIN ztitemt_28 AS c
ON b~itemid = c~itemid
WHERE a~odate IN @s_odate
AND c~spras = @sy-langu
INTO TABLE @DATA(lt_output).

SORT lt_output BY ono.

*----------------------------------------------------------------------------------------*
*   CREATE FIELD CATALOG
*-----------------------------------------------------------------------------------------*
lt_fieldcat = VALUE #( ( col_pos = 1 fieldname = 'ONO'      seltext_l = TEXT-001 )
                       ( col_pos = 2 fieldname = 'OIN'      seltext_l = TEXT-002 )
                       ( col_pos = 3 fieldname = 'ITEMID'   seltext_l = TEXT-003 )
                       ( col_pos = 4 fieldname = 'MENG'     seltext_l = TEXT-004 )
                       ( col_pos = 5 fieldname = 'ICOST'    seltext_l = TEXT-005 )
                       ( col_pos = 6 fieldname = 'ITEMDESC' seltext_l = TEXT-006 )
                     ).

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
*   I_INTERFACE_CHECK                 = ' '
*   I_BYPASSING_BUFFER                = ' '
*   I_BUFFER_ACTIVE                   = ' '
*   I_CALLBACK_PROGRAM                = ' '
*   I_CALLBACK_PF_STATUS_SET          = ' '
*   I_CALLBACK_USER_COMMAND           = ' '
*   I_CALLBACK_TOP_OF_PAGE            = ' '
*   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*   I_CALLBACK_HTML_END_OF_LIST       = ' '
*   I_STRUCTURE_NAME                  =
*   I_BACKGROUND_ID                   = ' '
*   I_GRID_TITLE  =
*   I_GRID_SETTINGS                   =
*   IS_LAYOUT     =
    it_fieldcat   = lt_fieldcat
*   IT_EXCLUDING  =
*   IT_SPECIAL_GROUPS                 =
*   IT_SORT       =
*   IT_FILTER     =
*   IS_SEL_HIDE   =
*   I_DEFAULT     = 'X'
*   I_SAVE        = ' '
*   IS_VARIANT    =
*   IT_EVENTS     =
*   IT_EVENT_EXIT =
*   IS_PRINT      =
*   IS_REPREP_ID  =
*   I_SCREEN_START_COLUMN             = 0
*   I_SCREEN_START_LINE               = 0
*   I_SCREEN_END_COLUMN               = 0
*   I_SCREEN_END_LINE                 = 0
*   I_HTML_HEIGHT_TOP                 = 0
*   I_HTML_HEIGHT_END                 = 0
*   IT_ALV_GRAPHICS                   =
*   IT_HYPERLINK  =
*   IT_ADD_FIELDCAT                   =
*   IT_EXCEPT_QINFO                   =
*   IR_SALV_FULLSCREEN_ADAPTER        =
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER           =
*   ES_EXIT_CAUSED_BY_USER            =
  TABLES
    t_outtab      = lt_output
  EXCEPTIONS
    program_error = 1
    OTHERS        = 2.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
