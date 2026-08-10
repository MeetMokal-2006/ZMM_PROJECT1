CLASS lhc_ExpenseClaim DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ExpenseClaim RESULT result.

    METHODS ReleasePayment FOR MODIFY
      IMPORTING keys FOR ACTION ExpenseClaim~ReleasePayment.

ENDCLASS.

CLASS lhc_ExpenseClaim IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

METHOD ReleasePayment.

  MODIFY ENTITIES OF zr_mm_finance_expense IN LOCAL MODE
    ENTITY ExpenseClaim
      UPDATE
      FIELDS ( Status ManagerRemarks )
      WITH VALUE #(

        FOR key IN keys
        (

          %tky           = key-%tky
          Status         = 'P'
          ManagerRemarks = 'Payment released by Finance Manager.'

        )

      ).

ENDMETHOD.

ENDCLASS.
