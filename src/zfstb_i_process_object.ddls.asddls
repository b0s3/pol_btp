@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Process Object Header table'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZFSTB_I_PROCESS_OBJECT 
as select from zfstb_processobj
{
  key process_uuid as ProcessUuid,
  process_category as ProcessCategory,
  process_status_code as ProcessStatusCode,
  created_by as CreatedBy,
  created_at as CreatedAt,
  changed_at as ChangedAt,
  reference_objectid as ReferenceObjectid,
  reference_object_typecode as ReferenceObjectTypecode,
  bupr_id as BuprId,
  bupr_type_code as BuprTypeCode,
  request as Request,
  response as Response
  
}
