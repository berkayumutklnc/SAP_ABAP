*&---------------------------------------------------------------------*
*& Include          ZBUK_LVL_001_TOP
*&---------------------------------------------------------------------*

TABLES: scarr, sflight.

CLASS lcl_main DEFINITION DEFERRED.

DATA: gr_main TYPE REF TO lcl_main.

TYPES: BEGIN OF gty_scarr,
         carrid   TYPE scarr-carrid,
         carrname TYPE scarr-carrname,
         curcode  TYPE scarr-currcode,
         url      TYPE scarr-url,
       END OF gty_scarr,
       BEGIN OF gty_sflight,
         carrid    TYPE sflight-carrid,
         connid    TYPE sflight-connid,
         fldate    TYPE sflight-fldate,
         price     TYPE sflight-price,
         currency  TYPE sflight-currency,
         planetype TYPE sflight-planetype,
         seatsmax  TYPE sflight-seatsmax,
         seatsocc  TYPE sflight-seatsocc,
       END OF gty_sflight.

DATA: gt_scarr   TYPE TABLE OF gty_scarr,
      gt_sflight TYPE TABLE OF gty_sflight,
      gs_sflight TYPE gty_sflight.

DATA: gc_container TYPE REF TO cl_gui_custom_container,
      gc_grid      TYPE REF TO cl_gui_alv_grid,
      gs_fcat      TYPE lvc_s_fcat,
      gt_fcat      TYPE STANDARD TABLE OF lvc_s_fcat.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS : p_carrid TYPE scarr-carrid.
SELECTION-SCREEN END OF BLOCK b1.
