CLASS lhc_expenseitem DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS ValidateAmount FOR VALIDATE ON SAVE
      IMPORTING keys FOR ExpenseItem~ValidateAmount.

    METHODS ValidateExpenseDate FOR VALIDATE ON SAVE
      IMPORTING keys FOR ExpenseItem~ValidateExpenseDate.

    METHODS ValidateExpenseType FOR VALIDATE ON SAVE
      IMPORTING keys FOR ExpenseItem~ValidateExpenseType.
    METHODS UpdateClaimTotal FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ExpenseItem~UpdateClaimTotal.


    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR ExpenseItem RESULT result.
    METHODS determinecurrency FOR DETERMINE ON MODIFY
      IMPORTING keys FOR expenseitem~determinecurrency.
    METHODS fillexpensetypename FOR DETERMINE ON MODIFY
      IMPORTING keys FOR expenseitem~fillexpensetypename.



ENDCLASS.



CLASS lhc_expenseitem IMPLEMENTATION.

  METHOD ValidateAmount.

    CONSTANTS c_area TYPE string VALUE 'AMOUNT'.

    READ ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseItem
        FIELDS ( Amount )
        WITH CORRESPONDING #( keys )
        RESULT DATA(items)

      BY \_ExpenseClaim
        FIELDS ( ClaimId )
        WITH CORRESPONDING #( keys )
        RESULT DATA(claims)
        LINK DATA(link).

    LOOP AT items ASSIGNING FIELD-SYMBOL(<item>).

      APPEND VALUE #(
        %tky        = <item>-%tky
        %state_area = c_area
      ) TO reported-expenseitem.

      ASSIGN link[ KEY id source-%tky = <item>-%tky ]
        TO FIELD-SYMBOL(<link>).

      CHECK <link> IS ASSIGNED.

      IF <item>-Amount IS INITIAL
         OR <item>-Amount <= 0.

        APPEND VALUE #(
          %tky = <item>-%tky
        ) TO failed-expenseitem.

        APPEND VALUE #(
          %tky            = <item>-%tky
          %msg            = new_message_with_text(
                              severity = if_abap_behv_message=>severity-error
                              text     = 'Amount must be greater than zero.'
                            )
          %element-Amount = if_abap_behv=>mk-on
          %state_area     = c_area
          %path-ExpenseClaim = <link>-target-%tky
        ) TO reported-expenseitem.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.
  METHOD ValidateExpenseDate.

    CONSTANTS c_area TYPE string VALUE 'EXPENSEDATE'.

    READ ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseItem
        FIELDS ( ExpenseDate )
        WITH CORRESPONDING #( keys )
        RESULT DATA(items)

      BY \_ExpenseClaim
        FIELDS ( ClaimId )
        WITH CORRESPONDING #( keys )
        RESULT DATA(claims)
        LINK DATA(link).

    LOOP AT items ASSIGNING FIELD-SYMBOL(<item>).

      "Clear previous messages
      APPEND VALUE #(
        %tky        = <item>-%tky
        %state_area = c_area
      ) TO reported-expenseitem.

      ASSIGN link[ KEY id source-%tky = <item>-%tky ]
        TO FIELD-SYMBOL(<link>).

      CHECK <link> IS ASSIGNED.

      IF <item>-ExpenseDate IS INITIAL
         OR <item>-ExpenseDate > cl_abap_context_info=>get_system_date( ).

        APPEND VALUE #(
          %tky = <item>-%tky
        ) TO failed-expenseitem.

        APPEND VALUE #(
          %tky                 = <item>-%tky
          %msg                 = new_message_with_text(
                                   severity = if_abap_behv_message=>severity-error
                                   text     = 'Invalid Expense Date'
                                 )
          %element-ExpenseDate = if_abap_behv=>mk-on
          %state_area          = c_area
          %path-ExpenseClaim   = <link>-target-%tky
        ) TO reported-expenseitem.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.
*  METHOD ValidateExpenseDate.
*
*    READ ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
*      ENTITY ExpenseItem
*      FIELDS ( ExpenseDate )
*      WITH CORRESPONDING #( keys )
*      RESULT DATA(lt_items).
*
*    LOOP AT lt_items INTO DATA(ls_item).
*
*      IF ls_item-ExpenseDate IS INITIAL.
*
*        APPEND VALUE #( %tky = ls_item-%tky ) TO failed-expenseitem.
*
*        APPEND VALUE #(
*          %tky                 = ls_item-%tky
*          %msg                 = new_message_with_text(
*                                  severity = if_abap_behv_message=>severity-error
*                                  text     = 'Expense Date is required.'
*                                )
*          %element-ExpenseDate = if_abap_behv=>mk-on
*        ) TO reported-expenseitem.
*
*      ELSEIF ls_item-ExpenseDate > cl_abap_context_info=>get_system_date( ).
*
*        APPEND VALUE #( %tky = ls_item-%tky ) TO failed-expenseitem.
*
*        APPEND VALUE #(
*          %tky                 = ls_item-%tky
*          %msg                 = new_message_with_text(
*                                  severity = if_abap_behv_message=>severity-error
*                                  text     = 'Expense Date cannot be in the future.'
*                                )
*          %element-ExpenseDate = if_abap_behv=>mk-on
*        ) TO reported-expenseitem.
*
*      ENDIF.
*
*    ENDLOOP.
*
*  ENDMETHOD.


  METHOD ValidateExpenseType.

    CONSTANTS c_area TYPE string VALUE 'EXPENSETYPE'.

    READ ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseItem
        FIELDS ( ExpenseTypeId )
        WITH CORRESPONDING #( keys )
        RESULT DATA(items)

      BY \_ExpenseClaim
        FIELDS ( ClaimId )
        WITH CORRESPONDING #( keys )
        RESULT DATA(claims)
        LINK DATA(link).

    LOOP AT items ASSIGNING FIELD-SYMBOL(<item>).

      APPEND VALUE #(
        %tky        = <item>-%tky
        %state_area = c_area
      ) TO reported-expenseitem.

      ASSIGN link[ KEY id source-%tky = <item>-%tky ]
        TO FIELD-SYMBOL(<link>).

      CHECK <link> IS ASSIGNED.

      IF <item>-ExpenseTypeId IS INITIAL.

        APPEND VALUE #(
          %tky = <item>-%tky
        ) TO failed-expenseitem.

        APPEND VALUE #(
          %tky                    = <item>-%tky
          %msg                    = new_message_with_text(
                                      severity = if_abap_behv_message=>severity-error
                                      text     = 'Expense Type is mandatory.'
                                    )
          %element-ExpenseTypeId  = if_abap_behv=>mk-on
          %state_area             = c_area
          %path-ExpenseClaim      = <link>-target-%tky
        ) TO reported-expenseitem.

      ELSE.

        SELECT SINGLE expense_type_id
          FROM zmm_expense_type
          WHERE expense_type_id = @<item>-ExpenseTypeId
          INTO @DATA(lv_type).

        IF sy-subrc <> 0.

          APPEND VALUE #(
            %tky = <item>-%tky
          ) TO failed-expenseitem.

          APPEND VALUE #(
            %tky                    = <item>-%tky
            %msg                    = new_message_with_text(
                                        severity = if_abap_behv_message=>severity-error
                                        text     = 'Expense Type does not exist.'
                                      )
            %element-ExpenseTypeId  = if_abap_behv=>mk-on
            %state_area             = c_area
            %path-ExpenseClaim      = <link>-target-%tky
          ) TO reported-expenseitem.

        ENDIF.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD UpdateClaimTotal.

    " Step 1: Find which claims are affected by the changed item(s)
    READ ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseItem
        FIELDS ( ClaimId )
        WITH CORRESPONDING #( keys )
        RESULT DATA(items)
      BY \_ExpenseClaim
        FIELDS ( TotalAmount )
        WITH CORRESPONDING #( keys )
        RESULT DATA(claims).

    IF claims IS INITIAL.
      RETURN.
    ENDIF.

    " Step 2: Read all items for affected claims
    READ ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseClaim
        BY \_ExpenseItem
        FIELDS ( Amount )
        WITH CORRESPONDING #( claims )
        RESULT DATA(all_items)
        LINK DATA(link).

    LOOP AT claims ASSIGNING FIELD-SYMBOL(<claim>).

      CLEAR <claim>-TotalAmount.

      LOOP AT link ASSIGNING FIELD-SYMBOL(<link>)
        WHERE source-%tky = <claim>-%tky.

        READ TABLE all_items
          WITH KEY %tky = <link>-target-%tky
          ASSIGNING FIELD-SYMBOL(<item>).

        IF sy-subrc = 0.
          <claim>-TotalAmount = <claim>-TotalAmount + <item>-Amount.
        ENDIF.

      ENDLOOP.

    ENDLOOP.

    MODIFY ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseClaim
        UPDATE
        FIELDS ( TotalAmount )
        WITH CORRESPONDING #( claims ).

  ENDMETHOD.


  METHOD get_instance_features.

    READ ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseItem
        BY \_ExpenseClaim
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
        RESULT DATA(claims)
        LINK DATA(link).

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).

      APPEND VALUE #( %tky = <key>-%tky ) TO result
        ASSIGNING FIELD-SYMBOL(<result>).

      READ TABLE link WITH KEY source-%tky = <key>-%tky
        ASSIGNING FIELD-SYMBOL(<link>).

      DATA(lv_editable) = abap_false.

      IF sy-subrc = 0.
        READ TABLE claims WITH KEY %tky = <link>-target-%tky
          ASSIGNING FIELD-SYMBOL(<claim>).

        IF sy-subrc = 0 AND ( <claim>-Status = 'R' OR <claim>-Status = 'D' ).
          lv_editable = abap_true.
        ENDIF.
      ENDIF.

      IF lv_editable = abap_true.
        <result>-%update = if_abap_behv=>fc-o-enabled.
        <result>-%delete = if_abap_behv=>fc-o-enabled.
      ELSE.
        <result>-%update = if_abap_behv=>fc-o-disabled.
        <result>-%delete = if_abap_behv=>fc-o-disabled.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD DetermineCurrency.

    DATA lt_update TYPE TABLE FOR UPDATE zr_mm_expenseclaim\\ExpenseItem.

    READ ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseItem
        FIELDS ( CukyField )
        WITH CORRESPONDING #( keys )
        RESULT DATA(items).

    LOOP AT items ASSIGNING FIELD-SYMBOL(<item>).

      IF <item>-CukyField IS INITIAL.

        APPEND VALUE #(
          %tky      = <item>-%tky
          CukyField = 'INR'
        ) TO lt_update.

      ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseItem
        UPDATE
        FIELDS ( CukyField )
        WITH lt_update.

  ENDMETHOD.

  METHOD FillExpenseTypeName.

    READ ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseItem
      FIELDS ( ExpenseTypeId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_items).

    IF lt_items IS INITIAL.
      RETURN.
    ENDIF.

    DATA lt_expense_types TYPE SORTED TABLE OF zmm_expense_type
      WITH UNIQUE KEY expense_type_id.

    SELECT expense_type_id, expense_type_name
      FROM zmm_expense_type
      FOR ALL ENTRIES IN @lt_items
      WHERE expense_type_id = @lt_items-ExpenseTypeId
      INTO CORRESPONDING FIELDS OF TABLE @lt_expense_types.

    DATA lt_update TYPE TABLE FOR UPDATE zr_mm_expenseitem.   " <-- fixed

    LOOP AT lt_items ASSIGNING FIELD-SYMBOL(<item>).

      READ TABLE lt_expense_types
        WITH KEY expense_type_id = <item>-ExpenseTypeId
        ASSIGNING FIELD-SYMBOL(<type>).

      IF sy-subrc = 0.
        APPEND VALUE #(
          %tky            = <item>-%tky
          ExpenseTypeName = <type>-expense_type_name
        ) TO lt_update.
      ENDIF.

    ENDLOOP.

    IF lt_update IS NOT INITIAL.

      MODIFY ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
        ENTITY ExpenseItem
        UPDATE
        FIELDS ( ExpenseTypeName )
        WITH lt_update
        REPORTED DATA(lt_reported).

    ENDIF.

  ENDMETHOD.




ENDCLASS.













CLASS lhc_ZR_MM_EXPENSECLAIM DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_mm_expenseclaim RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zr_mm_expenseclaim RESULT result.




*    METHODS validateemployee FOR VALIDATE ON SAVE
*      IMPORTING keys FOR expenseclaim~validateemployee.
*
*    METHODS validatepurpose FOR VALIDATE ON SAVE
*      IMPORTING keys FOR expenseclaim~validatepurpose.
    METHODS determinestatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR expenseclaim~determinestatus.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR expenseclaim RESULT result.
    METHODS determineclaimdate FOR DETERMINE ON MODIFY
      IMPORTING keys FOR expenseclaim~determineclaimdate.
    METHODS cancel_claim FOR MODIFY
      IMPORTING keys FOR ACTION expenseclaim~cancel_claim.
    METHODS draftstatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR expenseclaim~draftstatus.
    METHODS determinecurrency FOR DETERMINE ON MODIFY
      IMPORTING keys FOR expenseclaim~determinecurrency.
    METHODS fillemployeedetails FOR DETERMINE ON MODIFY
      IMPORTING keys FOR expenseclaim~fillemployeedetails.
    METHODS reapply_claim FOR MODIFY
      IMPORTING keys FOR ACTION expenseclaim~reapply_claim.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE zr_mm_expenseclaim.

ENDCLASS.

CLASS lhc_ZR_MM_EXPENSECLAIM IMPLEMENTATION.

  METHOD get_instance_authorizations.

  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

*-------------------------------------------------------------------------------------------------------
*Early Numbering
*----------------------------------------------------------------------------------------------------------

  METHOD earlynumbering_create.

    DATA: lv_max_active TYPE zmm_expens_claim-claim_id,
          lv_max_draft  TYPE zmm_expens_claim-claim_id,
          lv_lastid     TYPE zmm_expens_claim-claim_id,
          lv_number     TYPE i.

    " 1. Check persistent table
    SELECT SINGLE MAX( claim_id ) FROM zmm_expens_claim INTO @lv_max_active.

    " 2. Check draft table to avoid key collisions with uncommitted drafts
    SELECT SINGLE MAX( claimid ) FROM zmm_expens_c_d INTO @lv_max_draft.

    " 3. Select highest key overall
    lv_lastid = COND #( WHEN lv_max_active > lv_max_draft THEN lv_max_active ELSE lv_max_draft ).

    IF lv_lastid IS INITIAL.
      lv_number = 1000.
    ELSE.
      lv_number = CONV i( replace( val = lv_lastid sub = 'CLM' with = '' ) ).
    ENDIF.

    " 4. Map %cid and %is_draft correctly
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
      IF <entity>-ClaimId IS INITIAL.
        lv_number += 1.
        DATA(lv_claim_id) = |CLM{ lv_number WIDTH = 4 PAD = '0' }|.
      ELSE.
        lv_claim_id = <entity>-ClaimId.
      ENDIF.

      APPEND VALUE #(
        %cid      = <entity>-%cid
        %is_draft = <entity>-%is_draft
        ClaimId   = lv_claim_id
      ) TO mapped-expenseclaim.
    ENDLOOP.

  ENDMETHOD.


  METHOD DetermineStatus.

    READ ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseClaim
      FIELDS ( Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_claims).

    " Only claims still in Draft status should be promoted to 'N' on save
    DELETE lt_claims WHERE Status <> 'D'.

    CHECK lt_claims IS NOT INITIAL.

    MODIFY ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseClaim
        UPDATE
          FIELDS ( Status )
          WITH VALUE #(
            FOR ls_claim IN lt_claims
            (
              %tky   = ls_claim-%tky
              Status = 'N'
            )
          )
          REPORTED DATA(ls_reported).

    reported = CORRESPONDING #( DEEP ls_reported ).

  ENDMETHOD.


  METHOD get_instance_features.


    READ ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseClaim
      FIELDS ( Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_claims).

    LOOP AT lt_claims ASSIGNING FIELD-SYMBOL(<claim>).

      APPEND CORRESPONDING #( <claim> ) TO result
        ASSIGNING FIELD-SYMBOL(<result>).

      IF <claim>-Status = 'R' OR <claim>-Status = 'D'.

        <result>-%update =
          if_abap_behv=>fc-o-enabled.

        <result>-%action-edit =
          if_abap_behv=>fc-o-enabled.

      ELSE.

        <result>-%update =
          if_abap_behv=>fc-o-disabled.

        <result>-%action-edit =
          if_abap_behv=>fc-o-disabled.

      ENDIF.

      IF <claim>-Status = 'D'.

        <result>-%delete =
          if_abap_behv=>fc-o-enabled.

      ELSE.

        <result>-%delete =
          if_abap_behv=>fc-o-disabled.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD determineclaimdate.

    DATA lt_update TYPE TABLE FOR UPDATE zr_mm_expenseclaim.

    READ ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseClaim
      FIELDS ( ClaimDate )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_claims).

    LOOP AT lt_claims ASSIGNING FIELD-SYMBOL(<claim>).

      IF <claim>-ClaimDate IS INITIAL.

        APPEND VALUE #(
          %tky      = <claim>-%tky
          ClaimDate = cl_abap_context_info=>get_system_date( )
        ) TO lt_update.

      ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseClaim
        UPDATE
        FIELDS ( ClaimDate )
        WITH lt_update.

  ENDMETHOD.

  METHOD Cancel_Claim.

    DATA lt_update TYPE TABLE FOR UPDATE zr_mm_expenseclaim.

    READ ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseClaim
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_claims).

    LOOP AT lt_claims ASSIGNING FIELD-SYMBOL(<claim>).

      IF <claim>-Status <> 'N'.

        APPEND VALUE #(
          %tky = <claim>-%tky
        ) TO failed-expenseclaim.

        APPEND VALUE #(
          %tky = <claim>-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = 'Only New claims can be cancelled.'
                 )
        ) TO reported-expenseclaim.

        CONTINUE.

      ENDIF.

      APPEND VALUE #(
        %tky   = <claim>-%tky
        Status = 'C'
      ) TO lt_update.

    ENDLOOP.

    IF lt_update IS NOT INITIAL.

      MODIFY ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
        ENTITY ExpenseClaim
          UPDATE
            FIELDS ( Status )
            WITH lt_update.

    ENDIF.

  ENDMETHOD.

  METHOD draftStatus.
    READ ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
     ENTITY ExpenseClaim
     FIELDS ( Status )
     WITH CORRESPONDING #( keys )
     RESULT DATA(lt_claims).

    "Only set status for newly created claims
    DELETE lt_claims WHERE Status IS NOT INITIAL.

    CHECK lt_claims IS NOT INITIAL.

    MODIFY ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseClaim
        UPDATE
          FIELDS ( Status )
          WITH VALUE #(
            FOR ls_claim IN lt_claims
            (
              %tky   = ls_claim-%tky
              Status = 'D'
            )
          )
          REPORTED DATA(ls_reported).

    reported = CORRESPONDING #( DEEP ls_reported ).

  ENDMETHOD.

  METHOD DetermineCurrency.

    DATA lt_update TYPE TABLE FOR UPDATE zr_mm_expenseclaim.

    READ ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseClaim
        FIELDS ( CukyField )
        WITH CORRESPONDING #( keys )
        RESULT DATA(claims).

    LOOP AT claims ASSIGNING FIELD-SYMBOL(<claim>).

      IF <claim>-CukyField IS INITIAL.

        APPEND VALUE #(
          %tky      = <claim>-%tky
          CukyField = 'INR'
        ) TO lt_update.

      ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseClaim
        UPDATE
        FIELDS ( CukyField )
        WITH lt_update.

  ENDMETHOD.

  METHOD FillEmployeeDetails.

    READ ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseClaim
      FIELDS ( EmployeeId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_claim).

    DATA lt_update TYPE TABLE FOR UPDATE zr_mm_expenseclaim.

    LOOP AT lt_claim INTO DATA(ls_claim).

      SELECT SINGLE
             employeename,
             department
        FROM zr_mm_employee
        WHERE employeeid = @ls_claim-EmployeeId
        INTO @DATA(ls_emp).

      IF sy-subrc = 0.

        APPEND VALUE #(
          %tky         = ls_claim-%tky
          EmployeeName = ls_emp-EmployeeName
          Department   = ls_emp-Department
        ) TO lt_update.

      ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseClaim
      UPDATE
        FIELDS ( EmployeeName Department )
      WITH lt_update.

  ENDMETHOD.

  METHOD Reapply_Claim.

    READ ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
      ENTITY ExpenseClaim
      FIELDS ( Status ManagerRemarks )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_claims).

    DATA lt_update TYPE TABLE FOR UPDATE zr_mm_expenseclaim.

    LOOP AT lt_claims ASSIGNING FIELD-SYMBOL(<claim>).

      "Only Rejected claims can be reapplied
      IF <claim>-Status <> 'R'.

        APPEND VALUE #(
          %tky = <claim>-%tky
        ) TO failed-expenseclaim.

        APPEND VALUE #(
          %tky = <claim>-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = 'Only rejected claims can be reapplied.'
                 )
        ) TO reported-expenseclaim.

        CONTINUE.

      ENDIF.

      APPEND VALUE #(
        %tky           = <claim>-%tky
        Status         = 'N'
        ManagerRemarks = |{ <claim>-ManagerRemarks }{ cl_abap_char_utilities=>newline }Re-applied|
      ) TO lt_update.

    ENDLOOP.

    IF lt_update IS NOT INITIAL.

      MODIFY ENTITIES OF zr_mm_expenseclaim IN LOCAL MODE
        ENTITY ExpenseClaim
        UPDATE
        FIELDS ( Status ManagerRemarks )
        WITH lt_update.

    ENDIF.

  ENDMETHOD.

ENDCLASS.
