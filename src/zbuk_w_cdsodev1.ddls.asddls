@AbapCatalog.sqlViewName: 'ZBUK_W_CDS1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Egitim Odevi 1'
define view zbuk_w_cdsodev1
with parameters p_to_curr : abap.cuky(5)
 as select from vbrp
inner join vbrk on vbrp.vbeln = vbrk.vbeln
inner join mara on vbrp.matnr = mara.matnr
left outer join vbak on vbak.vbeln = vbrp.aubel
left outer join kna1 on kna1.kunnr = vbak.kunnr
left outer join makt on vbrp.matnr = makt.matnr
                    and makt.spras = $session.system_language

{
        vbrp.vbeln,
        vbrp.posnr,
        vbrp.aubel,
        vbrp.aupos,
        vbak.kunnr,
        left(vbak.kunnr, 3) as left_kunnr,
        count( distinct mara.matnr ) as matnr_lenght,
        kna1.name1,
        kna1.name2,
        concat_with_space(  kna1.name1, kna1.name2, 1 ) as kunnrAd,
        currency_conversion( amount => vbrp.netwr,
                             source_currency => vbrk.waerk,
                             target_currency => :p_to_curr,
                             exchange_rate_date => vbrk.fkdat) as conver_netwr,
        case 
        when vbrk.fkart = 'FAS' then 'Peşinat Talebi İptali'
        when vbrk.fkart = 'FAZ' then 'Peşinat Talebi'
        else 'Fatura' end as FaturalamaTuru,
        vbrk.fkdat
}
group by
    vbrp.vbeln,
    vbrp.posnr,
    vbrp.aubel,
    vbrp.aupos,
    vbak.kunnr,
    kna1.name1,
    kna1.name2,
    vbrk.fkart,
    vbrk.fkdat,
    vbrp.netwr,
    vbrk.waerk
