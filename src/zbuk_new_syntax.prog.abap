*&---------------------------------------------------------------------*
*& Report ZBUK_NEW_SYNTAX
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbuk_new_syntax.

*DATA: lv_text TYPE string.
*lv_text = 'OLD'.
*
*DATA(lv_text) = 'NEW'.
**********************************************************************
*DATA:ls_scarr TYPE scarr.
*DATA: lt_scarr TYPE TABLE OF scarr.
*LOOP AT  lt_scarr INTO ls_scarr.
*
*ENDLOOP.
*"new
*
*LOOP AT  lt_scarr INTO DATA(ls_scarr2).
*
*ENDLOOP.
**********************************************************************

*TYPES lt_itab TYPE TABLE OF i WITH EMPTY KEY.
*
*DATA(itab) = VALUE lt_itab( ( 1 ) ( 2 ) ( 3 ) ).
*BREAK-POINT.
**********************************************************************

*
*DATA(lv_carrid) = 'AA'.
*
*SELECT SINGLE carrid,
*              carrname,
*              currcode,
*              url
*FROM scarr INTO @DATA(ls_scarr)
*  WHERE carrid EQ @lv_carrid.
*
*DATA(lv_carrid) = 'AA'.
*
*SELECT carrid,
*       carrname,
*       currcode,
*       url
*FROM scarr INTO TABLE @DATA(lt_scarr)
*  WHERE carrid EQ @lv_carrid.

**********************************************************************

*
*DATA(lv_carrid) = 'AA'.
*
*SELECT carrid,
*       carrname,
*       currcode,
*       url
*FROM scarr INTO TABLE @DATA(lt_scarr)
*  WHERE carrid EQ @lv_carrid.
*
*LOOP AT lt_scarr ASSIGNING FIELD-SYMBOL(<lfs_scarr>).
*
*ENDLOOP.
*
*LOOP AT lt_scarr INTO DATA(ls_scarr).
*
*ENDLOOP.
*
*READ TABLE lt_scarr ASSIGNING FIELD-SYMBOL(<lfs_scarr2>) INDEX 1.
*
*READ TABLE lt_scarr INTO DATA(ls_scarr2) INDEX 1.

**********************************************************************

*DATA(lv_carrid) = 'AA'.
*
*SELECT carrid,
*       carrname,
*       currcode,
*       url
*FROM scarr INTO TABLE @DATA(lt_scarr)
*  WHERE carrid EQ @lv_carrid.
*
*"old
*READ TABLE lt_scarr INTO DATA(ls_scarr) WITH KEY carrid = lv_carrid.
*IF sy-subrc IS INITIAL .
*  WRITE: ls_scarr.
*ENDIF.
*"new
*
*DATA(ls_scarr) = lt_scarr[ carrid = lv_carrid  ].
*WRITE ls_scarr.
**********************************************************************

DATA(lv_carrid) = 'AA'.

SELECT carrid,
       carrname,
       currcode,
       url
FROM scarr INTO TABLE @DATA(lt_scarr)
  WHERE carrid EQ @lv_carrid.

READ TABLE lt_scarr INTO DATA(ls_scarr) WITH KEY carrid = lv_carrid.
IF  sy-subrc IS INITIAL .
  DATA(lv_url) = ls_scarr-url.
ENDIF.

WRITE : lv_url.

DATA(lv_url2) = lt_scarr[ carrid = lv_carrid ]-url.
WRITE lv_url2.
