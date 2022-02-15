CLASS zcl_email_sender_by_user DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          !i_user    TYPE uname OPTIONAL
          !i_title   TYPE so_obj_des
          !i_content TYPE soli_tab ,
      send_mail
        RETURNING
          VALUE(result) TYPE abap_bool
        EXCEPTIONS
          zcx_email_send_fail.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      user    TYPE uname ,
      title   TYPE so_obj_des ,
      content TYPE soli_tab .
ENDCLASS.



CLASS ZCL_EMAIL_SENDER_BY_USER IMPLEMENTATION.


  METHOD constructor.
    IF i_user IS INITIAL.
      user = sy-uname.
    ELSE.
      user = i_user.
    ENDIF.
    title    = i_title.
    content  = i_content.
  ENDMETHOD.


  METHOD send_mail.
    CONSTANTS:
      obj_type_raw TYPE char3 VALUE 'HTM'.

    TRY.
        DATA(send_request) = cl_bcs=>create_persistent( ).
        DATA(sender) = cl_sapuser_bcs=>create( i_user = user ).
        send_request->set_sender( sender )..
        DATA(mail_address) = zcl_srv_get_email_by_user=>get_instance( )->get_data( user ).
        DATA(recipient) = cl_cam_address_bcs=>create_internet_address(  i_address_string = mail_address ).
        send_request->add_recipient( i_recipient     = recipient ).
        DATA(document) = cl_document_bcs=>create_document(
                            i_type    = obj_type_raw
                            i_subject = title
                            i_text    = content ).
        send_request->set_document( document ).
        send_request->send( abap_true ).
        result = abap_true.
        COMMIT WORK.
      CATCH cx_bcs INTO DATA(exception_line).
        result  = abap_false.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
