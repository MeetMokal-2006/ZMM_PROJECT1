CLASS ZMM_EXPENSE_MSG DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC INHERITING FROM cx_static_check.

  PUBLIC SECTION .
*
*   INTERFACES if_message .
    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .

    CONSTANTS : BEGIN OF already_canceled,
                  msgid TYPE symsgid VALUE '/LRN/S4D437',
                  msgno TYPE symsgno VALUE '130',
                  attr1 TYPE scx_attrname VALUE 'Travel is already Canceled',
                  attr2 TYPE scx_attrname VALUE '',
                  attr3 TYPE scx_attrname VALUE '',
                  attr4 TYPE scx_attrname VALUE '',
                END OF already_canceled,

               BEGIN OF field_empty,
                  msgid TYPE symsgid VALUE '/LRN/S4D437',
                  msgno TYPE symsgno VALUE '138',
                  attr1 TYPE scx_attrname VALUE ' field is empty ',
                  attr2 TYPE scx_attrname VALUE '',
                  attr3 TYPE scx_attrname VALUE '',
                  attr4 TYPE scx_attrname VALUE '',
                END OF field_empty,

                BEGIN OF coustomer_not_exists,
                  msgid TYPE symsgid VALUE '/LRN/S4D437',
                  msgno TYPE symsgno VALUE '138',
                  attr1 TYPE scx_attrname VALUE ' customer not exists ',
                  attr2 TYPE scx_attrname VALUE '',
                  attr3 TYPE scx_attrname VALUE '',
                  attr4 TYPE scx_attrname VALUE '',
                END OF coustomer_not_exists,

                 BEGIN OF begin_date_past,
                  msgid TYPE symsgid VALUE '/LRN/S4D437',
                  msgno TYPE symsgno VALUE '140',
                  attr1 TYPE scx_attrname VALUE 'Enter valid begindate',
                  attr2 TYPE scx_attrname VALUE '',
                  attr3 TYPE scx_attrname VALUE '',
                  attr4 TYPE scx_attrname VALUE '',
                END OF begin_date_past,

                BEGIN OF end_date_past,
                  msgid TYPE symsgid VALUE '/LRN/S4D437',
                  msgno TYPE symsgno VALUE '142',
                  attr1 TYPE scx_attrname VALUE 'enter valid end date',
                  attr2 TYPE scx_attrname VALUE '',
                  attr3 TYPE scx_attrname VALUE '',
                  attr4 TYPE scx_attrname VALUE '',
                END OF end_date_past,

                BEGIN OF Sorry_s,
                  msgid TYPE symsgid VALUE '/LRN/S4D437',
                  msgno TYPE symsgno VALUE '130',
                  attr1 TYPE scx_attrname VALUE 'Travel is already Canceled',
                  attr2 TYPE scx_attrname VALUE '',
                  attr3 TYPE scx_attrname VALUE '',
                  attr4 TYPE scx_attrname VALUE '',
                END OF Sorry_s,

                BEGIN OF flight_date_past,
                  msgid TYPE symsgid VALUE '/LRN/S4D437',
                  msgno TYPE symsgno VALUE '133',
                  attr1 TYPE scx_attrname VALUE 'enter valid dates',
                  attr2 TYPE scx_attrname VALUE '',
                  attr3 TYPE scx_attrname VALUE '',
                  attr4 TYPE scx_attrname VALUE '',
                END OF flight_date_past,

                  BEGIN OF sequence_d,
                  msgid TYPE symsgid VALUE '/LRN/S4D437',
                  msgno TYPE symsgno VALUE '133',
                  attr1 TYPE scx_attrname VALUE 'enter valid dates',
                  attr2 TYPE scx_attrname VALUE '',
                  attr3 TYPE scx_attrname VALUE '',
                  attr4 TYPE scx_attrname VALUE '',
                END OF sequence_d,

                BEGIN OF field_empty_s,
                  msgid TYPE symsgid VALUE '/LRN/S4D43888',
                  msgno TYPE symsgno VALUE '133',
                  attr1 TYPE scx_attrname VALUE 'working',
                  attr2 TYPE scx_attrname VALUE '',
                  attr3 TYPE scx_attrname VALUE '',
                  attr4 TYPE scx_attrname VALUE '',
                END OF field_empty_s.



    METHODS constructor
      IMPORTING
        !textid  LIKE if_t100_message=>t100key OPTIONAL
*    !previous LIKE previous OPTIONAL .
        severity LIKE if_abap_behv_message~m_severity OPTIONAL
         customerid TYPE /dmo/customer_id OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZMM_EXPENSE_MSG IMPLEMENTATION.




  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.

    ENDIF.
    IF severity IS INITIAL.
      if_abap_behv_message~m_severity = if_abap_behv_message~severity-error.
    ELSE.
      if_abap_behv_message~m_severity = severity.
    ENDIF.

  ENDMETHOD.


ENDCLASS.
