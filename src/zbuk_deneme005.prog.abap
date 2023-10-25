*&---------------------------------------------------------------------*
*& Report ZBUK_DENEME005
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbuk_deneme005.

TYPES: BEGIN OF gty_data,
         kolon1  TYPE char20,
         kolon2  TYPE char20,
         kolon3  TYPE char20,
         kolon4  TYPE char20,
         kolon5  TYPE char20,
         kolon6  TYPE char20,
         kolon7  TYPE char20,
         kolon8  TYPE char20,
         kolon9  TYPE char20,
         kolon10 TYPE char20,
       END OF gty_data.

DATA: gt_data     TYPE TABLE OF gty_data,
      gt_raw_data TYPE truxs_t_text_data.

PARAMETERS: p_file TYPE rlgrap-filename.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
      field_name = 'P_FILE'
    IMPORTING
      file_name  = p_file.

START-OF-SELECTION.

  CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
    EXPORTING
*     I_FIELD_SEPERATOR    =
      i_line_header        = 'X'
      i_tab_raw_data       = gt_raw_data
      i_filename           = p_file
*     I_STEP               = 1
    TABLES
      i_tab_converted_data = gt_data
    EXCEPTIONS
      conversion_failed    = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
  ENDIF.
