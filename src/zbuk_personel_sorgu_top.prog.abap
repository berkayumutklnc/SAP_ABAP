*&---------------------------------------------------------------------*
*& Include          ZBUK_PERSONEL_SORGU_TOP
*&---------------------------------------------------------------------*
TABLES: zbuk_t_personel.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECTION-SCREEN BEGIN OF LINE.
    PARAMETERS: p_pid TYPE zbuk_t_personel-pers_id.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN PUSHBUTTON 2(20)  TEXT-002 USER-COMMAND but01.
  SELECTION-SCREEN PUSHBUTTON 25(30) TEXT-003 USER-COMMAND but02.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-004.
  PARAMETERS: p_pad   TYPE zbuk_t_personel-pers_ad,
              p_psad  TYPE zbuk_t_personel-pers_sad,
              p_pcins TYPE zbuk_t_personel-pers_cins,
              p_pmhal TYPE zbuk_t_personel-pers_medhal,
              p_pdtar TYPE zbuk_t_personel-pers_dt.
SELECTION-SCREEN END OF BLOCK b2.
