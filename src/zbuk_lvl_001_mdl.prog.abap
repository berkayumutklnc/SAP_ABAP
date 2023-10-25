*&---------------------------------------------------------------------*
*& Include          ZBUK_LVL_001_MDL
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SATATUS_0100'.
* SET TITLEBAR 'xxx'.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE  sy-ucomm.
    WHEN '&BACK' OR '&ESC' OR '&EXIT'.
      LEAVE TO SCREEN 0.
    WHEN '&IC1' .
      gr_main->handle_hotspot_click(  ).
*	WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0101 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0101 OUTPUT.
  SET PF-STATUS 'STATUS_0101'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0101  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0101 INPUT.
  CASE  sy-ucomm.
    WHEN '&BACK' OR '&EXIT'.
      LEAVE TO SCREEN 0.
    WHEN '&IC1' .
      gr_main->handle_hotspot_click(  ).
  ENDCASE.
ENDMODULE.
