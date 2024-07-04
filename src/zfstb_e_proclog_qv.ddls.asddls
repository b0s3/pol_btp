@AbapCatalog.sqlViewName: 'ZQVMSG1'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Quick view status'
define view ZFSTB_E_PROCLOG_QV as select from zfstb_processlog
association[0..1] to ZFSTB_PROCLOG_STATUS_TEXT as _Text on $projection.process_step_status = _Text.Status
{
key process_uuid as process_uuid,
key process_stepno as process_stepno,
key process_step_status as process_step_status,
_Text.Text as StatusText,
case msgtype
when ' ' then 'No message exists'
else
 'Message exists' end as MessageExistsText,

msgid as msgid,
msgno as msgno,
msgtype as msgtype,
// @ObjectModel.readOnly: true
// @ObjectModel.virtualElement: true 
// @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CDS_FUNCTION'
cast( '' as abap.char( 255 )) as text

}
