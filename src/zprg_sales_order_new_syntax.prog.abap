*&---------------------------------------------------------------------*
*& Report ZPRG_SALES_ORDER_NEW_SYNTAX
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_sales_order_new_syntax.

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

SELECT FROM zordh_28
FIELDS ono
WHERE odate IN @s_odate
INTO TABLE @DATA(lt_ordh).

IF lt_ordh IS NOT INITIAL.
  SELECT FROM zordi_28
    FIELDS ono, oin, itemid, meng, icost
    FOR ALL ENTRIES IN @lt_ordh
    WHERE ono = @lt_ordh-ono
    INTO TABLE @DATA(lt_ordi).
ENDIF.

IF lt_ordi IS NOT INITIAL.
  DATA(lt_temp_ordi) = lt_ordi.
  SORT lt_temp_ordi BY itemid.
  DELETE ADJACENT DUPLICATES FROM lt_temp_ordi COMPARING itemid.
  SELECT FROM ztitemt_28
    FIELDS itemid, itemdesc
    FOR ALL ENTRIES IN @lt_temp_ordi
    WHERE itemid = @lt_temp_ordi-itemid
    AND spras = @sy-langu
    INTO TABLE @DATA(lt_zitemt).
ENDIF.

*--------------------------------------------------------------------------------------*
*  APPEND VALUE #( ono = lwa_ordh-ono oin = lwa_ordi-oin itemid = lwa_ordi-itemid
*          meng = lwa_ordi-meng icost = lwa_ordi-icost itemdesc = lwa_zitemt-itemdesc ).
*          TO lt_output
*---------------------------------------------------------------------------------------*

LOOP AT lt_ordh INTO DATA(lwa_ordh).
  LOOP AT lt_ordi INTO DATA(lwa_ordi) WHERE ono = lwa_ordh-ono.
    IF line_exists( lt_zitemt[ itemid = lwa_ordi-itemid ] ).         " Check if line exists
      DATA(lwa_zitemt) = lt_zitemt[ itemid = lwa_ordi-itemid ].      " Read Table new Syntax
*      lwa_output = VALUE #( ono = lwa_ordh-ono oin = lwa_ordi-oin itemid = lwa_ordi-itemid              " # = lty_output
*                            meng = lwa_ordi-meng icost = lwa_ordi-icost itemdesc = lwa_zitemt-itemdesc ).
*      APPEND lwa_output TO lt_output.
      lt_output = VALUE #( BASE lt_output (  ono = lwa_ordh-ono oin = lwa_ordi-oin itemid = lwa_ordi-itemid  " Append Records directly to the internal table using BASE:
                            meng = lwa_ordi-meng icost = lwa_ordi-icost itemdesc = lwa_zitemt-itemdesc ) ).
      CLEAR: lwa_ordi, lwa_zitemt.
      DATA(lv_flag) = 'X'.
    ENDIF.
  ENDLOOP.
  IF lv_flag = ' '.
*    lwa_output = VALUE #( ono = lwa_ordh-ono oin = lwa_ordi-oin itemid = lwa_ordi-itemid
*                          meng = lwa_ordi-meng icost = lwa_ordi-icost itemdesc = lwa_zitemt-itemdesc ).
*    APPEND lwa_output TO lt_output.
    lt_output = VALUE #( BASE lt_output ( ono = lwa_ordh-ono oin = lwa_ordi-oin itemid = lwa_ordi-itemid
                          meng = lwa_ordi-meng icost = lwa_ordi-icost itemdesc = lwa_zitemt-itemdesc ) ).
*    CLEAR: lwa_output.
  ENDIF.
  CLEAR lv_flag.
ENDLOOP.

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
