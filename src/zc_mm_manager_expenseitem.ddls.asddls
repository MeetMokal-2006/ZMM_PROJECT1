@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MM : Projection View For Manager Expense Item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define view entity ZC_MM_MANAGER_EXPENSEITEM
  as projection on ZR_MM_MANAGER_EXPENSEITEM
{
    key ItemId,
        ClaimId,
        ExpenseTypeId,
        ExpenseTypeName,
        ExpenseDate,
        CukyField,

        @Semantics.amount.currencyCode: 'CukyField'
        Amount,

        Description,
        BillFileName,
        BillMimeType,
        BillContent,
        CreatedBy,
        CreatedAt,
        LastChangedBy,
        LastChangedAt,
        LocalLastChangedAt,

        _ExpenseClaim : redirected to parent ZC_MM_MANAGER_EXPENSE,
        _ExpenseType
}
