*&---------------------------------------------------------------------*
*& Include          ZBUK_BELGE_CLS
*&---------------------------------------------------------------------*

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    METHODS: get_data IMPORTING iv_ebeln TYPE vbak-vbeln,
      sscreen_name,
      sscreen_control,
      alv,
      mail,
      excel_parameters IMPORTING iv_file TYPE string,
      excel_download IMPORTING iv_file TYPE string,
      form.
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.

  METHOD sscreen_name.
    tab1 = 'ALV SCREEN'.
    tab2 = 'MAIL SCREEN'.
    tab3 = 'EXCEL SCREEN'.
    tab4 = 'FORM SCREEN'.

    selscrtab-prog      = sy-repid.
    selscrtab-dynnr     = 100.
    selscrtab-activetab = 'TAB1'.
  ENDMETHOD.

  METHOD sscreen_control.
    CASE sy-ucomm.
      WHEN 'UCOMM1'.
        selscrtab-dynnr     = 100.
        selscrtab-activetab = 'TAB1'.
      WHEN 'UCOMM2'.
        selscrtab-dynnr     = 200.
        selscrtab-activetab = 'TAB2'.
      WHEN 'UCOMM3'.
        selscrtab-dynnr     = 300.
        selscrtab-activetab = 'TAB3'.
      WHEN 'UCOMM4'.
        selscrtab-dynnr     = 400.
        selscrtab-activetab = 'TAB4'.
    ENDCASE.

  ENDMETHOD.

  METHOD get_data.
    SELECT
     eko~ebeln
     eko~bukrs
     eko~aedat
     eko~lifnr
     epo~matnr
     epo~txz01
    FROM ekko AS eko
     INNER JOIN ekpo AS epo ON epo~ebeln = eko~ebeln
     INTO TABLE gt_all
     WHERE eko~ebeln EQ iv_ebeln.
  ENDMETHOD.

  METHOD alv.

    DATA: lo_func  TYPE REF TO cl_salv_functions_list,
          lo_colms TYPE REF TO cl_salv_columns,
          lo_disp  TYPE REF TO cl_salv_display_settings.

    TRY.
        CALL METHOD cl_salv_table=>factory
          IMPORTING
            r_salv_table = go_alv
          CHANGING
            t_table      = gt_all.
      CATCH cx_salv_msg INTO gx_salv_msg.
        MESSAGE gx_salv_msg TYPE 'I'.
    ENDTRY.

    lo_func = go_alv->get_functions( ).
    lo_func->set_all( abap_true ).
    lo_colms = go_alv->get_columns( ).
    lo_colms->set_optimize( abap_true ).
    lo_disp = go_alv->get_display_settings( ).
    lo_disp->set_striped_pattern( abap_true ).

    go_alv->display( ).
  ENDMETHOD.

  METHOD mail.
    CONSTANTS:gc_tab  TYPE c VALUE cl_bcs_convert=>gc_tab,
              gc_crlf TYPE c VALUE cl_bcs_convert=>gc_crlf.

    DATA:lt_mail           TYPE TABLE OF solisti1,
         ls_mail           TYPE solisti1,
         lr_send_request   TYPE REF TO cl_bcs,
         lr_document       TYPE REF TO cl_document_bcs,
         lv_i_subject      TYPE so_obj_des,
         lr_recepient      TYPE REF TO if_recipient_bcs,
         lv_sent_to_all    TYPE os_boolean,
         lr_sender         TYPE REF TO if_sender_bcs,
         lv_string         TYPE string,
         lv_binary_content TYPE solix_tab,
         lv_size           TYPE so_obj_len.

    ls_mail = '<p style = "text-align : center;">SATICI URUN BELGESI'.
    APPEND ls_mail TO lt_mail.
    CLEAR ls_mail.
    ls_mail = '<br/>'.
    APPEND ls_mail TO lt_mail.
    CLEAR ls_mail.
    ls_mail = '<HTML><BODY>'.
    APPEND ls_mail TO lt_mail.
    CLEAR ls_mail.

    ls_mail = '<TABLE border = "1"bg color = "black"><TR>'.
    APPEND ls_mail TO lt_mail.
    CLEAR ls_mail.
    ls_mail = '<TH>ALAN1</TH>'.
    APPEND ls_mail TO lt_mail.
    CLEAR ls_mail.
    ls_mail = '<TH>ALAN 2</TH>'.
    APPEND ls_mail TO lt_mail.
    CLEAR ls_mail.
    ls_mail = '<TH>ALAN3</TH>'.
    APPEND ls_mail TO lt_mail.
    CLEAR ls_mail.
    ls_mail = '<TH>ALAN4</TH>'.
    APPEND ls_mail TO lt_mail.
    CLEAR ls_mail.
    ls_mail = '<TH>ALAN5</TH>'.
    APPEND ls_mail TO lt_mail.
    CLEAR ls_mail.
    ls_mail = '<TH>ALAN6</TH>'.
    APPEND ls_mail TO lt_mail.
    CLEAR ls_mail.

    LOOP AT gt_all INTO gs_all.
      ls_mail = '<TR>'.
      APPEND ls_mail TO lt_mail.
      CLEAR ls_mail.
      ls_mail = '<TD>'.
      APPEND ls_mail TO lt_mail.
      CLEAR ls_mail.
      ls_mail = gs_all-ebeln.
      APPEND ls_mail TO lt_mail.
      CLEAR ls_mail.
      ls_mail = '<TD>'.
      APPEND ls_mail TO lt_mail.
      CLEAR ls_mail.
      ls_mail = gs_all-bukrs.
      APPEND ls_mail TO lt_mail.
      CLEAR ls_mail.
      ls_mail = '<TD>'.
      APPEND ls_mail TO lt_mail.
      CLEAR ls_mail.
      ls_mail = gs_all-eadat.
      APPEND ls_mail TO lt_mail.
      CLEAR ls_mail.
      ls_mail = '<TD>'.
      APPEND ls_mail TO lt_mail.
      CLEAR ls_mail.
      ls_mail = gs_all-lifnr.
      APPEND ls_mail TO lt_mail.
      CLEAR ls_mail.
      ls_mail = '<TD>'.
      APPEND ls_mail TO lt_mail.
      CLEAR ls_mail.
      ls_mail = gs_all-matnr.
      APPEND ls_mail TO lt_mail.
      CLEAR ls_mail.
      ls_mail = '<TD>'.
      APPEND ls_mail TO lt_mail.
      CLEAR ls_mail.
      ls_mail = gs_all-txz01.
      APPEND ls_mail TO lt_mail.
      CLEAR ls_mail.
      ls_mail = '<TD>'.
      APPEND ls_mail TO lt_mail.
      CLEAR ls_mail.
      ls_mail = '</TD>'.
      CONCATENATE lv_string
      gs_all-ebeln gc_tab
      gs_all-bukrs gc_tab
      gs_all-eadat gc_tab
      gs_all-lifnr gc_tab
      gs_all-matnr gc_tab
      gs_all-txz01 gc_crlf
      INTO lv_string.
    ENDLOOP.

    cl_bcs_convert=>string_to_solix(
EXPORTING
 iv_string = lv_string
IMPORTING
et_solix = lv_binary_content
ev_size = lv_size ).

    lv_i_subject = 'Satıcı Şipariş Çıktısı'.
    lr_document = cl_document_bcs=>create_document( i_type = 'HTM'
    i_text = lt_mail
    i_subject = lv_i_subject ).
    lr_send_request = cl_bcs=>create_persistent( ).
    lr_send_request->set_document( i_document = lr_document ).
    lr_recepient = cl_cam_address_bcs=>create_internet_address( i_address_string ='genel@gmail' ).

    lr_send_request->add_recipient(
    EXPORTING
       i_recipient = lr_recepient
    i_express = abap_true ).

    lr_sender = cl_cam_address_bcs=>create_internet_address( 'berkayumut.kilinc@bs.nttdata.com' ).
    lr_send_request->set_sender( i_sender = lr_sender ).
    lv_sent_to_all = lr_send_request->send( i_with_error_screen = abap_true ).
    IF lv_sent_to_all EQ abap_true.
      COMMIT WORK AND WAIT.
    ENDIF.
  ENDMETHOD.

  METHOD excel_parameters.

  ENDMETHOD.

  METHOD excel_download.
        DATA(lv_file) = iv_file.
    CALL METHOD cl_gui_frontend_services=>directory_browse
      CHANGING
        selected_folder      = lv_file              " Folder Selected By User
      EXCEPTIONS
        cntl_error           = 1                " Control error
        error_no_gui         = 2                " No GUI available
        not_supported_by_gui = 3                " GUI does not support this
        OTHERS               = 4.

    gs_header-line = 'alan1'.
    APPEND gs_header TO gt_header.

    gs_header-line = 'alan2'.
    APPEND gs_header TO gt_header.

    gs_header-line = 'alan3'.
    APPEND gs_header TO gt_header.

    gs_header-line = 'alan4'.
    APPEND gs_header TO gt_header.

    gs_header-line = 'alan5'.
    APPEND gs_header TO gt_header.

    gs_header-line = 'alan6'.
    APPEND gs_header TO gt_header.



    CONCATENATE lv_file '\' sy-datum '-' sy-uzeit '.xls' INTO gv_filename.

    CALL FUNCTION 'GUI_DOWNLOAD'
      EXPORTING
        filename                = gv_filename
        filetype                = 'ASC'
        write_field_separator   = 'X'
      TABLES
        data_tab                = gt_all
        fieldnames              = gt_header
      EXCEPTIONS
        file_write_error        = 1
        no_batch                = 2
        gui_refuse_filetransfer = 3
        invalid_type            = 4
        no_authority            = 5
        unknown_error           = 6
        header_not_allowed      = 7
        separator_not_allowed   = 8
        filesize_not_allowed    = 9
        header_too_long         = 10
        dp_error_create         = 11
        dp_error_send           = 12
        dp_error_write          = 13
        unknown_dp_error        = 14
        access_denied           = 15
        dp_out_of_memory        = 16
        disk_full               = 17
        dp_timeout              = 18
        file_not_found          = 19
        dataprovider_exception  = 20
        control_flush_error     = 21
        OTHERS                  = 22.


  ENDMETHOD.

  METHOD form.
    DATA : cp_outparam TYPE          sfpoutputparams,
           ip_funcname TYPE          funcname.
    CALL FUNCTION 'FP_JOB_OPEN'
      CHANGING
        ie_outputparams = cp_outparam.
    cp_outparam-nodialog = ''.
    cp_outparam-preview = 'X'.
    cp_outparam-device = 'LP01'.

    CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
      EXPORTING
        i_name     = 'ZBUK_AF_BELGE'
      IMPORTING
        e_funcname = ip_funcname.

    CALL FUNCTION ip_funcname
      EXPORTING
        gt_all         = gt_all
        gv_barcode     = p_barc
      EXCEPTIONS
        usage_error    = 1
        system_error   = 2
        internal_error = 3
        OTHERS         = 4.

    CALL FUNCTION 'FP_JOB_CLOSE'
      EXCEPTIONS
        usage_error    = 1
        system_error   = 2
        internal_error = 3
        OTHERS         = 4.


  ENDMETHOD.

ENDCLASS.
