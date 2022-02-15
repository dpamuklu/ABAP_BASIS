CLASS zcl_pwd_mail_content_setter DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CONSTANTS:
      new_line_start_tag TYPE char04 VALUE '<br>',
      new_line_end_tag   TYPE char05 VALUE '</br>',
      bold_tag           TYPE char03 VALUE '<b>',
      bold_end_tag       TYPE char04 VALUE '</b>'.
    METHODS:
      constructor
        IMPORTING
          i_user     TYPE uname
          i_password TYPE as4text,
      get_content
        RETURNING
          VALUE(result) TYPE soli_tab.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      content TYPE soli_tab.
ENDCLASS.



CLASS ZCL_PWD_MAIL_CONTENT_SETTER IMPLEMENTATION.


  METHOD constructor.
    DATA(content_line) = |Merhaba { i_user }|.
    APPEND content_line TO content.
    content_line = |{ new_line_start_tag }{ new_line_end_tag }|.
    APPEND content_line TO content.
    content_line = |{ new_line_start_tag } İlk giriş şifreniz { bold_tag }{ i_password }{ bold_end_tag }|.
    APPEND content_line TO content.
    content_line = |olarak yenilenmiştir.{ new_line_end_tag }|.
    APPEND content_line TO content.
    content_line = |{ new_line_start_tag }Bu şifre ile giriş yaptıktan sonra, |.
    APPEND content_line TO content.
    content_line = |şifrenizi tekrar değiştirebilirsiniz.{ new_line_end_tag }|.
    APPEND content_line TO content.
    content_line = |{ new_line_start_tag }İyi çalışmalar.{ new_line_end_tag }|.
    APPEND content_line TO content.
  ENDMETHOD.


  METHOD get_content.
    result = content.
  ENDMETHOD.
ENDCLASS.
