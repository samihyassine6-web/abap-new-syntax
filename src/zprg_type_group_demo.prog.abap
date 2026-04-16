*&---------------------------------------------------------------------*
*& Report ZPRG_TYPE_GROUP_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_type_group_demo.


TYPE-POOLS: zmytp.

DATA: l_circ TYPE f.
DATA: l_rad TYPE f VALUE '5.7'.
DATA: lc_perc TYPE zmytp_percentage VALUE '22.5'.


l_circ = 2 * l_rad * zmytp_pi.

WRITE: / l_circ.
