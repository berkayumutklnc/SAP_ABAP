*&---------------------------------------------------------------------*
*& Report ZBUK_LVL_002_ALV_EDITABLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbuk_lvl_002_alv_editable.

CLASS lcl_main DEFINITION DEFERRED.
DATA: gr_main TYPE REF TO lcl_main.
DATA: gt_data TYPE TABLE OF zbuk_t_scarr.
DATA: gc_container TYPE REF TO cl_gui_custom_container,
      gc_grid      TYPE REF TO cl_gui_alv_grid,
      gs_fcat      TYPE lvc_s_fcat,
      gt_fcat      TYPE STANDARD TABLE OF lvc_s_fcat.

TYPES: BEGIN OF gty_data_edit,
         carrid   TYPE s_carr_id,
         carrname TYPE s_carrname,
         currcode TYPE s_currcode,
         url      TYPE s_carrurl,
         fiyat    TYPE int4,
       END OF gty_data_edit.

DATA: gt_data_edit TYPE TABLE OF gty_data_edit.






CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    METHODS: get_data,
      alv,
      edit_alv,
      hotspot_alv,
      button_alv.

ENDCLASS.

CLASS lcl_main IMPLEMENTATION.
  METHOD get_data.
    SELECT * FROM zbuk_t_scarr
      INTO TABLE gt_data.
  ENDMETHOD.

  METHOD alv.
    CREATE OBJECT gc_container
      EXPORTING
        container_name              = 'CC_ALV'
      EXCEPTIONS
        cntl_error                  = 1                " CNTL_ERROR
        cntl_system_error           = 2                " CNTL_SYSTEM_ERROR
        create_error                = 3                " CREATE_ERROR
        lifetime_error              = 4                " LIFETIME_ERROR
        lifetime_dynpro_dynpro_link = 5                " LIFETIME_DYNPRO_DYNPRO_LINK
        OTHERS                      = 6.
    CREATE OBJECT gc_grid
      EXPORTING
        i_parent          = gc_container
      EXCEPTIONS
        error_cntl_create = 1                " Error when creating the control
        error_cntl_init   = 2                " Error While Initializing Control
        error_cntl_link   = 3                " Error While Linking Control
        error_dp_create   = 4                " Error While Creating DataProvider Control
        OTHERS            = 5.

    LOOP AT gt_data ASSIGNING FIELD-SYMBOL(<lfs_data>).
      IF <lfs_data>-eksta EQ 'N'.
        gr_main->edit_alv( ).
      ELSEIF <lfs_data>-eksta EQ 'Y'.
        gr_main->edit_alv( ).
      ELSEIF <lfs_data>-eksta EQ 'H'.
        gr_main->hotspot_alv( ).
      ELSEIF <lfs_data>-eksta EQ 'B'.
        gr_main->button_alv( ).
      ENDIF.
    ENDLOOP.

    gc_grid->set_table_for_first_display(
*      EXPORTING
*        i_buffer_active               =                  " Buffering Active
*        i_bypassing_buffer            =                  " Switch Off Buffer
*        i_consistency_check           =                  " Starting Consistency Check for Interface Error Recognition
*        i_structure_name              =                  " Internal Output Table Structure Name
*        is_variant                    =                  " Layout
*        i_save                        =                  " Save Layout
*        i_default                     = 'X'              " Default Display Variant
*        is_layout                     =                  " Layout
*        is_print                      =                  " Print Control
*        it_special_groups             =                  " Field Groups
*        it_toolbar_excluding          =                  " Excluded Toolbar Standard Functions
*        it_hyperlink                  =                  " Hyperlinks
*        it_alv_graphics               =                  " Table of Structure DTC_S_TC
*        it_except_qinfo               =                  " Table for Exception Quickinfo
*        ir_salv_adapter               =                  " Interface ALV Adapter
      CHANGING
        it_outtab                     =  gt_data                " Output Table
*        it_fieldcatalog               =                  " Field Catalog
*        it_sort                       =                  " Sort Criteria
*        it_filter                     =                  " Filter Criteria
      EXCEPTIONS
        invalid_parameter_combination = 1                " Wrong Parameter
        program_error                 = 2                " Program Errors
        too_many_lines                = 3                " Too many Rows in Ready for Input Grid
        OTHERS                        = 4
    ).
  ENDMETHOD.

  METHOD edit_alv.
    gs_fcat-fieldname = 'CARRID'.
    gs_fcat-scrtext_l = 'ID'.
    gs_fcat-scrtext_m = 'ID'.
    gs_fcat-scrtext_s = 'ID'.
    APPEND gs_fcat TO gt_fcat.
    CLEAR: gs_fcat.

    gs_fcat-fieldname = 'CARRNAME'.
    gs_fcat-scrtext_l = 'NAME'.
    gs_fcat-scrtext_m = 'NAME'.
    gs_fcat-scrtext_s = 'NAME'.
    APPEND gs_fcat TO gt_fcat.
    CLEAR: gs_fcat.

    gs_fcat-fieldname = 'CURRCODE'.
    gs_fcat-scrtext_l = 'KOD'.
    gs_fcat-scrtext_m = 'KOD'.
    gs_fcat-scrtext_s = 'KOD'.
    APPEND gs_fcat TO gt_fcat.
    CLEAR: gs_fcat.

    gs_fcat-fieldname = 'URL'.
    gs_fcat-scrtext_l = 'URL'.
    gs_fcat-scrtext_m = 'URL'.
    gs_fcat-scrtext_s = 'URL'.
    APPEND gs_fcat TO gt_fcat.
    CLEAR: gs_fcat.

    gs_fcat-fieldname = 'FIYAT'.
    gs_fcat-scrtext_l = 'FIYAT'.
    gs_fcat-scrtext_m = 'FIYAT'.
    gs_fcat-scrtext_s = 'FIYAT'.
    gs_fcat-edit = abap_true.
    APPEND gs_fcat TO gt_fcat.
    CLEAR: gs_fcat.

    MOVE-CORRESPONDING gt_data TO gt_data_edit .

    gc_grid->set_table_for_first_display(
         CHANGING
           it_outtab                     =  gt_data_edit
           it_fieldcatalog               =  gt_fcat
         EXCEPTIONS
           invalid_parameter_combination = 1                " Wrong Parameter
           program_error                 = 2                " Program Errors
           too_many_lines                = 3                " Too many Rows in Ready for Input Grid
           OTHERS                        = 4
       ).
    CALL METHOD gc_grid->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified
      EXCEPTIONS
        error      = 1                " Error
        OTHERS     = 2.
  ENDMETHOD.

  METHOD button_alv.

  ENDMETHOD.

  METHOD hotspot_alv.

  ENDMETHOD.
ENDCLASS.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN '&BACK' OR '&EXIT' OR '&ESC'.
      LEAVE PROGRAM.
    WHEN '&KYT'.
      MESSAGE 'kayıt atıldı ama nereye :D' TYPE 'I'.
  ENDCASE.

ENDMODULE.


START-OF-SELECTION.
  CREATE OBJECT gr_main.

  gr_main->get_data( ).
  gr_main->alv( ).

  CALL SCREEN 100.
