*&---------------------------------------------------------------------*
*& Report ZPRG_NEW_OPENSQL_ARITHMETIC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_new_opensql_arithmetic.

*TYPES: BEGIN OF lty_data,
*         seatsmax   TYPE s_seatsmax,
*         seatsocc   TYPE s_seatsocc,
*         seatsmax_b TYPE s_smax_b,
*         seatsocc_b TYPE s_socc_b,
*       END OF lty_data.
*
*DATA: lwa_data TYPE lty_data.
*DATA: lv_seats_e TYPE i.
*DATA: lv_seats_b TYPE i.

SELECTION-SCREEN BEGIN OF BLOCK bck WITH FRAME TITLE TEXT-000.
PARAMETERS: p_carrid TYPE s_carr_id OBLIGATORY.
PARAMETERS: p_connid TYPE s_conn_id OBLIGATORY.
PARAMETERS: p_fldate TYPE s_date OBLIGATORY.
SELECTION-SCREEN END OF BLOCK bck.

*SELECT SINGLE seatsmax seatsocc seatsmax_b seatsocc_b
*   FROM sflight
*   INTO lwa_data
*   WHERE carrid = p_carrid
*   AND   connid = p_connid
*   AND   fldate = p_fldate.
*
*lv_seats_e = lwa_data-seatsmax - lwa_data-seatsocc.
*WRITE: / TEXT-001, lv_seats_e.
*
*lv_seats_b = lwa_data-seatsmax_b - lwa_data-seatsocc_b.
*WRITE: / TEXT-002, lv_seats_b.


*--------------------------------------------------------------------*
*       NEW SYNTAX CODE PUSH DOWN
*--------------------------------------------------------------------*

SELECT SINGLE seatsmax - seatsocc AS lv_seats_e, seatsmax_b - seatsocc_b AS lv_seats_b
  FROM sflight
  INTO @DATA(lwa_data)
  WHERE  carrid = @p_carrid
   AND   connid = @p_connid
   AND   fldate = @p_fldate.

WRITE: / TEXT-001, lwa_data-lv_seats_e.
WRITE: / TEXT-002, lwa_data-lv_seats_b.
