class ZBUK_LE_SHP_DELIVERY_PROC definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_LE_SHP_DELIVERY_PROC .
protected section.
private section.
ENDCLASS.



CLASS ZBUK_LE_SHP_DELIVERY_PROC IMPLEMENTATION.


  METHOD if_ex_le_shp_delivery_proc~save_and_publish_document.
    BREAK: d-berkay.
  ENDMETHOD.
ENDCLASS.
