CLASS lhc_ExpenseClaim DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ExpenseClaim RESULT result.


    METHODS Approve FOR MODIFY
      IMPORTING keys FOR ACTION ExpenseClaim~Approve.

    METHODS Reject FOR MODIFY
      IMPORTING keys FOR ACTION ExpenseClaim~Reject.

ENDCLASS.

CLASS lhc_ExpenseClaim IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.



METHOD Approve.

  READ ENTITIES OF zr_mm_manager_expense IN LOCAL MODE
    ENTITY ExpenseClaim
    FIELDS ( Status ManagerRemarks )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_claims).

  LOOP AT lt_claims ASSIGNING FIELD-SYMBOL(<claim>).

    "==============================================================
    " Claim is already Rejected
    "==============================================================
    IF <claim>-Status = 'R'.

      APPEND VALUE #(
        %tky = <claim>-%tky
      ) TO failed-expenseclaim.

      APPEND VALUE #(
        %tky = <claim>-%tky
        %msg = new_message(
                 id       = 'SY'
                 number   = '002'
                 severity = if_abap_behv_message=>severity-error
                 v1       = 'This Claim is already Rejected'
               )
      ) TO reported-expenseclaim.

    "==============================================================
    " Claim is already Approved
    "==============================================================
    ELSEIF <claim>-Status = 'A'.

      APPEND VALUE #(
        %tky = <claim>-%tky
      ) TO failed-expenseclaim.

      APPEND VALUE #(
        %tky = <claim>-%tky
        %msg = new_message(
                 id       = 'SY'
                 number   = '002'
                 severity = if_abap_behv_message=>severity-error
                 v1       = 'This Claim is already Approved'
               )
      ) TO reported-expenseclaim.

    "==============================================================
    " Claim is New → Approve
    "==============================================================
    ELSEIF <claim>-Status = 'N'.

      MODIFY ENTITIES OF zr_mm_manager_expense IN LOCAL MODE
        ENTITY ExpenseClaim
        UPDATE
        FIELDS ( Status ManagerRemarks )
        WITH VALUE #(
          (
            %tky           = <claim>-%tky
            Status         = 'A'
            ManagerRemarks = 'Claim forwarded to finance manager'
          )
        ).

    ENDIF.

  ENDLOOP.



*  MODIFY ENTITIES OF zr_mm_manager_expense IN LOCAL MODE
*    ENTITY ExpenseClaim
*      UPDATE
*      FIELDS ( Status ManagerRemarks )
*      WITH VALUE #(
*
*        FOR key IN keys
*        (
*
*          %tky           = key-%tky
*          Status         = 'A'
*          ManagerRemarks = 'Claim forwarded to finance manager'
*
*        )
*
*      ).

ENDMETHOD.



METHOD Reject.

  READ ENTITIES OF zr_mm_manager_expense IN LOCAL MODE
    ENTITY ExpenseClaim
    FIELDS ( Status ManagerRemarks )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_claims).

  LOOP AT lt_claims ASSIGNING FIELD-SYMBOL(<claim>).

    "Already Rejected
    IF <claim>-Status = 'R'.

      APPEND VALUE #(
        %tky = <claim>-%tky
      ) TO failed-expenseclaim.

      APPEND VALUE #(
        %tky = <claim>-%tky
        %msg = new_message(
                 id       = 'SY'
                 number   = '002'
                 severity = if_abap_behv_message=>severity-error
                 v1       = 'This Claim is already Rejected'
               )
      ) TO reported-expenseclaim.

    "Already Approved
    ELSEIF <claim>-Status = 'A'.

      APPEND VALUE #(
        %tky = <claim>-%tky
      ) TO failed-expenseclaim.

      APPEND VALUE #(
        %tky = <claim>-%tky
        %msg = new_message(
                 id       = 'SY'
                 number   = '002'
                 severity = if_abap_behv_message=>severity-error
                 v1       = 'This Claim is already Approved'
               )
      ) TO reported-expenseclaim.

    "New Claim → Reject
    ELSEIF <claim>-Status = 'N'.

      MODIFY ENTITIES OF zr_mm_manager_expense IN LOCAL MODE
        ENTITY ExpenseClaim
        UPDATE
        FIELDS ( Status ManagerRemarks )
        WITH VALUE #(
          (
            %tky           = <claim>-%tky
            Status         = 'R'
            ManagerRemarks = keys[ 1 ]-%param-Reason
          )
        ).

    ENDIF.

  ENDLOOP.

ENDMETHOD.



*METHOD Reject.
*
*  MODIFY ENTITIES OF zr_mm_manager_expense IN LOCAL MODE
*    ENTITY ExpenseClaim
*    UPDATE
*    FIELDS ( Status ManagerRemarks )
*    WITH VALUE #(
*      FOR key IN keys
*      (
*        %tky            = key-%tky
*        Status          = 'R'
*        ManagerRemarks  = key-%param-Reason
*      )
*    ).
*
*ENDMETHOD.


ENDCLASS.
