trigger ProductTrigger on Product2 ( after update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
        
        } else if(Trigger.isUpdate) {
            
        } else if(Trigger.isDelete){
            
        }
    } else if(Trigger.isAfter){
        if(Trigger.isInsert){

        } else if(Trigger.isUpdate) {
           Product2Handler.checkCarStatus();
        } else if(Trigger.isDelete){
           
        }
    } 
}