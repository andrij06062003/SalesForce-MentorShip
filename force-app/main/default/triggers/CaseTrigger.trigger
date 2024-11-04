trigger CaseTrigger on Case (before insert , after insert) {
  
    if(Trigger.isBefore){
        if(Trigger.isInsert){
           
        } else if(Trigger.isUpdate) {
         
        } else if(Trigger.isDelete){
            
        }
    } else if(Trigger.isAfter){
        if(Trigger.isInsert){
           CaseCreateHandler.createCaseWithVin();
        } else if(Trigger.isUpdate) {
        
        } else if(Trigger.isDelete){
           
        }
    } 

}