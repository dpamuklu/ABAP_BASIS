CLASS zcl_user_pwd_mail_model DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          i_uname TYPE sy-uname,
      execute
        RETURNING VALUE(result) TYPE abap_bool
        RAISING   /iwbep/cx_mgw_busi_exception.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      username TYPE sy-uname.
ENDCLASS.



CLASS ZCL_USER_PWD_MAIL_MODEL IMPLEMENTATION.


  METHOD constructor.
    username = i_uname.
  ENDMETHOD.


  METHOD execute.
    DATA(user_pwd_generator) = NEW zcl_user_pwd_generator( username ).
    DATA(password) = user_pwd_generator->execute( ).
    IF password IS INITIAL.
      RETURN.
    ENDIF.
    TRY.
        zcl_brf_mail_sender_by_user=>execute( i_user     = username
                                              i_password = password ).
      CATCH cx_fdt.
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception.
    ENDTRY.
    result = abap_true.
  ENDMETHOD.
ENDCLASS.
