@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MM : Projection View for Expense claim'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_MM_EXPENSECLAIM
  provider contract transactional_query as projection on ZR_MM_EXPENSECLAIM
{
    key ClaimId,
    EmployeeId,
    Purpose,
    ClaimDate,
    CukyField,
    @Semantics.amount.currencyCode: 'cukyfield'
    TotalAmount,
    Status,
    ManagerRemarks,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Employee,
    _ExpenseItem : redirected to composition child ZC_MM_EXPENSEITEM
}
