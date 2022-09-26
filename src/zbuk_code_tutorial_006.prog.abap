*---------------------------------------------------------------------*
* Report         :  ZBUK_CODE_TUTORIAL_006
* Developer      :  Berkay Umut KILINÇ
* Consultant     :  -
* Date             :  26.09.2022
* Program Type   :  Report/Program
* Tcode          :  -
* TS Number      :  -
* Program Purpose:  Registration Screen Tutorial
*                   ----
*----------------------------------------------------------------------*
* MODIFICATION LOG:
*----------------------------------------------------------------------*
* CORR NO         DATE       PROGRAMMER    |  CHANGES DESCRIPTION
*----------------------------------------------------------------------*
*             26.09.2022  Berkay Umut KILINÇ    Initial Version
*----------------------------------------------------------------------*
REPORT zbuk_code_tutorial_006.

TABLES: zbrkyt_lig, zbrkyt_personel, zbrkyt_takim, sscrfields.

SELECTION-SCREEN FUNCTION KEY 1.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
PARAMETERS: rb_pers   RADIOBUTTON GROUP rb1 USER-COMMAND rd,
            rb_takim  RADIOBUTTON GROUP rb1 DEFAULT 'X' ,
            rb_lig    RADIOBUTTON GROUP rb1 .
SELECTION-SCREEN END OF BLOCK b1.

IF  rb_pers IS NOT INITIAL.

  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-002.
  PARAMETERS: p_persid  TYPE zbrkyt_personel-personel_id       MODIF ID fl1,
              p_brid    TYPE zbrkyt_personel-brans_id          MODIF ID fl1,
              p_lgid    TYPE zbrkyt_personel-lig_id            MODIF ID fl1,
              p_tkmid   TYPE zbrkyt_personel-takim_id          MODIF ID fl1,
              p_persad  TYPE zbrkyt_personel-personel_ad       MODIF ID fl1,
              p_perssy  TYPE zbrkyt_personel-personel_soyad    MODIF ID fl1,
              p_persdt  TYPE zbrkyt_personel-personel_dtarih   MODIF ID fl1,
              p_persuy  TYPE zbrkyt_personel-personel_uyruk    MODIF ID fl1,
              p_perscn  TYPE zbrkyt_personel-personel_cinsiyet MODIF ID fl1.


  SELECTION-SCREEN END OF BLOCK b2.

ENDIF.

IF rb_takim IS NOT INITIAL.
  SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE text-003.
  PARAMETERS: p_tkid   TYPE  zbrkyt_takim-takim_id       MODIF ID fl2,
              p_lid    TYPE  zbrkyt_takim-lig_id         MODIF ID fl2,
              p_bid    TYPE  zbrkyt_takim-brans_id       MODIF ID fl2,
              p_tkmad  TYPE  zbrkyt_takim-takim_ad       MODIF ID fl2,
              p_tkmps  TYPE  zbrkyt_takim-personel_sayi  MODIF ID fl2,
              p_tkmct  TYPE  zbrkyt_takim-sehir_ad       MODIF ID fl2,
              p_tkmkt  TYPE  zbrkyt_takim-kurulus_tarihi MODIF ID fl2.

  SELECTION-SCREEN END OF BLOCK b3.

ENDIF.

IF rb_lig IS NOT INITIAL.
  SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE text-004.
  PARAMETERS: p_ligid   TYPE  zbrkyt_lig-lig_id       MODIF ID fl3,
              p_braid   TYPE  zbrkyt_lig-brans_id     MODIF ID fl3,
              p_lgad    TYPE  zbrkyt_lig-lig_ad       MODIF ID fl3,
              p_lgtsy   TYPE  zbrkyt_lig-takim_sayisi MODIF ID fl3.

  SELECTION-SCREEN END OF BLOCK b4.

ENDIF.


DATA: lv_range_nr     TYPE inri-nrrangenr,
      lv_object       TYPE inri-object,
      lv_numberpers   TYPE zbrkyt_personel-personel_id,
      lv_numbertkm    TYPE zbrkyt_takim-takim_id,
      lv_numberlig    TYPE zbrkyt_lig-lig_id.

DATA: ls_takim TYPE zbrkyt_takim,
      lt_takim TYPE TABLE OF zbrkyt_takim,
      ls_lig   TYPE zbrkyt_lig,
      lt_lig   TYPE TABLE OF zbrkyt_lig,
      ls_pers  TYPE zbrkyt_personel,
      lt_pers  TYPE TABLE OF zbrkyt_personel.

DATA: lv_flag,
      answ.


SELECTION-SCREEN PUSHBUTTON 1(10)  text-006  USER-COMMAND btn_01 MODIF ID bt1.
SELECTION-SCREEN PUSHBUTTON 15(10) text-007  USER-COMMAND btn_02 MODIF ID bt1.

**********************************************************************

INITIALIZATION.
  sscrfields-functxt_01 = 'DÜZENLEME'.

AT SELECTION-SCREEN.
  PERFORM button.

AT SELECTION-SCREEN OUTPUT.
  PERFORM modify_screen.
  PERFORM data_get.


START-OF-SELECTION.
  PERFORM data_save.

**********************************************************************
FORM modify_screen.

  LOOP AT SCREEN.
    IF screen-group1 = 'FL1'.
      IF  rb_pers = abap_true.
        screen-active = 1.
      ELSE."
        screen-active = 0.
      ENDIF.
    ENDIF.
    IF screen-group1 = 'FL2'.
      IF  rb_takim = abap_true.
        screen-active = 1.
      ELSE.
        screen-active = 0.
      ENDIF.
    ENDIF.
    IF screen-group1 = 'FL3'.
      IF  rb_lig = abap_true.
        screen-active = 1.
      ELSE.
        screen-active = 0.
      ENDIF.
    ENDIF.

    IF rb_pers = abap_true AND lv_flag = abap_false AND screen-name = 'P_PERSID'.
      screen-input = 0.
    ELSEIF rb_takim = abap_true AND lv_flag = abap_false AND screen-name = 'P_TKID'.
      screen-input = 0.
    ELSEIF rb_lig = abap_true AND lv_flag = abap_false AND screen-name = 'P_LIGID'.
      screen-input = 0.
    ENDIF.
    IF lv_flag = abap_false AND screen-group1 = 'BT1'.
      screen-active = '0'.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.

ENDFORM.                    " MODIFY_SCREEN
*&---------------------------------------------------------------------*
*&      Form  SAVE_DATA
*&---------------------------------------------------------------------*

FORM data_save.

  IF rb_pers = abap_true AND  p_persad IS NOT INITIAL AND
         p_perssy IS NOT INITIAL AND p_persuy IS NOT INITIAL AND p_persdt IS NOT INITIAL AND
         p_perscn IS NOT INITIAL AND p_tkmid IS NOT INITIAL AND p_lgid IS NOT INITIAL AND p_brid IS NOT INITIAL.
    lv_range_nr = '1'.
    lv_object = 'ZBRKYNB_PS'.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = lv_range_nr
        object                  = lv_object
      IMPORTING
        number                  = lv_numberpers
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.
    IF sy-subrc <> 0.
    ENDIF.

    ls_pers-personel_id       = lv_numberpers.
    ls_pers-personel_ad       = p_persad.
    ls_pers-personel_soyad    = p_perssy.
    ls_pers-personel_uyruk    = p_persuy.
    ls_pers-personel_dtarih   = p_persdt.
    ls_pers-personel_cinsiyet = p_perscn.
    ls_pers-takim_id          = p_tkmid.
    ls_pers-lig_id            = p_lgid .
    ls_pers-brans_id          = p_brid.

    MODIFY zbrkyt_personel FROM ls_pers.

    IF sy-subrc = 0 .
      MESSAGE text-005 TYPE 'I'.
    ENDIF.

  ELSEIF rb_takim = abap_true AND p_tkmps IS NOT INITIAL AND p_tkmad IS NOT INITIAL AND p_tkmct IS NOT INITIAL AND
         p_tkmkt IS NOT INITIAL AND p_lid IS NOT INITIAL AND p_bid IS NOT INITIAL.

    lv_range_nr = '1'.
    lv_object = 'ZBRKYNB_TK'.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = lv_range_nr
        object                  = lv_object
      IMPORTING
        number                  = lv_numbertkm
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.
    IF sy-subrc <> 0.
    ENDIF.
    ls_takim-takim_id       = lv_numbertkm.
    ls_takim-personel_sayi  = p_tkmps.
    ls_takim-takim_ad       = p_tkmad.
    ls_takim-sehir_ad       = p_tkmct.
    ls_takim-kurulus_tarihi = p_tkmkt.
    ls_takim-lig_id         = p_lid.
    ls_takim-brans_id       = p_bid.
    MODIFY zbrkyt_takim FROM ls_takim.

    IF sy-subrc = 0 .
      MESSAGE text-005 TYPE 'I'.
    ENDIF.

  ELSEIF rb_lig = abap_true AND p_lgad IS NOT INITIAL AND p_lgtsy IS NOT INITIAL AND p_braid IS NOT INITIAL.

    lv_range_nr = '1'.
    lv_object = 'ZBRKYNB_LG'.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = lv_range_nr
        object                  = lv_object
      IMPORTING
        number                  = lv_numberlig
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.
    IF sy-subrc <> 0.
    ENDIF.
    ls_lig-lig_id        = lv_numberlig.
    ls_lig-lig_ad        = p_lgad.
    ls_lig-takim_sayisi  = p_lgtsy.
    ls_lig-brans_id      = p_braid.
    MODIFY zbrkyt_lig FROM ls_lig.

    IF sy-subrc = 0 .
      MESSAGE text-005 TYPE 'I'.
    ENDIF.
  ELSE.
    MESSAGE text-006 TYPE 'E'.
  ENDIF.


ENDFORM.                    " SAVE_DATA
*&---------------------------------------------------------------------*
*&      Form  BUTTON
*&---------------------------------------------------------------------*

FORM button .
  CASE sy-ucomm.
    WHEN 'FC01'.
      PERFORM button_duzenleme.
    WHEN 'BTN_01'.
      PERFORM button_guncelleme.
    WHEN 'BTN_02'.
      PERFORM button_silme.
  ENDCASE.


ENDFORM.                    " BUTTON
*&---------------------------------------------------------------------*
*&      Form  BUTTON_DUZENLEME
*&---------------------------------------------------------------------*

FORM button_duzenleme .
  IF lv_flag = abap_true.
    lv_flag = abap_false.
  ELSE.
    lv_flag = abap_true.
  ENDIF.

ENDFORM.                    " BUTTON_DUZENLEME
*&---------------------------------------------------------------------*
*&      Form  BUTTON_GUNCELLEME
*&---------------------------------------------------------------------*

FORM button_guncelleme .
  DATA: ls_tkmgn TYPE zbrkyt_takim,
        ls_pergn TYPE zbrkyt_personel,
        ls_lign  TYPE zbrkyt_lig.

  IF rb_pers = abap_true AND lv_numberpers IS NOT INITIAL.

    FREE: ls_pers.
    ls_pers-personel_ad       = p_persad.
    ls_pers-personel_soyad    = p_perssy.
    ls_pers-personel_uyruk    = p_persuy.
    ls_pers-personel_dtarih   = p_persdt.
    ls_pers-personel_cinsiyet = p_perscn.
    ls_pers-takim_id          = p_tkmid.
    ls_pers-lig_id            = p_lgid .
    ls_pers-brans_id          = p_brid.

    UPDATE zbrkyt_personel FROM ls_pergn.
    IF sy-subrc = abap_true.
      MESSAGE text-008 TYPE 'I'.
    ENDIF.

*    SELECT SINGLE * FROM zbrkyt_personel INTO ls_pergn
*      WHERE personel_id EQ lv_numberpers.
  ELSEIF rb_takim = abap_true AND lv_numbertkm IS NOT INITIAL.

    FREE: ls_takim.
    ls_takim-personel_sayi  = p_tkmps.
    ls_takim-takim_ad       = p_tkmad.
    ls_takim-sehir_ad       = p_tkmct.
    ls_takim-kurulus_tarihi = p_tkmkt.
    ls_takim-lig_id         = p_lid.
    ls_takim-brans_id       = p_bid.
    UPDATE zbrkyt_takim FROM ls_takim.
    IF sy-subrc = abap_true.
      MESSAGE text-008 TYPE 'I'.
    ENDIF.
  ELSEIF rb_lig = abap_true AND lv_numberlig IS NOT INITIAL.

    FREE: ls_lig.
    ls_lig-lig_ad        = p_lgad.
    ls_lig-takim_sayisi  = p_lgtsy.
    ls_lig-brans_id      = p_braid.
    UPDATE zbrkyt_lig FROM ls_lig.
    IF sy-subrc = abap_true.
      MESSAGE text-008 TYPE 'I'.
    ENDIF.
  ENDIF.
ENDFORM.                    " BUTTON_GUNCELLEME
*&---------------------------------------------------------------------*
*&      Form  BUTTON_SILME
*&---------------------------------------------------------------------*

FORM button_silme.
  IF  rb_pers = abap_true AND lv_numberpers IS NOT INITIAL.
    PERFORM delete_screen.
    IF answ EQ abap_true.
      DELETE FROM zbrkyt_personel WHERE personel_id = lv_numberpers.
    ENDIF.

  ELSEIF rb_takim = abap_true AND lv_numbertkm IS NOT INITIAL.
    PERFORM delete_screen.
    IF answ EQ abap_true.
      DELETE FROM zbrkyt_takim WHERE takim_id = lv_numbertkm.
    ENDIF.

  ELSEIF rb_lig = abap_true AND lv_numberlig IS NOT INITIAL.
    PERFORM delete_screen.
    IF answ EQ abap_true.
      DELETE FROM zbrkyt_lig WHERE lig_id = lv_numberlig.
    ENDIF.
  ENDIF.


ENDFORM.                    " BUTTON_SILME
*&---------------------------------------------------------------------*
*&      Form  DATA_GET
*&---------------------------------------------------------------------*

FORM data_get .
  IF rb_pers = abap_true AND lv_numberpers IS NOT INITIAL.
    FREE: ls_lig.
    SELECT SINGLE * FROM zbrkyt_personel INTO ls_pers WHERE personel_id = lv_numberpers.
    p_persad = ls_pers-personel_ad.
    p_perssy = ls_pers-personel_soyad.
    p_persuy = ls_pers-personel_uyruk.
    p_persdt = ls_pers-personel_dtarih.
    p_perscn = ls_pers-personel_cinsiyet.
    p_tkmid  = ls_pers-takim_id.
    p_lgid   = ls_pers-lig_id.
    p_brid   = ls_pers-brans_id.

  ELSEIF rb_takim = abap_true AND lv_numbertkm IS NOT INITIAL.
    FREE : ls_takim.
    SELECT SINGLE * FROM zbrkyt_takim INTO ls_takim WHERE takim_id = lv_numbertkm.
    p_tkmps = ls_takim-personel_sayi.
    p_tkmad = ls_takim-takim_ad.
    p_tkmct = ls_takim-sehir_ad.
    p_tkmkt = ls_takim-kurulus_tarihi.
    p_lid   = ls_takim-lig_id.
    p_bid   = ls_takim-brans_id.

  ELSEIF rb_lig = abap_true AND lv_numberlig IS NOT INITIAL.
    FREE : ls_lig.
    SELECT SINGLE * FROM zbrkyt_lig INTO ls_lig WHERE lig_id = lv_numberlig.
    p_lgad  = ls_lig-lig_ad.
    p_lgtsy = ls_lig-takim_sayisi.
    p_braid = ls_lig-brans_id.
  ENDIF.
ENDFORM.                    " DATA_GET
*&---------------------------------------------------------------------*
*&      Form  DELETE_SCREEN
*&---------------------------------------------------------------------*

FORM delete_screen .
  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      text_question  = 'Silme İşlemi Gerçekleştirelecektir. Emin Misin???'
      text_button_1  = 'Evet'
      text_button_2  = 'Hayır'
    IMPORTING
      answer         = answ
    EXCEPTIONS
      text_not_found = 1
      OTHERS         = 2.

ENDFORM.                    " DELETE_SCREEN
