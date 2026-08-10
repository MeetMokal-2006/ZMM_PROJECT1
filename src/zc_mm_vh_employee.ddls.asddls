@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS

define view entity ZC_MM_VH_EMPLOYEE
  as select from ZR_MM_EMPLOYEE
{
    key EmployeeId,
        EmployeeName,
        Department
}
