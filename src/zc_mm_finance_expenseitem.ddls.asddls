@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MM : Projection View For Finance Expense Item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define view entity ZC_MM_FINANCE_EXPENSEITEM
  as projection on ZR_MM_FINANCE_EXPENSEITEM
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

        _ExpenseClaim : redirected to parent ZC_MM_FINANCE_EXPENSE,
        _ExpenseType
}
