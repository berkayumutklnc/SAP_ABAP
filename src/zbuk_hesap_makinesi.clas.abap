class ZBUK_HESAP_MAKINESI definition
  public
  final
  create public .

public section.

  methods SUM_NUMBERS
    importing
      value(IV_NUM1) type INT3 optional
      value(IV_NUM2) type INT3 optional
    exporting
      value(EV_RESULT) type INT3 .
protected section.
private section.
ENDCLASS.



CLASS ZBUK_HESAP_MAKINESI IMPLEMENTATION.


  METHOD sum_numbers.
    ev_result = iv_num1 + iv_num2.
  ENDMETHOD.
ENDCLASS.
