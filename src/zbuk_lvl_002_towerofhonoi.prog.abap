*&---------------------------------------------------------------------*
*& Report ZBUK_LVL_002_TOWEROFHONOI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbuk_lvl_002_towerofhonoi.

CLASS lcl_main DEFINITION DEFERRED.
DATA: gr_main TYPE REF TO lcl_main.

PARAMETERS: p_disk TYPE i.

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    METHODS: adimlama IMPORTING iv_disk1 TYPE c
                                iv_disk2 TYPE c
                                iv_disk3 TYPE c
                                iv_cubuk TYPE i.
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.
  METHOD adimlama.
    IF iv_cubuk EQ 1.
      WRITE: / 'Disk ', iv_disk1 , iv_disk3 , 'hareket etti.'.
    ELSE.
      adimlama(
        iv_disk1 = iv_disk1
        iv_disk2 = iv_disk3
        iv_disk3 = iv_disk2
        iv_cubuk = iv_cubuk - 1
      ).

      adimlama(
        iv_disk1 = iv_disk1
        iv_disk2 = iv_disk2
        iv_disk3 = iv_disk3
        iv_cubuk = iv_cubuk
      ).

      adimlama(
        iv_disk1 = iv_disk2
        iv_disk2 = iv_disk1
        iv_disk3 = iv_disk3
        iv_cubuk = iv_cubuk - 1
      ).

    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  CREATE OBJECT gr_main.

  gr_main->adimlama(
    iv_disk1 = 'A'
    iv_disk2 = 'B'
    iv_disk3 = 'C'
    iv_cubuk = p_disk
  ).
