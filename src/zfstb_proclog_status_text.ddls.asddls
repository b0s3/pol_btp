@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Process Log Status-Text View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZFSTB_PROCLOG_STATUS_TEXT as select from zfstb_proclog_st
{
 @ObjectModel.text.element: [ 'TEXT' ]
  key status as Status,
 // @Semantics.language: true
  @Semantics.text: true
  text as Text
}
