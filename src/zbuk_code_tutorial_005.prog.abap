*---------------------------------------------------------------------*
* Report         :  ZBUK_CODE_TUTORIAL_005
* Developer      :  Berkay Umut KILINÇ
* Consultant     :  -
* Date             :  26.09.2022
* Program Type   :  Report/Program
* Tcode          :  -
* TS Number      :  -
* Program Purpose:  Traffic Light ALV Tutorial
*                   ----
*----------------------------------------------------------------------*
* MODIFICATION LOG:
*----------------------------------------------------------------------*
* CORR NO         DATE       PROGRAMMER    |  CHANGES DESCRIPTION
*----------------------------------------------------------------------*
*             26.09.2022  Berkay Umut KILINÇ    Initial Version
*----------------------------------------------------------------------*

REPORT zbuk_code_tutorial_005.

TYPES: BEGIN OF lty_spfli,
         light TYPE char1.
        INCLUDE STRUCTURE spfli.
TYPES: END OF lty_spfli.

DATA: lt_spfli  TYPE TABLE OF lty_spfli,
      ls_spfli  TYPE lty_spfli,
      ls_layout TYPE slis_layout_alv.

START-OF-SELECTION.
  PERFORM get_data.
  PERFORM set_layout.
  PERFORM display_alv.

FORM get_data.
  SELECT * FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE lt_spfli.

  LOOP AT lt_spfli INTO ls_spfli.
    IF sy-tabix LE 5.
      ls_spfli-light = 1. "kırmızı ışık anlamına gelir
    ELSEIF sy-tabix GT 5 AND sy-tabix LE 10.
      ls_spfli-light = 2. " sarı renkli ışık anlamına gelir
    ELSE.
      ls_spfli-light = 3. " yeşil ışık anlamına gelir
    ENDIF.

    MODIFY lt_spfli FROM ls_spfli TRANSPORTING light.
  ENDLOOP.
ENDFORM.
FORM set_layout.
  ls_layout-zebra = abap_true.
  ls_layout-colwidth_optimize = abap_true.
  ls_layout-no_vline = abap_true.
  ls_layout-no_hline = abap_true.
  ls_layout-lights_fieldname = 'LIGHT'.
ENDFORM.
FORM display_alv.
  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      i_structure_name   = 'SPFLI'
      is_layout          = ls_layout
    TABLES
      t_outtab           = lt_spfli
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.
