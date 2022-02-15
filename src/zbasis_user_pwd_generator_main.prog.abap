START-OF-SELECTION.
  TRY.
      DATA(result) = NEW zcl_user_pwd_mail_model( p_uname )->execute( ).
      IF result EQ abap_false.
        MESSAGE i001(zbasis).
      ELSE.
        MESSAGE s000(zbasis) WITH p_uname.
      ENDIF.
    CATCH /iwbep/cx_mgw_busi_exception INTO DATA(exc).
      MESSAGE exc->get_text( ) TYPE if_xo_const_message=>error.
  ENDTRY.
