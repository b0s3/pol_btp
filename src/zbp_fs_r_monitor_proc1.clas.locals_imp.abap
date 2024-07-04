CLASS lhc_zfstb_i_process_log DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zfstb_i_process_log RESULT result.

    METHODS displayPayload1 FOR MODIFY
      IMPORTING keys FOR ACTION zfstb_i_process_log~displayPayload1 RESULT result.
    METHODS displayError FOR MODIFY
      IMPORTING keys FOR ACTION zfstb_i_process_log~displayError RESULT result.

ENDCLASS.

CLASS lhc_zfstb_i_process_log IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD displayPayload1.
    APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<fl_result1>).
*  <fl_result1>-%param-InputRequest = 'ABCD'.
  ENDMETHOD.

  METHOD displayError.
*    DATA(ls_key) = keys[  1 ].
*    DATA(lv_processuuid) = ls_key-ProcessUuid.
*    DATA(lv_stepno) = ls_key-ProcessStepno.
*    DATA: lv_xpayload TYPE xstring,
*          lt_xml_data TYPE /iwfnd/sutil_transport_t,
*          lv_message1 TYPE string,
*          lv_message  TYPE string,
*          lv_payload  TYPE string.


*    SELECT FROM ZFSTB_PROCESSLOG FIELDS output_response
*           WHERE process_uuid = @lv_processuuid AND process_stepno = @lv_stepno AND process_step_status = 4
*           INTO @DATA(lv_response).
*    ENDSELECT.
*
*    lv_xpayload = lv_response.
*    CALL FUNCTION 'ECATT_CONV_XSTRING_TO_STRING'
*    EXPORTING
*      im_xstring = lv_xpayload
**     im_encoding = 'UTF-8'
*    IMPORTING
*      ex_string  = lv_payload.
*
**    SPLIT lv_payload AT CL_ABAP_CHAR_UTILITIES=>NEWLINE INTO: TABLE <LT_TABLE> .
*
**     CALL TRANSFORMATION id SOURCE XML lv_payload RESULT root = lt_xml_data.
*
*
*  DATA : LV_STRING TYPE STRING .
*  TYPES: BEGIN OF TY_STRING,
*      STR(100) TYPE C,
*      END OF TY_STRING.
*  DATA IT_STRING TYPE TABLE OF TY_STRING.
*  LV_STRING = lv_payload.
*  SPLIT LV_STRING AT 'message":"' INTO TABLE IT_STRING .
*   READ TABLE IT_STRING INDEX 3 INTO lv_message1.
*  SPLIT lv_message1 AT ',' INTO TABLE IT_STRING .
*   READ TABLE IT_STRING INDEX 1 INTO lv_message.
*
*
*
*
**DATA(lv_msg) = me->new_message(
**            id = 'ZMSG_PAYLOAD'
**            number = 001
**            severity = ms-information
**            v1  =  lv_message ).
**        DATA ls_record LIKE LINE of reported-zfstb_i_process_log.
**        ls_record-%msg = lv_msg.
**        APPEND ls_record to reported-zfstb_i_process_log.
**
**        DATA ls_fail LIKE LINE OF failed-zfs_r_monitor_proc.
**        APPEND ls_fail to failed-zfs_r_monitor_proc.
*
*
*
*
*    APPEND INITIAL LINE TO reported-zfstb_i_process_log   ASSIGNING FIELD-SYMBOL(<fl_report1>).
**      <fl_report1>-ProcessUuid = lv_processuuid.
*      <fl_report1>-%msg = new_message_with_text(
*                                                                      severity = CONV #( 'S' )
*                                                                      text = lv_message
*
*                                                                                         ) .
*
*
*
*
**/iwfnd/cl_sutil_xml_helper=>move_xstring_to_table( EXPORTING
**                                                         iv_xvalue = lv_xpayload
**                                                       IMPORTING
**                                                         et_transport_data = lt_xml_data ).

  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZFS_R_MONITOR_PROC DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zfs_r_monitor_proc RESULT result.

    METHODS RetryProcessObject FOR MODIFY
      IMPORTING keys FOR ACTION zfs_r_monitor_proc~RetryProcessObject    RESULT result.

    METHODS displaypayload FOR MODIFY
      IMPORTING keys FOR ACTION zfs_r_monitor_proc~displayPayload RESULT result.


ENDCLASS.

CLASS lhc_ZFS_R_MONITOR_PROC IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD RetryProcessObject.

*
*    CONSTANTS: lc_iflow_bupr_type_code TYPE char6 VALUE '999999',
*               lc_disc                 TYPE string VALUE 'DISCH',
*             "  lc_integsuite_dest      TYPE rfcdes-rfcdest VALUE 'ZFIONEERBTP_INTEGRATION_SUITE',
*               lc_integsuite_dest     TYPE rfcdes-rfcdest VALUE 'TRBK_IFLOW_CONNECTION',
*               lc_q                    TYPE char1 VALUE '?'.
*
*    DATA: lv_refid  TYPE string,
*          lo_client TYPE REF TO if_http_client.
*
*
*    DATA(lv_test) = 1.
*    DATA(ls_key) = keys[  1 ].
*    DATA(lv_processuuid) = ls_key-ProcessUuid.
*   "data(lv_processuuid)  = ls_key-%cid.
*
*
*    " To fetch the Reference object id and process category to to check if it is iflow triggered process object
*
*    SELECT FROM zfstb_processobj FIELDS process_uuid, bupr_type_code, process_category
*    WHERE process_uuid = @lv_processuuid INTO @DATA(ls_processobj).
*    ENDSELECT.
*
*    "Check the BUPR type code to verify if it is was triggered from Integration Flows
*    IF ls_processobj-bupr_type_code = lc_iflow_bupr_type_code.
*
*      lv_refid = ls_processobj-process_uuid.
*      DATA(lv_uuid) =  |{ lv_refid(8) }-{ lv_refid+8(4) }-{ lv_refid+12(4) }-{ lv_refid+16(4) }-{ lv_refid+20 }|.
*
*
*        TRY.
*            "Create HTTP Destination
*            CALL METHOD cl_http_client=>create_by_destination
*              EXPORTING
*                destination              = lc_integsuite_dest
*              IMPORTING
*                client                   = lo_client
*              EXCEPTIONS
*                argument_not_found       = 1
*                destination_not_found    = 2
*                destination_no_authority = 3
*                plugin_not_active        = 4
*                internal_error           = 5
*                OTHERS                   = 6.
*
*            IF sy-subrc = 1.
*              RAISE EXCEPTION TYPE cx_web_http_client_error MESSAGE e002(cm_web_http_error).
*            ELSEIF sy-subrc = 2.
*              RAISE EXCEPTION TYPE cx_web_http_client_error MESSAGE e011(cm_web_http_error) WITH lc_integsuite_dest.
*            ELSEIF sy-subrc <> 0.
*              RAISE EXCEPTION TYPE cx_web_http_client_error MESSAGE e002(cm_web_http_error).
*            ENDIF.
*
*          CATCH cx_web_http_client_error INTO DATA(lc_error_msg).
*            DATA(lv_error_msg) = lc_error_msg->get_text( ).
*            DATA(lv_error_id) = lc_error_msg->get_message_id(  ).
*
*        ENDTRY.
*
*          "Check if it payoff process
*         IF ls_processobj-process_category = lc_disc.
*
*        "Create a URI for the payoff retry iflow
*        DATA(lc_disc_retry_iflow) =  '/http/processObject/reprocess'.
*        DATA(lv_retry_uri) = |{ lc_disc_retry_iflow }{ lc_q }{ lv_uuid }|.
*
*        "Set the payoff retry request URI
*        lo_client->request->set_header_field( name  = '~request_uri'   value = lv_retry_uri ).
*        lo_client->request->set_method( if_http_request=>co_request_method_post ).
*
*        "Send the request
*        CALL METHOD lo_client->send
*          EXCEPTIONS
*            http_communication_failure = 1
*            http_invalid_state         = 2
*            http_processing_failed     = 3
*            http_invalid_timeout       = 4
*            OTHERS                     = 5.
*        IF sy-subrc = 0.
*          "Receive the Response
*          CALL METHOD lo_client->receive
*            EXCEPTIONS
*              http_communication_failure = 1
*              http_invalid_state         = 2
*              http_processing_failed     = 3
*              OTHERS                     = 4.
*          IF sy-subrc <> 0.
*
*            lo_client->get_last_error(
*         IMPORTING
*           code           = DATA(lv_error_code)
*           message        = lv_error_msg
*           message_class  = DATA(lv_error_msag)
*           message_number = DATA(lv_error_number)
*       ).
*
*            IF lv_error_msg IS NOT INITIAL.
*              RAISE EXCEPTION TYPE cx_web_http_client_error MESSAGE ID 'OO' NUMBER '000' WITH lv_error_msg.
*            ELSE.
*              RAISE EXCEPTION TYPE cx_web_http_client_error MESSAGE ID lv_error_msag TYPE 'E' NUMBER lv_error_number.
*            ENDIF.
*          ENDIF.
*        ELSE.
*          lo_client->get_last_error(
*          IMPORTING
*            code           =  lv_error_code
*            message        = lv_error_msg
*            message_class  = lv_error_msag
*            message_number = lv_error_number
*        ).
*
*          IF lv_error_msg IS NOT INITIAL.
*            RAISE EXCEPTION TYPE cx_web_http_client_error MESSAGE ID 'OO' NUMBER '000' WITH lv_error_msg.
*          ELSE.
*            RAISE EXCEPTION TYPE cx_web_http_client_error MESSAGE ID lv_error_msag TYPE 'E' NUMBER lv_error_number.
*          ENDIF.
*
*        ENDIF.
*
*        "check the reponse to validate if the IFLOW Retry was triggered
*
*        DATA(lv_iflow_response) =  lo_client->response->get_cdata( ).  "lv_uuid.
*        "if lv_iflow_response+9(36) eq lv_uuid.
*
*        " endif.
*
*        lo_client->close( ).
*
*        FREE lo_client.
*
*      ENDIF.
*
*      APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<fl_resulta>).
*     <fl_resulta>-ProcessUuid = lv_processuuid. "test
* "      <fl_resulta>-%cid = lv_processuuid. "added
*      <fl_resulta>-%param-ProcessUuid = lv_processuuid.  "test
*     <fl_resulta>-%key-ProcessUuid = lv_processuuid.
*      "  <fl_resulta>-%param-%key-ProcessUuid = lv_processuuid.  "added
*
*      APPEND INITIAL LINE TO mapped-zfs_r_monitor_proc   ASSIGNING FIELD-SYMBOL(<fl_mappedi>).
*      <fl_mappedi>-ProcessUuid = lv_processuuid.
*      IF lv_error_msg IS INITIAL. "and lv_iflow_response+9(36) eq lv_uuid." Error scenario
*        APPEND INITIAL LINE TO reported-zfs_r_monitor_proc   ASSIGNING FIELD-SYMBOL(<fl_reporti>).
*        <fl_reporti>-ProcessUuid = lv_processuuid.
*        <fl_reporti>-%msg = new_message( id = 'BCA_AM_OBL_GEN_MSG'
*                                                                        number = '000'
*                                                                        severity = CONV #( 'S' )
*                                                                        v1 = 'Retry was'
*                                                                        v2 = 'Successful'
*                                                                        v3 = lv_iflow_response
*                                                                        v4 = '' ) .
*      ELSE.
*        APPEND INITIAL LINE TO reported-zfs_r_monitor_proc   ASSIGNING FIELD-SYMBOL(<fl_reportk>).
*        <fl_reportk>-ProcessUuid = lv_processuuid.
*        <fl_reportk>-%msg = new_message( id = 'BCA_AM_OBL_GEN_MSG'
*                                                                        number = '000'
*                                                                        severity = CONV #( 'S' )
*                                                                        v1 = 'Retry was Unsuccessful'
*                                                                        v2 = lv_error_msg
*                                                                        v3 = lv_error_msag
*                                                                        v4 = lv_error_code ) .
*      ENDIF.
*
*    ELSE.
*
*
*      SELECT FROM /sappo/order_hdr FIELDS order_id WHERE main_objkey = @lv_processuuid INTO @DATA(lv_orderid).
*      ENDSELECT.
*
*      DATA: o_execution_error  TYPE REF TO cx_ech_execution_error,
*            o_payload_provider TYPE REF TO cx_feh_payload_provider_dyn,
*            p_exec_failed      TYPE xfeld,
*            f_message          TYPE bapiret2,
*            lv_idata           TYPE REF TO string,
*            l_persistency_key  TYPE string,
*            f_process          TYPE ech_str_process,
*            f_order_key        TYPE /sappo/str_order_key,
*            p_handle           TYPE ech_dte_handle,
*            o_persistency      TYPE REF TO if_ech_persistency,
*            lo_feh_config      TYPE REF TO if_ech_configuration,
*            mo_ech_action      TYPE REF TO if_ech_action,
*            lt_order_key       TYPE /sappo/tab_order_key,
*            ls_order_key       TYPE /sappo/str_order_key,
*            lt_order_hdr       TYPE /sappo/tab_order_hdr,
*            ls_order_hdr       LIKE LINE OF lt_order_hdr.
*
*      ls_order_key-order_id = lv_orderid.
*      APPEND ls_order_key TO lt_order_key.
*
*      CALL FUNCTION '/SAPPO/API_PROCESS_GET_DETAIL'
*        EXPORTING
*          i_tab_order_key = lt_order_key
*        IMPORTING
*          e_tab_order_hdr = lt_order_hdr.
*
*      LOOP AT lt_order_hdr INTO ls_order_hdr.
*      ENDLOOP.
*
*      f_process-component = ls_order_hdr-component.
*      f_process-process = ls_order_hdr-business_process.
*      f_order_key-order_id = lv_orderid.
*      l_persistency_key = lv_orderid.
*
**-- Get instance for ECH configuration
*      lo_feh_config = cl_ech_configuration=>s_create(  ).
*
*      TRY.
*          mo_ech_action = lo_feh_config->get_action( f_process ).
*        CATCH cx_ech_execution_error INTO o_execution_error.
** Action class not defined...
*          RAISE EXCEPTION TYPE /sappo/cx_execution_error
*            EXPORTING
*              previous = o_execution_error.
*      ENDTRY.
*
**-- Determine the persistency class
*      o_persistency = lo_feh_config->get_persistency( i_key = l_persistency_key i_str_process = f_process ).
*
*      CALL FUNCTION '/SAPPO/API_PO_ORDER_GET_DATA'
*        EXPORTING
*          i_str_order_key       = f_order_key
*        IMPORTING
*          i_data                = p_handle
*        EXCEPTIONS
*          import_from_db_failed = 1
*          OTHERS                = 2.
*      CREATE DATA lv_idata.
*
*      TRY.
*          lv_idata = o_persistency->load( p_handle ).
*        CATCH cx_feh_payload_provider_dyn INTO o_payload_provider.
*          RAISE EXCEPTION TYPE /sappo/cx_execution_error
*            EXPORTING
**             TEXTID   =
*              previous = o_payload_provider.
*      ENDTRY.
*
*      CALL METHOD mo_ech_action->retry
*        EXPORTING
*          i_error_object_id  = f_order_key-order_id
*          i_data             = lv_idata
*        IMPORTING
*          e_execution_failed = p_exec_failed
*          e_return_message   = f_message.
*
*
**      APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<fl_result>).
**      <fl_result>-ProcessUuid = lv_processuuid.
**      <fl_result>-%param-ProcessUuid = lv_processuuid.
**      <fl_result>-%key-ProcessUuid = lv_processuuid.
**
**       APPEND INITIAL LINE TO mapped-zfs_r_monitor_proc   ASSIGNING FIELD-SYMBOL(<fl_mapped1>).
**       <fl_mapped1>-ProcessUuid = lv_processuuid.
*
**      APPEND INITIAL LINE TO reported-zfs_r_monitor_proc   ASSIGNING FIELD-SYMBOL(<fl_report>).
**      <fl_report>-ProcessUuid = lv_processuuid.
**      <fl_report>-%msg = new_message( id = 'BCA_AM_OBL_GEN_MSG'
**                                                                      number = '000'
**                                                                      severity = CONV #( 'E' )
**                                                                      v1 = 'Retry was'
**                                                                      v2 = 'UnSuccessful'
**                                                                      v3 = ' '
**                                                                      v4 = '' ) .
*
**      APPEND INITIAL LINE TO reported-zfstb_i_process_log ASSIGNING FIELD-SYMBOL(<fl_rep_log>).
**        <fl_rep_log>-%msg = new_message( id = 'BCA_AM_OBL_GEN_MSG'
**                                                                      number = '000'
**                                                                      severity = CONV #( 'E' )
**                                                                      v1 = 'Retry was'
**                                                                      v2 = 'Unsuccessful'
**                                                                      v3 = ' '
**                                                                      v4 = '' ).
**      <fl_rep_log>-ProcessUuid = lv_processuuid.
***      <fl_rep_log>-%key-ProcessUuid = lv_processuuid.
**      <fl_rep_log>-%msg = new_message_with_text( text = 'Retry was unsuccessful'
**                                                 severity = if_abap_behv_message=>severity-error ).
*
**    ELSE.
*
*      APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<fl_result1>).
*     " <fl_result1>-ProcessUuid = lv_processuuid.
*     " <fl_result1>-%param-ProcessUuid = lv_processuuid.
*    "  <fl_result1>-%key-ProcessUuid = lv_processuuid.
*
**      Check
*     <fl_resulta>-ProcessUuid = lv_processuuid. "test
* "      <fl_resulta>-%cid = lv_processuuid. "added
*      <fl_resulta>-%param-ProcessUuid = lv_processuuid.  "test
*     <fl_resulta>-%key-ProcessUuid = lv_processuuid.
*"        <fl_resulta>-%param-%key-ProcessUuid = lv_processuuid.  "added
*        "Check
*
*      APPEND INITIAL LINE TO mapped-zfs_r_monitor_proc   ASSIGNING FIELD-SYMBOL(<fl_mapped>).
*      <fl_mapped>-ProcessUuid = lv_processuuid.
*      IF p_exec_failed = abap_false." Error scenario
*        APPEND INITIAL LINE TO reported-zfs_r_monitor_proc   ASSIGNING FIELD-SYMBOL(<fl_report1>).
*        <fl_report1>-ProcessUuid = lv_processuuid.
*        <fl_report1>-%msg = new_message( id = 'BCA_AM_OBL_GEN_MSG'
*                                                                        number = '000'
*                                                                        severity = CONV #( 'S' )
*                                                                        v1 = 'Retry was'
*                                                                        v2 = 'Successful'
*                                                                        v3 = f_message-id
*                                                                        v4 = f_message-number ) .
*      ELSE.
*        APPEND INITIAL LINE TO reported-zfs_r_monitor_proc   ASSIGNING FIELD-SYMBOL(<fl_report>).
*        <fl_report>-ProcessUuid = lv_processuuid.
*        <fl_report>-%msg = new_message( id = 'BCA_AM_OBL_GEN_MSG'
*                                                                        number = '000'
*                                                                        severity = CONV #( 'S' )
*                                                                        v1 = 'Retry was'
*                                                                        v2 = 'Unsuccessful'
*                                                                        v3 = ' '
*                                                                        v4 = '' ) .
*
**      <fl_report1>-%msg = new_message_with_text( text = 'Retry was successful'
**                                                 severity = if_abap_behv_message=>severity-success ).
**     APPEND INITIAL LINE TO reported-zfstb_i_process_log ASSIGNING FIELD-SYMBOL(<fl_rep_log1>).
***           <fl_rep_log1>-ProcessUuid = lv_processuuid.
***      <fl_rep_log1>-%key-ProcessUuid = lv_processuuid.
**      <fl_rep_log1>-%msg = new_message_with_text( text = 'Retry was successful'
**                                                 severity = if_abap_behv_message=>severity-success ).
*
*      ENDIF.
*    ENDIF.
  ENDMETHOD.

  METHOD displaypayload.
*    DATA(lv_test) = 1.
*    DATA(ls_key) = keys[  1 ].
*    DATA(lv_processuuid) = ls_key-ProcessUuid.
*
*    SELECT FROM /sappo/order_hdr FIELDS order_id WHERE main_objkey = @lv_processuuid INTO @DATA(lv_orderid).
*    ENDSELECT.
*
*    DATA: o_payload_provider  TYPE REF TO cx_feh_payload_provider_dyn,
*          lv_idata            TYPE REF TO string,
*          l_persistency_key   TYPE string,
*          f_process           TYPE ech_str_process,
*          f_order_key         TYPE /sappo/str_order_key,
*          p_handle            TYPE ech_dte_handle,
*          o_persistency       TYPE REF TO if_ech_persistency,
*          lo_feh_config       TYPE REF TO if_ech_configuration,
*          lo_class            TYPE REF TO cl_pco_utility,
*          lv_IV_SQL_DATA_TYPE TYPE s_pco_sql_data_type VALUE 1,
*          lv_IV_CONV_FLOAT    TYPE boole_d,
*          lv_payload          TYPE string.
*
*    f_process-component = 'FS-AM'.
*    f_process-process = 'MIF_DISCH'.
*    f_order_key-order_id = lv_orderid.
*    l_persistency_key = lv_orderid.
*
**-- Get instance for ECH configuration
*    lo_feh_config = cl_ech_configuration=>s_create(  ).
*
**-- Determine the persistency class
*    o_persistency = lo_feh_config->get_persistency( i_key = l_persistency_key i_str_process = f_process ).
*
*    CALL FUNCTION '/SAPPO/API_PO_ORDER_GET_DATA'
*      EXPORTING
*        i_str_order_key       = f_order_key
*      IMPORTING
*        i_data                = p_handle
*      EXCEPTIONS
*        import_from_db_failed = 1
*        OTHERS                = 2.
*    CREATE DATA lv_idata.
*
*    TRY.
*        lv_idata = o_persistency->load( p_handle ).
*      CATCH cx_feh_payload_provider_dyn INTO o_payload_provider.
*        RAISE EXCEPTION TYPE /sappo/cx_execution_error
*          EXPORTING
**           TEXTID   =
*            previous = o_payload_provider.
*    ENDTRY.
*
*    CREATE OBJECT lo_class.
*    APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<fl_result1>).
*
*
*    CALL METHOD lo_class->convert_dref_to_string
*      EXPORTING
*        iv_conv_float    = lv_IV_CONV_FLOAT
*        iv_sql_data_type = lv_IV_SQL_DATA_TYPE
*        ir_data_ref      = lv_idata
*      IMPORTING
*        ev_data_string   = lv_payload.
**<fl_result1>-%param-InputRequest = 'ABCD'.
*
*    DATA(lv_message) = me->new_message_with_text(
*    text = lv_payload
*                       ) .
*
*    DATA ls_record LIKE LINE OF reported-zfstb_i_process_log.
*    ls_record-%msg = lv_message.
*    APPEND ls_record TO reported-zfstb_i_process_log.
*
*    DATA ls_fail LIKE LINE OF failed-zfstb_i_process_log.
*    APPEND ls_fail TO failed-zfstb_i_process_log.
*
**    APPEND ls_fail to failed-zfs_r_monitor_proc.
*
**APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<fl_result>).
**      <fl_result>-ProcessUuid = lv_processuuid.
**      <fl_result>-%param-ProcessUuid = lv_processuuid.
*
**    APPEND INITIAL LINE TO reported-zfs_r_monitor_proc   ASSIGNING FIELD-SYMBOL(<fl_report>).
**     <fl_report>-ProcessUuid = lv_processuuid.
**     <fl_report>- = new_message_with_text( text = lv_payload
***                                                severity = if_abap_behv_message=>severity-error ).
*
*
  ENDMETHOD.

ENDCLASS.
