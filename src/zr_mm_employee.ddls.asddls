@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MM : Interface For Employee Table'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZR_MM_EMPLOYEE as select from zmm_employee
{
    key employee_id as EmployeeId,
    employee_name as EmployeeName,
    department as Department,
    email as Email,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    local_last_changed_at as LocalLastChangedAt
}
