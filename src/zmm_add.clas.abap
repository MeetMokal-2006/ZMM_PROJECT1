CLASS zmm_add DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zmm_add IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lt_claim TYPE TABLE OF zmm_expens_claim,
          lt_item  TYPE TABLE OF zmm_expense_item.

    DATA: lv_uuid      TYPE sysuuid_x16,
          lv_timestamp TYPE timestampl.

    GET TIME STAMP FIELD lv_timestamp.


*---------------------------------------------------------------------*
* CLAIM 1 - CLM1003
*---------------------------------------------------------------------*

    APPEND VALUE #(
      client                = sy-mandt
      claim_id              = 'CLM1003'
      employee_id           = 'EMP000006'
      purpose               = 'Client visit and business meeting from Aug 5 to Aug 7, 2026'
      claim_date            = '20260807'
      cuky_field            = 'INR'
      total_amount          = '4950.00'
      status                = 'N'
      manager_remarks       = ''
      created_by            = sy-uname
      created_at            = lv_timestamp
      last_changed_by       = sy-uname
      last_changed_at       = lv_timestamp
      local_last_changed_at = lv_timestamp
    ) TO lt_claim.


    " Taxi - paid on Aug 5
    lv_uuid = cl_system_uuid=>create_uuid_x16_static( ).

    APPEND VALUE #(
      client                = sy-mandt
      item_id               = lv_uuid
      claim_id              = 'CLM1003'
      expense_type_id       = 'EXP004'
      expense_date          = '20260805'
      cuky_field            = 'INR'
      amount                = '850.00'
      description           = 'Taxi from office to client location and return on Aug 5, 2026'
      created_by            = sy-uname
      created_at            = lv_timestamp
      last_changed_by       = sy-uname
      last_changed_at       = lv_timestamp
      local_last_changed_at = lv_timestamp
    ) TO lt_item.


    " Food - paid on Aug 7
    lv_uuid = cl_system_uuid=>create_uuid_x16_static( ).

    APPEND VALUE #(
      client                = sy-mandt
      item_id               = lv_uuid
      claim_id              = 'CLM1003'
      expense_type_id       = 'EXP002'
      expense_date          = '20260807'
      cuky_field            = 'INR'
      amount                = '900.00'
      description           = 'Meals for 3 days from Aug 5 to Aug 7, 2026 - Rs. 300 per day'
      created_by            = sy-uname
      created_at            = lv_timestamp
      last_changed_by       = sy-uname
      last_changed_at       = lv_timestamp
      local_last_changed_at = lv_timestamp
    ) TO lt_item.


    " Hotel - paid at checkout on Aug 7
    lv_uuid = cl_system_uuid=>create_uuid_x16_static( ).

    APPEND VALUE #(
      client                = sy-mandt
      item_id               = lv_uuid
      claim_id              = 'CLM1003'
      expense_type_id       = 'EXP003'
      expense_date          = '20260807'
      cuky_field            = 'INR'
      amount                = '3200.00'
      description           = 'Hotel stay from Aug 5 to Aug 7, 2026 - 2 nights; bill paid at checkout on Aug 7'
      created_by            = sy-uname
      created_at            = lv_timestamp
      last_changed_by       = sy-uname
      last_changed_at       = lv_timestamp
      local_last_changed_at = lv_timestamp
    ) TO lt_item.



*---------------------------------------------------------------------*
* CLAIM 2 - CLM1004
*---------------------------------------------------------------------*

    APPEND VALUE #(
      client                = sy-mandt
      claim_id              = 'CLM1004'
      employee_id           = 'EMP000007'
      purpose               = 'Attend employee training program from Aug 4 to Aug 6, 2026'
      claim_date            = '20260806'
      cuky_field            = 'INR'
      total_amount          = '3850.00'
      status                = 'N'
      manager_remarks       = ''
      created_by            = sy-uname
      created_at            = lv_timestamp
      last_changed_by       = sy-uname
      last_changed_at       = lv_timestamp
      local_last_changed_at = lv_timestamp
    ) TO lt_claim.


    " Taxi - paid on Aug 4
    lv_uuid = cl_system_uuid=>create_uuid_x16_static( ).

    APPEND VALUE #(
      client                = sy-mandt
      item_id               = lv_uuid
      claim_id              = 'CLM1004'
      expense_type_id       = 'EXP004'
      expense_date          = '20260804'
      cuky_field            = 'INR'
      amount                = '600.00'
      description           = 'Taxi travel to training venue on Aug 4, 2026'
      created_by            = sy-uname
      created_at            = lv_timestamp
      last_changed_by       = sy-uname
      last_changed_at       = lv_timestamp
      local_last_changed_at = lv_timestamp
    ) TO lt_item.


    " Food - paid on Aug 6
    lv_uuid = cl_system_uuid=>create_uuid_x16_static( ).

    APPEND VALUE #(
      client                = sy-mandt
      item_id               = lv_uuid
      claim_id              = 'CLM1004'
      expense_type_id       = 'EXP002'
      expense_date          = '20260806'
      cuky_field            = 'INR'
      amount                = '450.00'
      description           = 'Meals during 3-day training program from Aug 4 to Aug 6, 2026'
      created_by            = sy-uname
      created_at            = lv_timestamp
      last_changed_by       = sy-uname
      last_changed_at       = lv_timestamp
      local_last_changed_at = lv_timestamp
    ) TO lt_item.


    " Hotel - paid at checkout on Aug 6
    lv_uuid = cl_system_uuid=>create_uuid_x16_static( ).

    APPEND VALUE #(
      client                = sy-mandt
      item_id               = lv_uuid
      claim_id              = 'CLM1004'
      expense_type_id       = 'EXP003'
      expense_date          = '20260806'
      cuky_field            = 'INR'
      amount                = '2800.00'
      description           = 'Hotel stay from Aug 4 to Aug 6, 2026 - 2 nights; bill paid at checkout on Aug 6'
      created_by            = sy-uname
      created_at            = lv_timestamp
      last_changed_by       = sy-uname
      last_changed_at       = lv_timestamp
      local_last_changed_at = lv_timestamp
    ) TO lt_item.



*---------------------------------------------------------------------*
* CLAIM 3 - CLM1005
*---------------------------------------------------------------------*

    APPEND VALUE #(
      client                = sy-mandt
      claim_id              = 'CLM1005'
      employee_id           = 'EMP000008'
      purpose               = 'Regional operations review from Aug 8 to Aug 10, 2026'
      claim_date            = '20260810'
      cuky_field            = 'INR'
      total_amount          = '4800.00'
      status                = 'N'
      manager_remarks       = ''
      created_by            = sy-uname
      created_at            = lv_timestamp
      last_changed_by       = sy-uname
      last_changed_at       = lv_timestamp
      local_last_changed_at = lv_timestamp
    ) TO lt_claim.


    " Taxi - paid on Aug 8
    lv_uuid = cl_system_uuid=>create_uuid_x16_static( ).

    APPEND VALUE #(
      client                = sy-mandt
      item_id               = lv_uuid
      claim_id              = 'CLM1005'
      expense_type_id       = 'EXP004'
      expense_date          = '20260808'
      cuky_field            = 'INR'
      amount                = '750.00'
      description           = 'Local taxi travel for regional operations meetings on Aug 8, 2026'
      created_by            = sy-uname
      created_at            = lv_timestamp
      last_changed_by       = sy-uname
      last_changed_at       = lv_timestamp
      local_last_changed_at = lv_timestamp
    ) TO lt_item.


    " Food - paid on Aug 10
    lv_uuid = cl_system_uuid=>create_uuid_x16_static( ).

    APPEND VALUE #(
      client                = sy-mandt
      item_id               = lv_uuid
      claim_id              = 'CLM1005'
      expense_type_id       = 'EXP002'
      expense_date          = '20260810'
      cuky_field            = 'INR'
      amount                = '550.00'
      description           = 'Meals for 3-day business trip from Aug 8 to Aug 10, 2026'
      created_by            = sy-uname
      created_at            = lv_timestamp
      last_changed_by       = sy-uname
      last_changed_at       = lv_timestamp
      local_last_changed_at = lv_timestamp
    ) TO lt_item.


    " Hotel - paid at checkout on Aug 10
    lv_uuid = cl_system_uuid=>create_uuid_x16_static( ).

    APPEND VALUE #(
      client                = sy-mandt
      item_id               = lv_uuid
      claim_id              = 'CLM1005'
      expense_type_id       = 'EXP003'
      expense_date          = '20260810'
      cuky_field            = 'INR'
      amount                = '3500.00'
      description           = 'Hotel stay from Aug 8 to Aug 10, 2026 - 2 nights; bill paid at checkout on Aug 10'
      created_by            = sy-uname
      created_at            = lv_timestamp
      last_changed_by       = sy-uname
      last_changed_at       = lv_timestamp
      local_last_changed_at = lv_timestamp
    ) TO lt_item.



*---------------------------------------------------------------------*
* CLAIM 4 - CLM1006
*---------------------------------------------------------------------*

    APPEND VALUE #(
      client                = sy-mandt
      claim_id              = 'CLM1006'
      employee_id           = 'EMP000009'
      purpose               = 'Business conference and networking event from Aug 6 to Aug 8, 2026'
      claim_date            = '20260808'
      cuky_field            = 'INR'
      total_amount          = '5600.00'
      status                = 'N'
      manager_remarks       = ''
      created_by            = sy-uname
      created_at            = lv_timestamp
      last_changed_by       = sy-uname
      last_changed_at       = lv_timestamp
      local_last_changed_at = lv_timestamp
    ) TO lt_claim.


    " Taxi - paid on Aug 6
    lv_uuid = cl_system_uuid=>create_uuid_x16_static( ).

    APPEND VALUE #(
      client                = sy-mandt
      item_id               = lv_uuid
      claim_id              = 'CLM1006'
      expense_type_id       = 'EXP004'
      expense_date          = '20260806'
      cuky_field            = 'INR'
      amount                = '800.00'
      description           = 'Taxi travel to business conference venue on Aug 6, 2026'
      created_by            = sy-uname
      created_at            = lv_timestamp
      last_changed_by       = sy-uname
      last_changed_at       = lv_timestamp
      local_last_changed_at = lv_timestamp
    ) TO lt_item.


    " Food - paid on Aug 8
    lv_uuid = cl_system_uuid=>create_uuid_x16_static( ).

    APPEND VALUE #(
      client                = sy-mandt
      item_id               = lv_uuid
      claim_id              = 'CLM1006'
      expense_type_id       = 'EXP002'
      expense_date          = '20260808'
      cuky_field            = 'INR'
      amount                = '1200.00'
      description           = 'Meals for 3-day conference from Aug 6 to Aug 8, 2026'
      created_by            = sy-uname
      created_at            = lv_timestamp
      last_changed_by       = sy-uname
      last_changed_at       = lv_timestamp
      local_last_changed_at = lv_timestamp
    ) TO lt_item.


    " Hotel - paid at checkout on Aug 8
    lv_uuid = cl_system_uuid=>create_uuid_x16_static( ).

    APPEND VALUE #(
      client                = sy-mandt
      item_id               = lv_uuid
      claim_id              = 'CLM1006'
      expense_type_id       = 'EXP003'
      expense_date          = '20260808'
      cuky_field            = 'INR'
      amount                = '3600.00'
      description           = 'Hotel stay from Aug 6 to Aug 8, 2026 - 2 nights; bill paid at checkout on Aug 8'
      created_by            = sy-uname
      created_at            = lv_timestamp
      last_changed_by       = sy-uname
      last_changed_at       = lv_timestamp
      local_last_changed_at = lv_timestamp
    ) TO lt_item.



*---------------------------------------------------------------------*
* INSERT CLAIMS
*---------------------------------------------------------------------*

    INSERT zmm_expens_claim FROM TABLE @lt_claim.

    IF sy-subrc = 0.

      out->write(
        'Expense claims inserted successfully.'
      ).

    ELSE.

      ROLLBACK WORK.

      out->write(
        'Error inserting expense claims.'
      ).

      RETURN.

    ENDIF.


*---------------------------------------------------------------------*
* INSERT EXPENSE ITEMS
*---------------------------------------------------------------------*

    INSERT zmm_expense_item FROM TABLE @lt_item.

    IF sy-subrc = 0.

      COMMIT WORK.

      out->write(
        'Expense items inserted successfully.'
      ).

      out->write(
        'All 4 dummy expense claims inserted successfully.'
      ).

    ELSE.

      ROLLBACK WORK.

      out->write(
        'Error inserting expense items.'
      ).

    ENDIF.

  ENDMETHOD.

ENDCLASS.
