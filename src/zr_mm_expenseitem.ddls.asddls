@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MM : Interface For Expense item table'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZR_MM_EXPENSEITEM
  as select from zmm_expense_item

  association to parent ZR_MM_EXPENSECLAIM as _ExpenseClaim
    on $projection.ClaimId = _ExpenseClaim.ClaimId
    association [1..1] to ZR_MM_EXPENSETYPE as _ExpenseType
    on $projection.ExpenseTypeId = _ExpenseType.ExpenseTypeId

{
    key item_id                 as ItemId,
    claim_id                    as ClaimId,
    expense_type_id             as ExpenseTypeId,
    _ExpenseType.ExpenseTypeName as ExpenseTypeName,
    expense_date                as ExpenseDate,
    cuky_field                  as CukyField,

    @Semantics.amount.currencyCode: 'CukyField'
    amount                      as Amount,

    description                 as Description,
    bill_file_name              as BillFileName,
    bill_mime_type              as BillMimeType,
    bill_content                as BillContent,
    created_by                  as CreatedBy,
    created_at                  as CreatedAt,
    last_changed_by             as LastChangedBy,
    last_changed_at             as LastChangedAt,
    local_last_changed_at       as LocalLastChangedAt,

    _ExpenseClaim,
_ExpenseType

}
