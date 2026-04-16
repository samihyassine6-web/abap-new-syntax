*&---------------------------------------------------------------------*
*& Report ZPRG_SALES_OUTER_JOIN_NEW_SYNT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_sales_outer_join_new_synt.

TYPES: BEGIN OF lty_output,
         ono      TYPE zdeono_28,
         oin      TYPE zdeoin_28,
         itemid   TYPE zdeitemid_28,
         meng     TYPE zdemeng_28,
         icost    TYPE zdeicost_28,
         itemdesc TYPE zdeitemdesc_28,
       END OF lty_output.

DATA: lt_output TYPE TABLE OF lty_output.
DATA: lwa_output TYPE lty_output.

DATA: lt_fieldcat TYPE slis_t_fieldcat_alv.  " FM 'REUSE_ALV_FIELDCATALOG_MERGE

DATA: lv_odate TYPE zdeodate_28.

SELECTION-SCREEN BEGIN OF BLOCK blc WITH FRAME TITLE TEXT-000.
SELECT-OPTIONS: s_odate FOR lv_odate.
SELECTION-SCREEN END OF BLOCK blc.

*--------------------------------------------------------------------*
*  OUTER JOIN TO FETCH MATCHING AND NO MATCHING DATA
*--------------------------------------------------------------------*

SELECT a~ono, b~oin, b~itemid, b~meng, b~icost
FROM zordh_28 AS a LEFT OUTER JOIN zordi_28 AS b
ON a~ono = b~ono
INTO TABLE @DATA(lt_data)
WHERE a~odate IN @s_odate.

IF lt_data IS NOT INITIAL.
  DATA(lt_temp_data) = lt_data.
  DELETE lt_temp_data WHERE itemid IS INITIAL.
  SORT lt_temp_data BY itemid.
  DELETE ADJACENT DUPLICATES FROM lt_temp_data COMPARING itemid.
  SELECT itemid, itemdesc
    FROM ztitemt_28
    INTO TABLE @DATA(lt_zitemt)
    FOR ALL ENTRIES IN @lt_temp_data
    WHERE itemid = @lt_temp_data-itemid
    AND spras = @sy-langu.
ENDIF.

LOOP AT lt_data INTO DATA(lwa_data).
  IF line_exists( lt_zitemt[ itemid = lwa_data-itemid ] ).
    DATA(lwa_zitemt) = lt_zitemt[ itemid = lwa_data-itemid ].
  ENDIF.
  lwa_output = VALUE #( ono = lwa_data-ono oin = lwa_data-oin itemid = lwa_data-itemid              " # = lty_output
                        meng = lwa_data-meng icost = lwa_data-icost itemdesc = lwa_zitemt-itemdesc ).
  APPEND lwa_output TO lt_output.
  CLEAR: lwa_output, lwa_zitemt, lwa_data.
ENDLOOP.

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
