// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class VoiceChnlInteractionEvent {
    global Id Id;
    global SObject Owner;
    global Id OwnerId;
    global Boolean IsDeleted;
    global String Name;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global SObject Source;
    global Id SourceId;
    global String SourceType;
    global SObject Context;
    global Id ContextId;
    global String VendorCallKey;
    global Datetime EventTimeStamp;
    global CallCenter ContactCenter;
    global Id ContactCenterId;
    global List<VoiceChnlInteractionEventShare> Shares;
    global List<VoiceChnlIntrctnDtlEvent> VoiceChnlInteractionEvents;
    global List<FlowExecutionErrorEvent> ContextRecord;
    global List<FlowRecordRelation> RelatedRecord;

    global VoiceChnlInteractionEvent () 
    {
    }
}