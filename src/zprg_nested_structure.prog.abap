*&---------------------------------------------------------------------*
*& Report ZPRG_NESTED_STRUCTURE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_nested_structure.

DATA: wa_person TYPE zperson.
DATA: wa_phone TYPE zkontakt.






SELECTION-SCREEN BEGIN OF BLOCK blc WITH FRAME TITLE TEXT-000.
PARAMETERS: pa_finam TYPE zfirstname,
            pa_lanam TYPE zlastname,
            pa_stree TYPE s_street,
            pa_nr    TYPE s_no,
            pa_city  TYPE s_city,
            pa_zip   TYPE postcode.
SELECTION-SCREEN END OF BLOCK blc.


INITIALIZATION.

  pa_finam = 'Samih'.

START-OF-SELECTION.

  wa_person-name-first_name = pa_finam.
  wa_person-name-last_name  = pa_lanam.
  wa_person-adress-street   = pa_stree.
  wa_person-adress-st_no    = pa_nr.
  wa_person-adress-city     = pa_city.
  wa_person-adress-pincode  = pa_zip.



  WRITE: / 'Person Details:',
         / wa_person-name-first_name,
         / wa_person-name-last_name,
         / wa_person-adress-street ,
         / wa_person-adress-st_no LEFT-JUSTIFIED,
         / wa_person-adress-city,
         / wa_person-adress-pincode.

  wa_phone-phone = '0225484555'.
  wa_phone-email = 'fgzhhjd@mail.com'.
  INSERT wa_phone INTO TABLE wa_person-phone.

  wa_phone-phone = '0123456789'.
  wa_phone-email = 'abcdrf@mail.com'.
  INSERT wa_phone INTO TABLE wa_person-phone.

  CLEAR: wa_phone.

  LOOP AT wa_person-phone INTO wa_phone.

    WRITE: / 'Mobile:',  wa_phone-phone,
           / 'Email:',   wa_phone-email.

    NEW-LINE.

  ENDLOOP.
