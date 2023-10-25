*&---------------------------------------------------------------------*
*& Report ZBUK_DENEME004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbuk_deneme004.

*DATA: go_main   TYPE REF TO zbuk_hesap_makinesi,
*      gv_num1   TYPE int3 VALUE '123',
*      gv_num2   TYPE int3 VALUE '456',
*      gv_result TYPE int3.
*
*START-OF-SELECTION.
*  CREATE OBJECT go_main.
*
*  go_main->sum_numbers(
*    EXPORTING
*      iv_num1   = gv_num1
*      iv_num2   =  gv_num2
*    IMPORTING
*      ev_result = gv_result
*  ).
*
**  WRITE: 'toplam',  gv_result.

**********************************************************************

SELECT * FROM zbuk_wiew001 INTO TABLE @DATA(lt_wiew).

DATA: go_alv  TYPE REF TO cl_salv_table,
      lr_func TYPE REF TO cl_salv_functions_list.

TRY.
    cl_salv_table=>factory(
*    EXPORTING
*      list_display   = if_salv_c_bool_sap=>false " ALV Displayed in List Mode
*      r_container    =                           " Abstract Container for GUI Controls
*      container_name =
      IMPORTING
        r_salv_table   = go_alv                          " Basis Class Simple ALV Tables
      CHANGING
        t_table        = lt_wiew[]
    ).
  CATCH cx_salv_msg.
ENDTRY.
lr_func = go_alv->get_functions( ).
lr_func->set_all('X').

IF go_alv IS BOUND.
  go_alv->display( ).
ENDIF.
