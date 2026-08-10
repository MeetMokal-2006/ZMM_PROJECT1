@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MM : Projection View For Finance Expense App'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define root view entity ZC_MM_FINANCE_EXPENSE
  provider contract transactional_query
  as projection on ZR_MM_FINANCE_EXPENSE
{
  key ClaimId,
      EmployeeId,
      EmployeeName,
Department,
      Purpose,
      ClaimDate,
      CukyField,

      @Semantics.amount.currencyCode: 'CukyField'
      TotalAmount,

      Status,
      StatusPriority,
      ManagerRemarks,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,

      _Employee,
      _ExpenseItem : redirected to composition child ZC_MM_FINANCE_EXPENSEITEM
}
