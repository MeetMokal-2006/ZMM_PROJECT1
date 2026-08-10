@AbapCatalog.sqlViewName: 'ZC_MM_VH_EXPENS'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MM : Value Help For Expensetype Id'
@Metadata.ignorePropagatedAnnotations: true
define view ZC_MM_VH_Expensetype as select from ZR_MM_EXPENSETYPE
{
    key ExpenseTypeId,
    ExpenseTypeName

}
