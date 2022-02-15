CLASS zcl_zodata_user_pwd_ap_dpc DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_mgw_push_abs_data
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /iwbep/if_sb_dpc_comm_services .
    INTERFACES /iwbep/if_sb_gen_dpc_injection .

    METHODS /iwbep/if_mgw_appl_srv_runtime~get_entityset
         REDEFINITION .
    METHODS /iwbep/if_mgw_appl_srv_runtime~get_entity
         REDEFINITION .
    METHODS /iwbep/if_mgw_appl_srv_runtime~update_entity
         REDEFINITION .
    METHODS /iwbep/if_mgw_appl_srv_runtime~create_entity
         REDEFINITION .
    METHODS /iwbep/if_mgw_appl_srv_runtime~delete_entity
         REDEFINITION .
  PROTECTED SECTION.

    DATA mo_injection TYPE REF TO /iwbep/if_sb_gen_dpc_injection .

    METHODS userset_create_entity
      IMPORTING
        !iv_entity_name          TYPE string
        !iv_entity_set_name      TYPE string
        !iv_source_name          TYPE string
        !it_key_tab              TYPE /iwbep/t_mgw_name_value_pair
        !io_tech_request_context TYPE REF TO /iwbep/if_mgw_req_entity_c OPTIONAL
        !it_navigation_path      TYPE /iwbep/t_mgw_navigation_path
        !io_data_provider        TYPE REF TO /iwbep/if_mgw_entry_provider OPTIONAL
      EXPORTING
        !er_entity               TYPE zcl_zodata_user_pwd_ap_mpc=>ts_user
      RAISING
        /iwbep/cx_mgw_busi_exception
        /iwbep/cx_mgw_tech_exception .
    METHODS userset_delete_entity
      IMPORTING
        !iv_entity_name          TYPE string
        !iv_entity_set_name      TYPE string
        !iv_source_name          TYPE string
        !it_key_tab              TYPE /iwbep/t_mgw_name_value_pair
        !io_tech_request_context TYPE REF TO /iwbep/if_mgw_req_entity_d OPTIONAL
        !it_navigation_path      TYPE /iwbep/t_mgw_navigation_path
      RAISING
        /iwbep/cx_mgw_busi_exception
        /iwbep/cx_mgw_tech_exception .
    METHODS userset_get_entity
      IMPORTING
        !iv_entity_name          TYPE string
        !iv_entity_set_name      TYPE string
        !iv_source_name          TYPE string
        !it_key_tab              TYPE /iwbep/t_mgw_name_value_pair
        !io_request_object       TYPE REF TO /iwbep/if_mgw_req_entity OPTIONAL
        !io_tech_request_context TYPE REF TO /iwbep/if_mgw_req_entity OPTIONAL
        !it_navigation_path      TYPE /iwbep/t_mgw_navigation_path
      EXPORTING
        !er_entity               TYPE zcl_zodata_user_pwd_ap_mpc=>ts_user
        !es_response_context     TYPE /iwbep/if_mgw_appl_srv_runtime=>ty_s_mgw_response_entity_cntxt
      RAISING
        /iwbep/cx_mgw_busi_exception
        /iwbep/cx_mgw_tech_exception .
    METHODS userset_get_entityset
      IMPORTING
        !iv_entity_name           TYPE string
        !iv_entity_set_name       TYPE string
        !iv_source_name           TYPE string
        !it_filter_select_options TYPE /iwbep/t_mgw_select_option
        !is_paging                TYPE /iwbep/s_mgw_paging
        !it_key_tab               TYPE /iwbep/t_mgw_name_value_pair
        !it_navigation_path       TYPE /iwbep/t_mgw_navigation_path
        !it_order                 TYPE /iwbep/t_mgw_sorting_order
        !iv_filter_string         TYPE string
        !iv_search_string         TYPE string
        !io_tech_request_context  TYPE REF TO /iwbep/if_mgw_req_entityset OPTIONAL
      EXPORTING
        !et_entityset             TYPE zcl_zodata_user_pwd_ap_mpc=>tt_user
        !es_response_context      TYPE /iwbep/if_mgw_appl_srv_runtime=>ty_s_mgw_response_context
      RAISING
        /iwbep/cx_mgw_busi_exception
        /iwbep/cx_mgw_tech_exception .
    METHODS userset_update_entity
      IMPORTING
        !iv_entity_name          TYPE string
        !iv_entity_set_name      TYPE string
        !iv_source_name          TYPE string
        !it_key_tab              TYPE /iwbep/t_mgw_name_value_pair
        !io_tech_request_context TYPE REF TO /iwbep/if_mgw_req_entity_u OPTIONAL
        !it_navigation_path      TYPE /iwbep/t_mgw_navigation_path
        !io_data_provider        TYPE REF TO /iwbep/if_mgw_entry_provider OPTIONAL
      EXPORTING
        !er_entity               TYPE zcl_zodata_user_pwd_ap_mpc=>ts_user
      RAISING
        /iwbep/cx_mgw_busi_exception
        /iwbep/cx_mgw_tech_exception .

    METHODS check_subscription_authority
         REDEFINITION .
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ZODATA_USER_PWD_AP_DPC IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~create_entity.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_CRT_ENTITY_BASE
*&* This class has been generated on 21.09.2021 13:37:27 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_ZODATA_USER_PWD_AP_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

    DATA userset_create_entity TYPE zcl_zodata_user_pwd_ap_mpc=>ts_user.
    DATA lv_entityset_name TYPE string.

    lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

    CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  USERSet
*-------------------------------------------------------------------------*
      WHEN 'USERSet'.
*     Call the entity set generated method
        userset_create_entity(
             EXPORTING iv_entity_name     = iv_entity_name
                       iv_entity_set_name = iv_entity_set_name
                       iv_source_name     = iv_source_name
                       io_data_provider   = io_data_provider
                       it_key_tab         = it_key_tab
                       it_navigation_path = it_navigation_path
                       io_tech_request_context = io_tech_request_context
           	 IMPORTING er_entity          = userset_create_entity
        ).
*     Send specific entity data to the caller interfaces
        copy_data_to_ref(
          EXPORTING
            is_data = userset_create_entity
          CHANGING
            cr_data = er_entity
       ).

      WHEN OTHERS.
        super->/iwbep/if_mgw_appl_srv_runtime~create_entity(
           EXPORTING
             iv_entity_name = iv_entity_name
             iv_entity_set_name = iv_entity_set_name
             iv_source_name = iv_source_name
             io_data_provider   = io_data_provider
             it_key_tab = it_key_tab
             it_navigation_path = it_navigation_path
          IMPORTING
            er_entity = er_entity
      ).
    ENDCASE.
  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~delete_entity.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_DEL_ENTITY_BASE
*&* This class has been generated on 21.09.2021 13:37:27 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_ZODATA_USER_PWD_AP_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

    DATA lv_entityset_name TYPE string.

    lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

    CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  USERSet
*-------------------------------------------------------------------------*
      WHEN 'USERSet'.
*     Call the entity set generated method
        userset_delete_entity(
             EXPORTING iv_entity_name     = iv_entity_name
                       iv_entity_set_name = iv_entity_set_name
                       iv_source_name     = iv_source_name
                       it_key_tab         = it_key_tab
                       it_navigation_path = it_navigation_path
                       io_tech_request_context = io_tech_request_context
        ).

      WHEN OTHERS.
        super->/iwbep/if_mgw_appl_srv_runtime~delete_entity(
           EXPORTING
             iv_entity_name = iv_entity_name
             iv_entity_set_name = iv_entity_set_name
             iv_source_name = iv_source_name
             it_key_tab = it_key_tab
             it_navigation_path = it_navigation_path
    ).
    ENDCASE.
  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~get_entity.
*&-----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_GETENTITY_BASE
*&* This class has been generated  on 21.09.2021 13:37:27 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_ZODATA_USER_PWD_AP_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

    DATA userset_get_entity TYPE zcl_zodata_user_pwd_ap_mpc=>ts_user.
    DATA lv_entityset_name TYPE string.
    DATA lr_entity TYPE REF TO data.

    lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

    CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  USERSet
*-------------------------------------------------------------------------*
      WHEN 'USERSet'.
*     Call the entity set generated method
        userset_get_entity(
             EXPORTING iv_entity_name     = iv_entity_name
                       iv_entity_set_name = iv_entity_set_name
                       iv_source_name     = iv_source_name
                       it_key_tab         = it_key_tab
                       it_navigation_path = it_navigation_path
                       io_tech_request_context = io_tech_request_context
           	 IMPORTING er_entity          = userset_get_entity
                       es_response_context = es_response_context
        ).

        IF userset_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = userset_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.

      WHEN OTHERS.
        super->/iwbep/if_mgw_appl_srv_runtime~get_entity(
           EXPORTING
             iv_entity_name = iv_entity_name
             iv_entity_set_name = iv_entity_set_name
             iv_source_name = iv_source_name
             it_key_tab = it_key_tab
             it_navigation_path = it_navigation_path
          IMPORTING
            er_entity = er_entity
    ).
    ENDCASE.
  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~get_entityset.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TMP_ENTITYSET_BASE
*&* This class has been generated on 21.09.2021 13:37:27 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_ZODATA_USER_PWD_AP_DPC_EXT
*&-----------------------------------------------------------------------------------------------*
    DATA userset_get_entityset TYPE zcl_zodata_user_pwd_ap_mpc=>tt_user.
    DATA lv_entityset_name TYPE string.

    lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

    CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  USERSet
*-------------------------------------------------------------------------*
      WHEN 'USERSet'.
*     Call the entity set generated method
        userset_get_entityset(
          EXPORTING
           iv_entity_name = iv_entity_name
           iv_entity_set_name = iv_entity_set_name
           iv_source_name = iv_source_name
           it_filter_select_options = it_filter_select_options
           it_order = it_order
           is_paging = is_paging
           it_navigation_path = it_navigation_path
           it_key_tab = it_key_tab
           iv_filter_string = iv_filter_string
           iv_search_string = iv_search_string
           io_tech_request_context = io_tech_request_context
         IMPORTING
           et_entityset = userset_get_entityset
           es_response_context = es_response_context
         ).
*     Send specific entity data to the caller interface
        copy_data_to_ref(
          EXPORTING
            is_data = userset_get_entityset
          CHANGING
            cr_data = er_entityset
        ).

      WHEN OTHERS.
        super->/iwbep/if_mgw_appl_srv_runtime~get_entityset(
          EXPORTING
            iv_entity_name = iv_entity_name
            iv_entity_set_name = iv_entity_set_name
            iv_source_name = iv_source_name
            it_filter_select_options = it_filter_select_options
            it_order = it_order
            is_paging = is_paging
            it_navigation_path = it_navigation_path
            it_key_tab = it_key_tab
            iv_filter_string = iv_filter_string
            iv_search_string = iv_search_string
            io_tech_request_context = io_tech_request_context
         IMPORTING
           er_entityset = er_entityset ).
    ENDCASE.
  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~update_entity.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_UPD_ENTITY_BASE
*&* This class has been generated on 21.09.2021 13:37:27 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - ZCL_ZODATA_USER_PWD_AP_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

    DATA userset_update_entity TYPE zcl_zodata_user_pwd_ap_mpc=>ts_user.
    DATA lv_entityset_name TYPE string.
    DATA lr_entity TYPE REF TO data.

    lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

    CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  USERSet
*-------------------------------------------------------------------------*
      WHEN 'USERSet'.
*     Call the entity set generated method
        userset_update_entity(
             EXPORTING iv_entity_name     = iv_entity_name
                       iv_entity_set_name = iv_entity_set_name
                       iv_source_name     = iv_source_name
                       io_data_provider   = io_data_provider
                       it_key_tab         = it_key_tab
                       it_navigation_path = it_navigation_path
                       io_tech_request_context = io_tech_request_context
           	 IMPORTING er_entity          = userset_update_entity
        ).
        IF userset_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = userset_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
      WHEN OTHERS.
        super->/iwbep/if_mgw_appl_srv_runtime~update_entity(
           EXPORTING
             iv_entity_name = iv_entity_name
             iv_entity_set_name = iv_entity_set_name
             iv_source_name = iv_source_name
             io_data_provider   = io_data_provider
             it_key_tab = it_key_tab
             it_navigation_path = it_navigation_path
          IMPORTING
            er_entity = er_entity
    ).
    ENDCASE.
  ENDMETHOD.


  METHOD /iwbep/if_sb_dpc_comm_services~commit_work.
* Call RFC commit work functionality

    IF iv_rfc_dest IS INITIAL OR iv_rfc_dest EQ 'NONE'.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          wait = abap_true.
    ELSE.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        DESTINATION iv_rfc_dest
        EXPORTING
          wait = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD /iwbep/if_sb_dpc_comm_services~get_generation_strategy.
* Get generation strategy
    rv_generation_strategy = '1'.
  ENDMETHOD.


  METHOD /iwbep/if_sb_dpc_comm_services~log_message.
* Log message in the application log
    DATA lo_logger TYPE REF TO /iwbep/cl_cos_logger.
    DATA lv_text TYPE /iwbep/sup_msg_longtext.

    MESSAGE ID iv_msg_id TYPE iv_msg_type NUMBER iv_msg_number
      WITH iv_msg_v1 iv_msg_v2 iv_msg_v3 iv_msg_v4 INTO lv_text.

    lo_logger = mo_context->get_logger( ).
    lo_logger->log_message(
      EXPORTING
       iv_msg_type   = iv_msg_type
       iv_msg_id     = iv_msg_id
       iv_msg_number = iv_msg_number
       iv_msg_text   = lv_text
       iv_msg_v1     = iv_msg_v1
       iv_msg_v2     = iv_msg_v2
       iv_msg_v3     = iv_msg_v3
       iv_msg_v4     = iv_msg_v4
       iv_agent      = 'DPC' ).
  ENDMETHOD.


  METHOD /iwbep/if_sb_dpc_comm_services~rfc_exception_handling.
* RFC call exception handling
    DATA lo_logger TYPE REF TO /iwbep/cl_cos_logger.

    lo_logger = /iwbep/if_mgw_conv_srv_runtime~get_logger( ).

    /iwbep/cl_sb_gen_dpc_rt_util=>rfc_exception_handling(
      EXPORTING
        iv_subrc            = iv_subrc
        iv_exp_message_text = iv_exp_message_text
        io_logger           = lo_logger ).
  ENDMETHOD.


  METHOD /iwbep/if_sb_dpc_comm_services~rfc_save_log.
    DATA lo_logger TYPE REF TO /iwbep/cl_cos_logger.
    DATA lo_message_container TYPE REF TO /iwbep/if_message_container.

    lo_logger = /iwbep/if_mgw_conv_srv_runtime~get_logger( ).
    lo_message_container = /iwbep/if_mgw_conv_srv_runtime~get_message_container( ).

    " Save the RFC call log in the application log
    /iwbep/cl_sb_gen_dpc_rt_util=>rfc_save_log(
      EXPORTING
        is_return            = is_return
        iv_entity_type       = iv_entity_type
        it_return            = it_return
        it_key_tab           = it_key_tab
        io_logger            = lo_logger
        io_message_container = lo_message_container ).
  ENDMETHOD.


  METHOD /iwbep/if_sb_dpc_comm_services~set_injection.
* Unit test injection
    IF io_unit IS BOUND.
      mo_injection = io_unit.
    ELSE.
      mo_injection = me.
    ENDIF.
  ENDMETHOD.


  METHOD check_subscription_authority.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
      EXPORTING
        textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
        method = 'CHECK_SUBSCRIPTION_AUTHORITY'.
  ENDMETHOD.


  METHOD userset_create_entity.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
      EXPORTING
        textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
        method = 'USERSET_CREATE_ENTITY'.
  ENDMETHOD.


  METHOD userset_delete_entity.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
      EXPORTING
        textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
        method = 'USERSET_DELETE_ENTITY'.
  ENDMETHOD.


  METHOD userset_get_entity.
    DATA(user_pwd_generator) = NEW zcl_user_pwd_generator( CONV #( it_key_tab[ 1 ]-value ) ).
    DATA(password) = user_pwd_generator->execute( ).
    TRY.
        zcl_brf_mail_sender_by_user=>execute( i_user     = CONV #( it_key_tab[ 1 ]-value )
                                              i_password = password ).
        er_entity-xubname =  it_key_tab[ 1 ]-value .
      CATCH cx_fdt.
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception.
    ENDTRY.
  ENDMETHOD.


  METHOD userset_get_entityset.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
      EXPORTING
        textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
        method = 'USERSET_GET_ENTITYSET'.
  ENDMETHOD.


  METHOD userset_update_entity.
    RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
      EXPORTING
        textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
        method = 'USERSET_UPDATE_ENTITY'.
  ENDMETHOD.
ENDCLASS.
