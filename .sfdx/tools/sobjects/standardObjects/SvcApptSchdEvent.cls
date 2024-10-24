// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class SvcApptSchdEvent {
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global String EventUuid;
    global String ServiceAppointmentId;
    global String ParentRecordId;
    global String ContactId;
    global Datetime ScheduledStartTime;
    global Datetime ScheduledEndTime;
    global Double DurationInMinutes;
    global String WorkTypeId;
    global String ServiceTerritoryId;
    global String Address;
    global String Status;
    global String StatusCategory;
    global String AppointmentType;
    global String Phone;
    global String Email;
    global String Subject;
    global String Comments;
    global String AdditionalInformation;
    global Integer WorkTypeBlockTimeBeforeAppointment;
    global Integer WorkTypeBlockTimeAfterAppointment;
    global String WorkTypeBlockTimeBeforeUnit;
    global String WorkTypeBlockTimeAfterUnit;
    global Object ChangedFields;
    global List<AsyncOperationEvent> SourceEvent;
    global List<ServiceAppointmentEvent> ServiceApptSchduleEvent;

    global SvcApptSchdEvent () 
    {
    }
}