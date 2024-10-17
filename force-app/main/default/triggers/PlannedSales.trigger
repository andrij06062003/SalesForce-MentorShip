trigger PlannedSales on Planned_Sales__c (before insert ,before update) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
         PlannedSalesHandler.updatePlannedSales();
        } else if(Trigger.isUpdate) {
         PlannedSalesHandler.updatePlannedSales();
        } else if(Trigger.isDelete){
            
        }
    } else if(Trigger.isAfter){
        if(Trigger.isInsert){

        } else if(Trigger.isUpdate) {
           // ContractSentHandler.updateContactSent();
        } else if(Trigger.isDelete){
           // ClosesWonHandler.deleteClosesWonHandler();
        }
    } 
}
    
