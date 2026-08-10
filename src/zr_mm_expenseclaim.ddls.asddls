@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MM : Root View Entity For Expense Claim Table'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZR_MM_EXPENSECLAIM
  as select from zmm_expens_claim

  composition [0..*] of ZR_MM_EXPENSEITEM as _ExpenseItem
  association [1..1] to ZR_MM_EMPLOYEE as _Employee
    on $projection.EmployeeId = _Employee.EmployeeId

{
    key claim_id              as ClaimId,
    employee_id               as EmployeeId,
    
    purpose                   as Purpose,
    claim_date                as ClaimDate,
    cuky_field                as CukyField,

    @Semantics.amount.currencyCode : 'CukyField'
    total_amount              as TotalAmount,

    status                    as Status,
    manager_remarks           as ManagerRemarks,
    created_by                as CreatedBy,
    created_at                as CreatedAt,
    last_changed_by           as LastChangedBy,
    last_changed_at           as LastChangedAt,
    local_last_changed_at     as LocalLastChangedAt,

   _ExpenseItem,
  _Employee,
  _Employee.EmployeeName    as EmployeeName,
    _Employee.Department      as Department

}
