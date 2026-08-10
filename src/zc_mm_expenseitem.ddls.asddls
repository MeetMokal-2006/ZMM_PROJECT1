@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MM : Projection View for Expense Item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_MM_EXPENSEITEM
  as projection on ZR_MM_EXPENSEITEM
{
    key ItemId,
    ClaimId,
    ExpenseTypeId,
    ExpenseDate,
    CukyField,
    @Semantics.amount.currencyCode: 'cukyfield'
    Amount,
    Description,
    BillFileName,

@Semantics.mimeType: true
BillMimeType,

@Semantics.largeObject: {
    mimeType: 'BillMimeType',
    fileName: 'BillFileName'
}
BillContent,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _ExpenseClaim : redirected to parent ZC_MM_EXPENSECLAIM,
    _ExpenseType
}
