*&---------------------------------------------------------------------*
*& Report ZPRG_CONV_OPERATER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_conv_operater.

TYPES: BEGIN OF lty_data,
         eid   TYPE numc2,
         ename TYPE char40,
       END OF lty_data.

DATA: lt_data TYPE TABLE OF lty_data.
DATA: lwa_data TYPE lty_data.

*DATA: lv_file TYPE string.


SELECTION-SCREEN BEGIN OF BLOCK blc WITH FRAME TITLE TEXT-000.
PARAMETERS: p_file TYPE localfile.
SELECTION-SCREEN END OF BLOCK blc.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.


  PERFORM get_file_name USING 'Filename to download to'(011)
     CHANGING p_file.


*----------------------------------------------------------------------
*  Form  get_file_name
*----------------------------------------------------------------------
*  F4 help for file name
*----------------------------------------------------------------------
FORM get_file_name USING lo_text
                   CHANGING lo_file.

  DATA: lt_files TYPE STANDARD TABLE OF sdokpath,
        lw_file  TYPE sdokpath.

  CALL FUNCTION 'TMP_GUI_FILE_OPEN_DIALOG'
    EXPORTING
      window_title = lo_text
    TABLES
      file_table   = lt_files
    EXCEPTIONS
      OTHERS       = 4.
  IF sy-subrc = 4.
    MESSAGE 'GUI error: please contact the helpdesk' TYPE 'E'.
  ENDIF.

  READ TABLE lt_files INDEX 1 INTO lw_file.
  lo_file = lw_file-pathname.

ENDFORM.                    " get_file_name

START-OF-SELECTION.

*  lv_file = p_file.  " Helper variable for Type Casting if we are not unsing CONV Operater

  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename                = conv string( p_file )
*     FILETYPE                = 'ASC'
      has_field_separator     = 'X'
*     HEADER_LENGTH           = 0
*     READ_BY_LINE            = 'X'
*     DAT_MODE                = ' '
*     CODEPAGE                = ' '
*     IGNORE_CERR             = ABAP_TRUE
*     REPLACEMENT             = '#'
*     CHECK_BOM               = ' '
*     VIRUS_SCAN_PROFILE      =
*     NO_AUTH_CHECK           = ' '
* IMPORTING
*     FILELENGTH              =
*     HEADER                  =
    TABLES
      data_tab                = lt_data
* CHANGING
*     ISSCANPERFORMED         = ' '
    EXCEPTIONS
      file_open_error         = 1
      file_read_error         = 2
      no_batch                = 3
      gui_refuse_filetransfer = 4
      invalid_type            = 5
      no_authority            = 6
      unknown_error           = 7
      bad_data_format         = 8
      header_not_allowed      = 9
      separator_not_allowed   = 10
      header_too_long         = 11
      unknown_dp_error        = 12
      access_denied           = 13
      dp_out_of_memory        = 14
      disk_full               = 15
      dp_timeout              = 16
      OTHERS                  = 17.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  LOOP AT lt_data INTO lwa_data.
    WRITE: / lwa_data-eid, lwa_data-ename.
  ENDLOOP.
