@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MM : Projection View For Employee Expense Item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define view entity ZC_MM_EMPLOYEE_EXPENSEITEM
  as projection on ZR_MM_EXPENSEITEM
{
    key ItemId,
        ClaimId,
        @Consumption.valueHelpDefinition: [
  {
    entity: {
      name: 'ZC_MM_VH_EXPENSETYPE',
      element: 'ExpenseTypeId'
    }
  }
]
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

        _ExpenseClaim : redirected to parent ZC_MM_EMPLOYEE_EXPENSE,
        _ExpenseType
}
