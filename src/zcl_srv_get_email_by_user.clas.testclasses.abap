*"* use this source file for your ABAP unit test classes
*"* use this source file for your ABAP unit test classes
CLASS ltc_email_sender DEFINITION FOR TESTING
                                  RISK LEVEL HARMLESS
                                  DURATION SHORT.
  PUBLIC SECTION.
    METHODS:
      dogan_mail FOR TESTING,
      different_mail_duplicate FOR TESTING.
ENDCLASS.

CLASS ltc_email_sender IMPLEMENTATION.

  METHOD dogan_mail.
    DATA(exp_result) = 'dogan.pamuklu@digitay.com.tr'.
    DATA(act_result) = zcl_srv_get_email_by_user=>get_instance( )->get_data( 'DOGANP' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = act_result
        exp                  = exp_result    ).
  ENDMETHOD.


  METHOD different_mail_duplicate.
    DATA: act_result TYPE zcl_srv_get_email_by_user=>user_mails_type.
    DATA(exp_result) = VALUE zcl_srv_get_email_by_user=>user_mails_type(
                                   ( user = 'DOGANP' mail = 'dogan.pamuklu@digitay.com.tr' )
                                   ( user = 'TOLGAV' mail = 'tolgahan.varli@digitay.com.tr' ) ).

    DATA(mail) = zcl_srv_get_email_by_user=>get_instance( )->get_data( 'DOGANP' ).
    DATA(user_mail) = VALUE zcl_srv_get_email_by_user=>user_mail( user = 'DOGANP' mail = mail ).
    INSERT user_mail INTO TABLE act_result.

    mail = zcl_srv_get_email_by_user=>get_instance( )->get_data( 'TOLGAV' ).
    user_mail = VALUE zcl_srv_get_email_by_user=>user_mail( user = 'TOLGAV' mail = mail ).
    INSERT user_mail INTO TABLE act_result.

    mail = zcl_srv_get_email_by_user=>get_instance( )->get_data( 'DOGANP' ).
    user_mail = VALUE zcl_srv_get_email_by_user=>user_mail( user = 'DOGANP' mail = mail ).
    INSERT user_mail INTO TABLE act_result.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  =  act_result
        exp                  =  exp_result ).
  ENDMETHOD.

ENDCLASS.
