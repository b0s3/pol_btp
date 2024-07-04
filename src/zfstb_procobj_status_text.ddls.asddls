@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Process Status Text View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZFSTB_PROCOBJ_STATUS_TEXT as select from zfstb_procobj_st
//association [1..1] to ZFSTB_PROCOBJ_STATUS as _statustext on $projection.Status = _statustext.Status
{
  @ObjectModel.text.element: [ 'TEXT' ]
  key status as Status,
  @Semantics.language: true
  @Semantics.text: true
  text as Text
  
}
