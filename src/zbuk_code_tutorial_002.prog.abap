*---------------------------------------------------------------------*
* Report         :  ZBUK_CODE_TUTORIAL_002
* Developer      :  Berkay Umut KILINÇ
* Consultant     :  -
* Date             :  26.09.2022
* Program Type   :  Report/Program
* Tcode          :  -
* TS Number      :  -
* Program Purpose:  Reverse Text Tutorial
*                   ----
*----------------------------------------------------------------------*
* MODIFICATION LOG:
*----------------------------------------------------------------------*
* CORR NO         DATE       PROGRAMMER    |  CHANGES DESCRIPTION
*----------------------------------------------------------------------*
*             26.09.2022  Berkay Umut KILINÇ    Initial Version
*----------------------------------------------------------------------*

REPORT zbuk_code_tutorial_002.

TYPES : lty_str TYPE string.

PARAMETERS : p_str TYPE lty_str OBLIGATORY.

DATA: lv_data   TYPE string,
      lv_char   TYPE c,
      lv_length TYPE i.

lv_data   = p_str.
lv_length = strlen( lv_data ).

DATA(lv_degisken) = lv_length - 1.

DO lv_length TIMES.
  lv_char = lv_data+lv_degisken(1).
  WRITE lv_char.
  lv_degisken = lv_degisken - 1.
ENDDO.
