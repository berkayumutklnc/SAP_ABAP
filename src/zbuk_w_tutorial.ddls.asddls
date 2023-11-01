@AbapCatalog.sqlViewName: 'ZBUK_CDS_TUT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Deneme Wiew'
define view zbuk_w_tutorial as select from mara
left outer join  makt on mara.matnr = makt.matnr
left outer join mard on mara.matnr = mard.matnr 
    
{
    mara.matnr as MalzemeNumarasi,
    mard.werks as UretimYeri,
    mard.lgort as DepoYeri,
    makt.maktx as MalzemeTanimi,
    mara.ersda as MalzemeYaratmaTarihi,
    mara.ernam as MalzemeYaratan,
    mara.mtart as MalzemeTuru,
    mara.matkl as MalzemeGrubu
    
}
