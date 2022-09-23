*&---------------------------------------------------------------------*
*&  Include           ZEGT_026_MDL
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_001'.

ENDMODULE.                 " STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'DISP'.
      SELECT SINGLE * FROM spfli WHERE carrid = p_car.
      CALL SCREEN 0101 STARTING AT 35 12
                       ENDING AT 120  30.
    WHEN '&BACK' OR '&ESC' OR '&EXIT'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.                 " USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*&      Module  STATUS_0101  OUTPUT
*&---------------------------------------------------------------------*

MODULE status_0101 OUTPUT.
  SET PF-STATUS 'STAT'.

ENDMODULE.                 " STATUS_0101  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0101  INPUT
*&---------------------------------------------------------------------*

MODULE user_command_0101 INPUT.
  CASE sy-ucomm.
    WHEN 'ENTER' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN '&BACK' OR '&ESC' OR '&EXIT'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.                 " USER_COMMAND_0101  INPUT
