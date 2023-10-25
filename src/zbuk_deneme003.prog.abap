*&---------------------------------------------------------------------*
*& Report ZBUK_DENEME003
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbuk_deneme003.


TYPE-POOLS : cndp.

DATA: gv_url(132),
      gv_init,
      gc_splitter   TYPE REF TO cl_gui_splitter_container,
      gc_container  TYPE REF TO cl_gui_custom_container,
      gc_container1 TYPE REF TO cl_gui_container,
      gc_container2 TYPE REF TO cl_gui_container,
      gv_pic1       TYPE REF TO cl_gui_picture,
      gv_pic2       TYPE REF TO cl_gui_picture,
      gv_okcode     TYPE sy-ucomm.

**********************************************************************
CALL SCREEN 0100.

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_0100'.
  IF gv_init IS INITIAL.
    CREATE OBJECT gc_container
      EXPORTING
        container_name = 'CC'.
    CREATE OBJECT gc_splitter
      EXPORTING
        parent  = gc_container
        rows    = 1
        columns = 2.
    CALL METHOD gc_splitter->get_container
      EXPORTING
        row       = 1
        column    = 1
      RECEIVING
        container = gc_container1.

    CALL METHOD gc_splitter->get_container
      EXPORTING
        row       = 1
        column    = 2
      RECEIVING
        container = gc_container2.


    CREATE OBJECT gv_pic1
      EXPORTING
        parent = gc_container1.


    CREATE OBJECT gv_pic2
      EXPORTING
        parent = gc_container2.

    CLEAR gv_url.
    PERFORM load_pic_from_db CHANGING gv_url.

    CALL METHOD gv_pic1->load_picture_from_url
      EXPORTING
        url = gv_url.
    CALL METHOD gv_pic2->load_picture_from_url
      EXPORTING
        url = gv_url.
    gv_init = 'X'.

    CALL METHOD cl_gui_cfw=>flush
      EXCEPTIONS
        cntl_system_error = 1
        cntl_error        = 2.
  ENDIF.
ENDMODULE.

MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN '&BACK'.
      CALL METHOD gc_container->free.
      LEAVE PROGRAM.
  ENDCASE.
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
      url      = gv_url
    EXCEPTIONS
      OTHERS   = 1.

ENDFORM.
