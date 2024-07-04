@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root view for process monitoring'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define root view entity ZFS_R_MONITOR_PROC 
as select from ZFSTB_I_PROCESS_OBJECT
composition[1..*] of ZFSTB_I_PROCESS_LOG as ProcessLog
association[0..1] to ZFSTB_PROCOBJ_STATUS_TEXT as _ProcessStatus on $projection.ProcessStatusCode = _ProcessStatus.Status
//association[1..*] to ZFSTB_I_PROCESS_LOG as ProcessLog on ProcessLog.ProcessUuid = $projection.ProcessUuid
{
/*@UI.lineItem: [{ position: 10 },
                 { type: #FOR_ACTION,
                   dataAction: 'RetryProcessObject' ,
                   label: 'Retry'}]
  @UI.selectionField: [{ position: 10 }] */
//  @UI.textArrangement: #TEXT_ONLY
//  @UI.dataPoint: { qualifier: 'StatusData', title: 'Status' }

key ZFSTB_I_PROCESS_OBJECT.ProcessUuid,
//@UI.lineItem: [{ position: 20 }]
ZFSTB_I_PROCESS_OBJECT.ProcessCategory,
//@UI.lineItem: [{ position: 30 }]
ZFSTB_I_PROCESS_OBJECT.ProcessStatusCode,
//@UI.lineItem: [{ position: 40 }]
ZFSTB_I_PROCESS_OBJECT.CreatedBy,
//@UI.lineItem: [{ position: 50 }]
ZFSTB_I_PROCESS_OBJECT.CreatedAt,
//@UI.lineItem: [{ position: 60 }]
ZFSTB_I_PROCESS_OBJECT.ChangedAt,
//@UI.lineItem: [{ position: 70 }]
//@UI.selectionField: [{ position: 20 }]
ZFSTB_I_PROCESS_OBJECT.ReferenceObjectid,
//@UI.lineItem: [{ position: 80 }]
ZFSTB_I_PROCESS_OBJECT.ReferenceObjectTypecode,
//@UI.lineItem: [{ position: 90 }]
ZFSTB_I_PROCESS_OBJECT.BuprId,
//@UI.lineItem: [{ position: 100 }]
ZFSTB_I_PROCESS_OBJECT.BuprTypeCode,
ZFSTB_I_PROCESS_OBJECT.Request,
ZFSTB_I_PROCESS_OBJECT.Response,
ProcessLog,
_ProcessStatus
//@ObjectModel.virtualElement: true
//@ObjectModel.virtualElementCalculatedBy:''
// cast(' ' as abap.char( 1333 ) ) as payload
}
