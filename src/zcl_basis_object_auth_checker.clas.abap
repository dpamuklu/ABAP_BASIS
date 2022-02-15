CLASS zcl_basis_object_auth_checker DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          i_object TYPE ust12-objct
          i_user   TYPE usr02-bname DEFAULT sy-uname
          i_field1 TYPE ust12-field OPTIONAL
          i_value1 TYPE ust12-von OPTIONAL,
      is_okay
        RETURNING
          VALUE(result) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      user   TYPE usr02-bname,
      object TYPE ust12-objct,
      field1 TYPE ust12-field,
      value1 TYPE ust12-von.
ENDCLASS.



CLASS ZCL_BASIS_OBJECT_AUTH_CHECKER IMPLEMENTATION.


  METHOD constructor.
    user   = i_user.
    object = i_object.
    field1 = i_field1.
    value1 = i_value1.
  ENDMETHOD.


  METHOD is_okay.
    CALL FUNCTION 'AUTHORITY_CHECK'
      EXPORTING
        user                = user
        object              = object
        field1              = field1
        value1              = value1
      EXCEPTIONS
        user_dont_exist     = 1
        user_is_authorized  = 2
        user_not_authorized = 3
        user_is_locked      = 4
        OTHERS              = 5.
    IF sy-subrc NE 2.
      RETURN.
    ENDIF.
    result = abap_true.
  ENDMETHOD.
ENDCLASS.
