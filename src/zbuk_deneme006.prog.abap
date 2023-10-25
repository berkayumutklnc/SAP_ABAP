*&---------------------------------------------------------------------*
*& Report ZBUK_DENEME006
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbuk_deneme006.

*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
*  PARAMETERS: p_num1 TYPE int4,
*              p_num2 TYPE int4,
*              p_top  RADIOBUTTON GROUP b1,
*              p_cik  RADIOBUTTON GROUP b1,
*              p_bol  RADIOBUTTON GROUP b1,
*              p_carp RADIOBUTTON GROUP b1.
*SELECTION-SCREEN END OF BLOCK b1.
*data gv_top TYPE p DECIMALS 3.
*START-OF-SELECTION.
*
*IF p_top eq abap_true.
*
*ENDIF.
