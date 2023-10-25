*&---------------------------------------------------------------------*
*& Report ZBUK_LVL_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbuk_lvl_001.

INCLUDE ZBUK_LVL_001_top.
INCLUDE ZBUK_LVL_001_cls.
INCLUDE ZBUK_LVL_001_mdl.

INITIALIZATION.
  CREATE OBJECT gr_main.

AT SELECTION-SCREEN OUTPUT.

START-OF-SELECTION.
  gr_main->get_data( iv_carrid = p_carrid ).
  gr_main->first_alv( ).
  CALL SCREEN '0100'.


END-OF-SELECTION.
