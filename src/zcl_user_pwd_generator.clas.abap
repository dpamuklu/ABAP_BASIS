CLASS zcl_user_pwd_generator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          i_user TYPE bapibname-bapibname,
      execute
        RETURNING
          VALUE(result) TYPE bapiparam-partxt.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      username TYPE bapibname-bapibname.
    METHODS:
      unlock_user
        RETURNING
          VALUE(result) TYPE abap_bool,
      change_pwd
        RETURNING
          VALUE(result) TYPE bapipwd.
ENDCLASS.



CLASS ZCL_USER_PWD_GENERATOR IMPLEMENTATION.


  METHOD change_pwd.
    DATA: password TYPE bapipwd,
          return   TYPE bapiret2tab.
    DATA(passwordx) = VALUE bapipwdx( bapipwd = abap_true ).

    CALL FUNCTION 'BAPI_USER_CHANGE'
      EXPORTING
        username           = username
        passwordx          = passwordx
        generate_pwd       = abap_true
      IMPORTING
        generated_password = password
      TABLES
        return             = return.
    IF sy-subrc EQ 0 AND
       NOT line_exists( return[ type = zcl_bapi_constants=>error ] ).
      result = password.
    ENDIF.
  ENDMETHOD.


  METHOD constructor.
    username = i_user.
  ENDMETHOD.


  METHOD execute.
    CHECK unlock_user( ) EQ abap_true.
    DATA(password) = change_pwd(  ).
    result = password.
  ENDMETHOD.


  METHOD unlock_user.
    DATA: return TYPE bapiret2tab.

    CALL FUNCTION 'BAPI_USER_UNLOCK'
      EXPORTING
        username = username
      TABLES
        return   = return.
    IF sy-subrc EQ 0 AND
    NOT line_exists( return[ type = zcl_bapi_constants=>error ] ).
      result = abap_true.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
