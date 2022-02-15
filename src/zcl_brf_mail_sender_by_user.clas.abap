CLASS zcl_brf_mail_sender_by_user DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS:
      execute
        IMPORTING
          i_user     TYPE uname
          i_password TYPE as4text
        RAISING
          cx_fdt .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BRF_MAIL_SENDER_BY_USER IMPLEMENTATION.


  METHOD execute.
    CONSTANTS:lv_function_id TYPE if_fdt_types=>id VALUE '005056A3BE021EDC87A189F1620060E4'.
    DATA:lv_timestamp  TYPE        timestamp,
         lt_name_value TYPE        abap_parmbind_tab,
         ls_name_value TYPE        abap_parmbind,
         lr_data       TYPE REF TO data,
         lx_fdt        TYPE REF TO cx_fdt,
         la_i_user     TYPE        if_fdt_types=>element_text,
         la_i_password TYPE        if_fdt_types=>element_text.
    FIELD-SYMBOLS <la_any> TYPE any.

    GET TIME STAMP FIELD lv_timestamp.

    ls_name_value-name = 'I_USER'.
    la_i_user = i_user.
    GET REFERENCE OF la_i_user INTO lr_data.
    ls_name_value-value = lr_data.
    INSERT ls_name_value INTO TABLE lt_name_value.

    ls_name_value-name = 'I_PASSWORD'.
    la_i_password = i_password.
    GET REFERENCE OF la_i_password INTO lr_data.
    ls_name_value-value = lr_data.
    INSERT ls_name_value INTO TABLE lt_name_value.

    cl_fdt_function_process=>get_data_object_reference( EXPORTING iv_function_id      = lv_function_id
                                                                  iv_data_object      = '_V_RESULT'
                                                                  iv_timestamp        = lv_timestamp
                                                                  iv_trace_generation = abap_false
                                                        IMPORTING er_data             = lr_data ).
    ASSIGN lr_data->* TO <la_any>.
    TRY.
        cl_fdt_function_process=>process( EXPORTING iv_function_id = lv_function_id
                                                    iv_timestamp   = lv_timestamp
                                          IMPORTING ea_result      = <la_any>
                                          CHANGING  ct_name_value  = lt_name_value ).
      CATCH cx_fdt INTO lx_fdt.
        RETURN.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
