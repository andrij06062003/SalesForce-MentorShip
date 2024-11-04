trigger OpportunityTrigger on Opportunity (after update, after delete) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
        
        } else if(Trigger.isUpdate) {
            
        } else if(Trigger.isDelete){
            
        }
    } else if(Trigger.isAfter){
        if(Trigger.isInsert){

        } else if(Trigger.isUpdate) {
           ClosesWonHandler.updateClosesWonHandler();
           ContractSentHandler.updateContactSent();
        } else if(Trigger.isDelete){
           // ClosesWonHandler.deleteClosesWonHandler();
        }
    } 
}