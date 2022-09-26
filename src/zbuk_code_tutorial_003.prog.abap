*---------------------------------------------------------------------*
* Report         :  ZBUK_CODE_TUTORIAL_003
* Developer      :  Berkay Umut KILINÇ
* Consultant     :  -
* Date             :  26.09.2022
* Program Type   :  Report/Program
* Tcode          :  -
* TS Number      :  -
* Program Purpose:  Text Tutorial
*                   ----
*----------------------------------------------------------------------*
* MODIFICATION LOG:
*----------------------------------------------------------------------*
* CORR NO         DATE       PROGRAMMER    |  CHANGES DESCRIPTION
*----------------------------------------------------------------------*
*             26.09.2022    Berkay Umut KILINÇ    Initial Version
*----------------------------------------------------------------------*

REPORT zbuk_code_tutorial_003.

DATA : lv_str(100) VALUE 'Selam Ben Berkay Umut KILINC. SAP ABAP Developer olarak çalışıyorum. İstanbulda yaşıyorum.',
       lv_len      TYPE i,
       lv_len_2    TYPE n LENGTH 2,
       lv_counter  TYPE i.

lv_len = strlen( lv_str ).

WRITE : 'Karakter sayısı: ', lv_len LEFT-JUSTIFIED.
TRANSLATE lv_str TO UPPER CASE.
WRITE : /,'Upper Case: ', lv_str.
TRANSLATE lv_str TO LOWER CASE.
WRITE : /,'Lower Case: ', lv_str.

WHILE lv_counter <= lv_len.
  IF lv_str+lv_counter(1) EQ space.
    lv_len_2 = strlen( lv_str(lv_counter) ).
    IF lv_len_2 LE 5.
      WRITE: / lv_str(lv_counter) COLOR COL_POSITIVE, '(', lv_len_2, ')'.
    ELSEIF lv_len_2 LE 10.
      WRITE: / lv_str(lv_counter) COLOR COL_HEADING, '(', lv_len_2, ')'.
    ELSEIF lv_len_2 GT 10.
      WRITE: / lv_str(lv_counter) COLOR COL_NEGATIVE, '(', lv_len_2, ')'.
    ENDIF.

    lv_counter = lv_counter + 1.
    lv_str = lv_str+lv_counter(lv_len).
    lv_len = lv_len - lv_counter.
    lv_counter = 0.
  ENDIF.
  lv_counter = lv_counter + 1.
ENDWHILE.
