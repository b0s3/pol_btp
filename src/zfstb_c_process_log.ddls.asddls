@EndUserText.label: 'Consumption For Process Log'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZFSTB_C_PROCESS_LOG as projection on ZFSTB_I_PROCESS_LOG
redefine association ProcessObject  redirected to parent ZFS_C_MONITOR_PROC 

 {
  key ProcessUuid,
  key ProcessStepno,
  
  ProcessStepNumber,
  _ProcessStepStatus.Text as text,

  @ObjectModel.text.element: [ 'text' ]
 //@Consumption.semanticObject: 'StatusMessage'   
   ProcessStepStatus,
  CreatedBy,
  ChangedBy,
  CreatedAt,
  ChangedAt,
  ReferenceObjectid,
  ReferenceObjectTypecode,
Request,
Response,
MsgID,
MsgNo,
MsgType,
  ProcessObject,
_ProcessStepStatus
, _ProcessStepMessage     
}
