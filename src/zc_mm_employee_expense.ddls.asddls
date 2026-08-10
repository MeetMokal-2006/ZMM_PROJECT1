@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MM : Projection View For Employee Expense App'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define root view entity ZC_MM_EMPLOYEE_EXPENSE
  provider contract transactional_query
  as projection on ZR_MM_EXPENSECLAIM
{
  key ClaimId,
  @Consumption.valueHelpDefinition: [
{
  entity: {
    name: 'ZC_MM_VH_EMPLOYEE',
    element: 'EmployeeId'
  }
}
]

      EmployeeId,
      EmployeeName,
Department,
      Purpose,
      ClaimDate,
      CukyField,

      @Semantics.amount.currencyCode: 'CukyField'
      TotalAmount,

      Status,
      ManagerRemarks,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,

      _Employee,
      _ExpenseItem : redirected to composition child ZC_MM_EMPLOYEE_EXPENSEITEM
}
