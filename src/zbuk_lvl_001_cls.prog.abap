*&---------------------------------------------------------------------*
*& Include          ZBUK_LVL_001_CLS
*&---------------------------------------------------------------------*

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    METHODS: get_data IMPORTING iv_carrid TYPE scarr-carrid,
      first_alv,
      handle_hotspot_click FOR EVENT hotspot_click OF cl_gui_alv_grid
        IMPORTING e_row_id e_column_id es_row_no.
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.
  METHOD get_data.
    IF p_carrid IS NOT INITIAL .
      SELECT
        carrid
        carrname
        currcode
        url
      FROM scarr INTO TABLE gt_scarr
      WHERE carrid EQ iv_carrid.
    ELSE.
      SELECT
        carrid
        carrname
        currcode
        url
      FROM scarr INTO TABLE gt_scarr.
    ENDIF.

  ENDMETHOD.

  METHOD first_alv.
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


    CLEAR gs_fcat.
    REFRESH gt_fcat.

    DATA: lv_col TYPE i VALUE 0.

    lv_col                 = 1 + lv_col.
    gs_fcat-col_pos   = lv_col.
    gs_fcat-fieldname = 'CARRID'.
    gs_fcat-tabname   = 'GT_SCARR'.
    gs_fcat-reptext   = 'AIRPLANE CODE'.
    gs_fcat-col_opt   = 'X'.
    gs_fcat-emphasize = 'X'.
    gs_fcat-key       = 'X'.
    gs_fcat-hotspot   = 'X'.
    APPEND gs_fcat TO gt_fcat.
    CLEAR gs_fcat.

    lv_col                 = 1 + lv_col.
    gs_fcat-col_pos   = lv_col.
    gs_fcat-fieldname = 'CARRNAME'.
    gs_fcat-tabname   = 'GT_SCARR'.
    gs_fcat-reptext   = 'AIRPLANE NAME'.
    gs_fcat-col_opt   = 'X'.
    APPEND gs_fcat TO gt_fcat.
    CLEAR gs_fcat.

    lv_col                 = 1 + lv_col.
    gs_fcat-col_pos   = lv_col.
    gs_fcat-fieldname = 'CURRCODE'.
    gs_fcat-tabname   = 'GT_SCARR'.
    gs_fcat-reptext   = 'AIRPLANE CURRENCY'.
    gs_fcat-col_opt   = 'X'.
    APPEND gs_fcat TO gt_fcat.
    CLEAR gs_fcat.

    lv_col                 = 1 + lv_col.
    gs_fcat-col_pos   = lv_col.
    gs_fcat-fieldname = 'URL'.
    gs_fcat-tabname   = 'GT_SCARR'.
    gs_fcat-reptext   = 'AIRPLANE URL'.
    gs_fcat-col_opt   = 'X'.
    APPEND gs_fcat TO gt_fcat.
    CLEAR gs_fcat.

    SET HANDLER gr_main->handle_hotspot_click FOR gc_grid.
    CALL METHOD gc_grid->set_table_for_first_display
      CHANGING
        it_outtab                     = gt_scarr
        it_fieldcatalog               = gt_fcat
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4.
  ENDMETHOD.

  METHOD handle_hotspot_click.
    READ TABLE gt_scarr ASSIGNING FIELD-SYMBOL(<lfs_scarr>) INDEX e_row_id-index.
    IF sy-subrc IS INITIAL .
      SELECT
        carrid
        connid
        fldate
        price
        currency
        planetype
        seatsmax
        seatsocc
        FROM sflight
        INTO TABLE gt_sflight
        WHERE carrid EQ <lfs_scarr>-carrid.

      READ TABLE gt_sflight INTO gs_sflight INDEX 1.
      IF sy-subrc IS INITIAL .
        CALL SCREEN '0101' STARTING AT 10 10
                          ENDING AT 100 25.
      ELSE.
        MESSAGE 'DETAY RAPORU BOS VERI YOK!!!' TYPE 'I'.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
