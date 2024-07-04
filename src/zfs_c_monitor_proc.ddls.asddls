@EndUserText.label: 'Projection view for monitoring API'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZFS_C_MONITOR_PROC
  provider contract transactional_query 
as projection on ZFS_R_MONITOR_PROC
{
  key ProcessUuid,
  ProcessCategory,
  _ProcessStatus.Text as text,
  @Consumption.valueHelpDefinition: [{ entity : {
                                                   name : 'ZFSTB_PROCOBJ_STATUS_VH',
                                                   element: 'Status' } }]
  @ObjectModel.text.element: [ 'text' ]  
  //@Consumption.semanticObject: 'StatusMessage'                                              
  ProcessStatusCode,
  CreatedBy,
  CreatedAt,
  ChangedAt,
  ReferenceObjectid,
  ReferenceObjectTypecode,
  BuprId,
  BuprTypeCode,
Request,
Response,
  /* Associations */
  ProcessLog : redirected to composition child ZFSTB_C_PROCESS_LOG
}

