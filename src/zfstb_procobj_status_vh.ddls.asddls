@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Status Text'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZFSTB_PROCOBJ_STATUS_VH as select from zfstb_procobj_st
//association [0..*] to ZFSTB_PROCOBJ_STATUS_TEXT as _Text on $projection.Status = _Text.Status

{
 // @UI.textArrangement: #TEXT_ONLY
 // @ObjectModel.text.association: '_Text'
  key status as Status,
  text as Text
 
  /* Associations */
 // _Text
}
