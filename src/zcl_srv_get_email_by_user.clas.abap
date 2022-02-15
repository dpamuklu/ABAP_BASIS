CLASS zcl_srv_get_email_by_user DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF user_mail,
        user TYPE uname,
        mail TYPE ad_smtpadr,
      END OF user_mail .
    TYPES:
      user_mails_type TYPE SORTED TABLE OF user_mail WITH UNIQUE KEY user .

    CLASS-METHODS get_instance
      RETURNING
        VALUE(result) TYPE REF TO zcl_srv_get_email_by_user .
    METHODS get_data
      IMPORTING
        VALUE(i_user) TYPE uname OPTIONAL
      RETURNING
        VALUE(result) TYPE ad_smtpadr .
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA:
      instance TYPE REF TO zcl_srv_get_email_by_user.
    DATA:
      user_mails TYPE user_mails_type.
ENDCLASS.



CLASS ZCL_SRV_GET_EMAIL_BY_USER IMPLEMENTATION.


  METHOD get_data.
    DATA : addresses TYPE TABLE OF bapiadsmtp,
           return    TYPE TABLE OF bapiret2.
    CHECK i_user IS NOT INITIAL.

    IF line_exists( user_mails[ user = i_user ] ).
      result = user_mails[ user = i_user ]-mail.
    ELSE.
      CALL FUNCTION 'BAPI_USER_GET_DETAIL'
        EXPORTING
          username = i_user
        TABLES
          addsmtp  = addresses
          return   = return.
      IF addresses IS NOT INITIAL AND
         sy-subrc EQ 0.
        DATA(user_mail) = VALUE user_mail( user = i_user
                                           mail = addresses[ 1 ]-e_mail ).
        INSERT user_mail INTO TABLE user_mails.
        result = addresses[ 1 ]-e_mail.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD get_instance.
    result = instance = COND #( WHEN instance IS NOT BOUND THEN NEW zcl_srv_get_email_by_user(  )
                                ELSE instance ).
  ENDMETHOD.
ENDCLASS.
