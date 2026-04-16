*&---------------------------------------------------------------------*
*& Report ZPRG_BRFPLUS_APPLICATION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_brfplus_application.

PARAMETERS: p_input TYPE zdeduration.


CONSTANTS:lv_function_id TYPE if_fdt_types=>id VALUE '080027FA439B1EDFBC8AC66D47EBE276'.
DATA:lv_timestamp  TYPE timestamp,
     lt_name_value TYPE abap_parmbind_tab,
     ls_name_value TYPE abap_parmbind,
     lr_data       TYPE REF TO data,
     lx_fdt        TYPE REF TO cx_fdt,
     la_pinput     TYPE if_fdt_types=>element_text,
     la_poutput    TYPE zdeinterest.
FIELD-SYMBOLS <la_any> TYPE any.
****************************************************************************************************
* Alle Methodenaufrufe, die innerhalb eines Bearbeitungszyklus dieselbe Funktion aufrufen, müssen denselben Zeitstempel verwenden
* Bei Folgeaufrufen derselben Funktion ist es ratsam, alle Aufrufe mit demselben Zeitstempel auszuführen
* Dies dient zur Verbesserung der System-Performance
****************************************************************************************************
* Wenn Sie Strukturen oder Tabellen ohne DDIC-Bindung verwenden, müssen Sie die jeweiligen Typen
* selbst angeben. Fügen Sie den entsprechenden Datentyp in die jeweilige Zeile des Quellcodes ein.
****************************************************************************************************
GET TIME STAMP FIELD lv_timestamp.
****************************************************************************************************
* Funktion ohne Aufzeichnung der Trace-Daten bearbeiten, Kontextdatenobjekte per Namen-/Wertetabelle übergeben
****************************************************************************************************
* Funktionsbearbeitung vorbereiten:
****************************************************************************************************

*CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
*  EXPORTING
*    input         = p_input
* IMPORTING
*   OUTPUT        = p_input
*          .

*SHIFT p_input LEFT DELETING LEADING '0'.


DATA(lv_input) = p_input+1.

ls_name_value-name = 'PINPUT'.
la_pinput = lv_input.
GET REFERENCE OF la_pinput INTO lr_data.
ls_name_value-value = lr_data.
INSERT ls_name_value INTO TABLE lt_name_value.
****************************************************************************************************
* Ergebnisdatenobjekt ist an einen ABAP-Diction.-Typ gebunden
* Lassen Sie BRFplus das Ergebnis in ein externes ABAP-Dictionary-Format konvertieren:
****************************************************************************************************
GET REFERENCE OF la_poutput INTO lr_data.
ASSIGN lr_data->* TO <la_any>.
TRY.
    cl_fdt_function_process=>process( EXPORTING iv_function_id = lv_function_id
                                                iv_timestamp   = lv_timestamp
                                      IMPORTING ea_result      = <la_any>
                                      CHANGING  ct_name_value  = lt_name_value ).
  CATCH cx_fdt INTO lx_fdt.
****************************************************************************************************
* Sie können zur Fehlerbehandlung CX_FDT->MT_MESSAGE prüfen.
****************************************************************************************************
ENDTRY.

WRITE: / <la_any>.
