// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class AsgnRsrcApptSchdEvent {
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global String EventUuid;
    global String AssignedResourceId;
    global String ServiceResourceId;
    global Boolean IsRequiredResource;
    global Boolean IsPrimaryResource;
    global String ServiceResourceUserId;
    global String ServiceResourceUserName;
    global String ServiceResourceUserEmail;
    global Object ChangedFields;
    global List<AsyncOperationEvent> SourceEvent;
    global List<ServiceAppointmentEvent> AsgnRsrcApptSchdDtlEvent;

    global AsgnRsrcApptSchdEvent () 
    {
    }
}