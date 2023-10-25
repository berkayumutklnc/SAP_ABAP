*&---------------------------------------------------------------------*
*& Report ZBUK_DENEME002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbuk_deneme002.
CLASS lcl_event_receiver DEFINITION DEFERRED.

DATA: gc_dialogbox      TYPE REF TO cl_gui_dialogbox_container,
      gc_event_receiver TYPE REF TO lcl_event_receiver,
      gv_pic            TYPE REF TO cl_gui_picture,
      gv_init.

TYPE-POOLS: cndp.
CLASS cl_gui_cfw DEFINITION LOAD.
CALL SCREEN 0100.

CLASS lcl_event_receiver DEFINITION.

  PUBLIC SECTION.
    METHODS:
      handle_close FOR EVENT close OF cl_gui_dialogbox_container
        IMPORTING sender.
  PRIVATE SECTION.

    DATA: dialogbox_status TYPE c.
ENDCLASS.

CLASS lcl_event_receiver IMPLEMENTATION.
  METHOD handle_close.
    CALL METHOD gc_dialogbox->free.
    LEAVE PROGRAM.
  ENDMETHOD.
ENDCLASS.

MODULE status_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.
  IF gv_init IS INITIAL.
    CREATE OBJECT gc_dialogbox
      EXPORTING
        width  = 540
        height = 100
        top    = 150
        left   = 150
        repid  = sy-repid
        dynnr  = sy-dynnr.

    CREATE OBJECT gc_event_receiver.

    SET HANDLER gc_event_receiver->handle_close FOR gc_dialogbox.

    CREATE OBJECT gv_pic
      EXPORTING
        parent = gc_dialogbox.

    DATA: url(255).
    CLEAR url.

    PERFORM load_pic_from_db CHANGING url.
    CALL METHOD gv_pic->load_picture_from_url
      EXPORTING
        url = url.
    gv_init = 'X'.

    CALL METHOD cl_gui_cfw=>flush
      EXCEPTIONS
        cntl_system_error = 1
        cntl_error        = 2.
  ENDIF.

ENDMODULE.

MODULE exit INPUT.
  CALL METHOD gc_dialogbox->free.
  LEAVE PROGRAM.
ENDMODULE.

FORM load_pic_from_db CHANGING url.
  DATA: query_table    LIKE w3query OCCURS 1 WITH HEADER LINE,
        html_table     LIKE w3html OCCURS 1,
        return_code    LIKE w3param-ret_code,
        content_type   LIKE w3param-cont_type,
        content_length LIKE w3param-cont_len,
        pic_data       LIKE w3mime OCCURS 0,
        pic_size       TYPE i.

  REFRESH query_table.
  query_table-name = '_OBJECT_ID'.
  query_table-value = 'ENJOYSAP_LOGO'.
  APPEND query_table.

  CALL FUNCTION 'WWW_GET_MIME_OBJECT'
    TABLES
      query_string        = query_table
      html                = html_table
      mime                = pic_data
    CHANGING
      return_code         = return_code
      content_type        = content_type
      content_length      = content_length
    EXCEPTIONS
      object_not_found    = 1
      parameter_not_found = 2
      OTHERS              = 3.

  IF sy-subrc = 0.
    pic_size = content_length.
  ENDIF.

  CALL FUNCTION 'DP_CREATE_URL'
    EXPORTING
      type     = 'image'
      subtype  = cndp_sap_tab_unknown
      size     = pic_size
      lifetime = cndp_lifetime_transaction
    TABLES
      data     = pic_data
    CHANGING
      url      = url
    EXCEPTIONS
      OTHERS   = 1.

ENDFORM.
