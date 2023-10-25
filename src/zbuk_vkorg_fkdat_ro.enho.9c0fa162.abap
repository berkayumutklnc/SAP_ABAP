"Name: \PR:SAPMV45A\FO:USEREXIT_FIELD_MODIFICATION\SE:END\EI
ENHANCEMENT 0 ZBUK_VKORG_FKDAT_RO.
  " D-BERKAY

**  LOOP AT SCREEN.
**    IF  vbak-vkorg EQ '1000'.
**      CASE screen-name.
**        WHEN 'VBKD-PRSDT'.
**          screen-input = 0.
**      ENDCASE.
**      MODIFY SCREEN.
**    ENDIF.
**  ENDLOOP.

  " D-BERKAY
ENDENHANCEMENT.
