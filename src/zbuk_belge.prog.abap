*&---------------------------------------------------------------------*
*& Report ZBUK_BELGE
*&---------------------------------------------------------------------*
*&ALV-EXCEL-MAIL-ADOBEFORM
*& vbak-vbap
*&---------------------------------------------------------------------*
REPORT zbuk_belge.


INCLUDE ZBUK_BELGE_top.
INCLUDE ZBUK_BELGE_cls.
INCLUDE ZBUK_BELGE_scrn.

INITIALIZATION.
  CREATE OBJECT gr_main.
  gr_main->sscreen_name( ).


AT SELECTION-SCREEN.
  gr_main->sscreen_control( ).
  CASE sscrfields.
    WHEN 'BTTN1'.
      gr_main->get_data( iv_ebeln = p_ebeln ).
      gr_main->alv( ).
    WHEN 'BTTN2'.
      gr_main->get_data( iv_ebeln = p_ebeln ).
      gr_main->mail( ).
    WHEN 'BTTN3'.
      gr_main->get_data( iv_ebeln = p_ebeln ).
      gr_main->excel_parameters( iv_file = p_path ).
      gr_main->excel_download( iv_file = p_path ).
    WHEN 'BTTN4'.
      gr_main->get_data( iv_ebeln = p_ebeln ).
      gr_main->form( ).
  ENDCASE.
