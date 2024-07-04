@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Log table of process API'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZFSTB_I_PROCESS_LOG 
as select from zfstb_processlog 
association to parent ZFS_R_MONITOR_PROC as ProcessObject on $projection.ProcessUuid = ProcessObject.ProcessUuid
association[0..1] to ZFSTB_PROCLOG_STATUS_TEXT as _ProcessStepStatus on $projection.ProcessStepStatus = _ProcessStepStatus.Status
association[1..1] to ZFSTB_E_PROCLOG_QV as _ProcessStepMessage on $projection.ProcessUuid = _ProcessStepMessage.process_uuid and
                                                           $projection.ProcessStepno = _ProcessStepMessage.process_stepno and
                                                           $projection.ProcessStepStatus = _ProcessStepMessage.process_step_status
                                                              
{
  key process_uuid as ProcessUuid,
  key process_stepno as ProcessStepno,
  process_stepno as ProcessStepNumber,
  @ObjectModel.foreignKey.association: '_ProcessStepMessage'
  process_step_status as ProcessStepStatus,
  //_ProcessStepMessage,
  created_by as CreatedBy,
  changed_by as ChangedBy,
  created_at as CreatedAt,
  changed_at as ChangedAt,
  reference_objectid as ReferenceObjectid,
  reference_object_typecode as ReferenceObjectTypecode,
   request as Request,
 response as Response,
 msgid as MsgID,
 msgno as MsgNo,
 msgtype as MsgType,
  ProcessObject,
  _ProcessStepStatus
, _ProcessStepMessage

}
