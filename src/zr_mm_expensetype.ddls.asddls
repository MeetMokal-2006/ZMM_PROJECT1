@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MM : Interface For Expense table'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZR_MM_EXPENSETYPE as select from zmm_expense_type
{
    key expense_type_id as ExpenseTypeId,
    expense_type_name as ExpenseTypeName,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    local_last_changed_at as LocalLastChangedAt
}
