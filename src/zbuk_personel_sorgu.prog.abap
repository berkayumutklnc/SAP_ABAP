*&---------------------------------------------------------------------*
*& Report ZBUK_PERSONEL_SORGU
*&---------------------------------------------------------------------*
*& personel bilgilerinin tutulduğu bir program olması gerekmektedir.
*& ALV şeklinde gösterilecek fakat personel alvsinde çift tıklanıldığında dialog screen açılmalı ve orada bilgiler görüntülenmelidir.
*& personel bilgilerinin tutulduğu tablo : ZBUK_T_PERSONEL
*& şirket bilgilerinin tutulduğu tablo :
*& personel aile bilgilerinin tutulduğu tablo :
*& şirket içerisindeki takım bilgilerinin tutulduğu tablo:
*&
*&
*&
*&---------------------------------------------------------------------*
REPORT zbuk_personel_sorgu.


INCLUDE ZBUK_PERSONEL_SORGU_top.
INCLUDE ZBUK_PERSONEL_SORGU_cls.
INCLUDE ZBUK_PERSONEL_SORGU_frm.
INCLUDE ZBUK_PERSONEL_SORGU_mdl.

INITIALIZATION.

AT SELECTION-SCREEN OUTPUT.

START-OF-SELECTION.

END-OF-SELECTION.
