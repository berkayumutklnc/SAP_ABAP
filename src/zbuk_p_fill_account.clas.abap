CLASS zbuk_p_fill_account DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zbuk_p_fill_account IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    data: lt_account type table of zbuk_t_tutorial1.
          GET TIME STAMP FIELD DATA(zv_tsl).

          lt_account = VALUE #(
           ( client ='100'
             account_number ='00000001'
             bank_custom_id ='100001'
             bank ='Volksbank'
            city = 'Gaertringen'
            balance ='200.00 '
            currency ='EUR'
            account_category ='01'
            lastchangedat = zv_tsl )

            ( client ='100'
            account_number ='00000002'
            bank_custom_id ='200002'
            bank ='Sparkasse'
            city ='Schwetzingen'
            balance ='500.00 '
            currency ='EUR'
            account_category ='02'
            lastchangedat = zv_tsl )

            ( client ='100'
            account_number ='00000003'
            bank_custom_id ='200003'
            bank ='Commerzbank'
            city ='Nuernberg'
            balance ='150.00 '
            currency ='EUR'
            account_category ='02'
            lastchangedat = zv_tsl )
).
delete from zbuk_t_tutorial1.

insert zbuk_t_tutorial1 from table @lt_account.
out->write( sy-dbcnt ).
out->write( 'DONE!' ).

  ENDMETHOD.

ENDCLASS.
