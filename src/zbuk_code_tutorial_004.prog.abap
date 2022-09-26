*---------------------------------------------------------------------*
* Report         :  ZBUK_CODE_TUTORIAL_004
* Developer      :  Berkay Umut KILINÇ
* Consultant     :  -
* Date             :  26.09.2022
* Program Type   :  Report/Program
* Tcode          :  -
* TS Number      :  -
* Program Purpose:  Circle Area And Perimeter Calculator Program
*                   ----
*----------------------------------------------------------------------*
* MODIFICATION LOG:
*----------------------------------------------------------------------*
* CORR NO         DATE       PROGRAMMER    |  CHANGES DESCRIPTION
*----------------------------------------------------------------------*
*             26.09.2022  Berkay Umut KILINÇ    Initial Version
*----------------------------------------------------------------------*

REPORT zbuk_code_tutorial_004.

PARAMETERS : p_ycap TYPE i.

CONSTANTS: gc_pi    TYPE f VALUE '3.14'.

DATA: gv_cbr_cevre  TYPE p DECIMALS 2,
      gv_cbr_alan   TYPE p DECIMALS 2.

WRITE : 'Çember Çevresinin ve Alanını Hesaplayan Program'. ULINE.
SKIP 3.

gv_cbr_cevre = 2     * gc_pi  * p_ycap.
gv_cbr_alan  = gc_pi * p_ycap * p_ycap.

WRITE :    'Girilen Yarıçap Değeri: ', p_ycap,
        /, 'Çemberin Çevresi : ' ,     gv_cbr_cevre,
        /, 'Çemberin Alanı : ',        gv_cbr_alan.
ULINE.
SKIP 3.
WRITE: 'Program ', sy-datum, ' tarihinde ',sy-uzeit, 'saatinde',
sy-uname, 'tarafından çalıştırılmıştır.'.
