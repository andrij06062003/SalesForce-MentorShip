public without sharing class ContractSentHandler{
public static void updateContactSent() {
    List<Opportunity> oppWithLineItems = [
        SELECT Id, StageName, WarningPoint__c ,(SELECT Id, Product2.Car_Status__c FROM OpportunityLineItems)
        FROM Opportunity
        WHERE Id IN :Trigger.new
    ];


    List<Product2> productsToUdpate = new List<Product2>();

    for (Opportunity opp : oppWithLineItems) {
        Opportunity oldOpp = (Opportunity) Trigger.oldMap.get(opp.Id);
        if (oldOpp != null) { 
            for (OpportunityLineItem lineItem : opp.OpportunityLineItems) {
                if (lineItem.Product2 != null) { 
                   
                    if (opp.StageName != oldOpp.StageName && opp.StageName == 'Contract Sent') {
                        lineItem.Product2.Car_Status__c = 'Reserved';
                        productsToUdpate.add(lineItem.Product2);
                    }

                    if (opp.StageName != oldOpp.StageName && opp.StageName == 'Closed Won') {
                        lineItem.Product2.Car_Status__c = 'Sold';
                        productsToUdpate.add(lineItem.Product2);
                    }

                    if (opp.StageName != oldOpp.StageName && opp.StageName == 'Closed Lost') {
                        lineItem.Product2.Car_Status__c = 'Avaible';
                        productsToUdpate.add(lineItem.Product2);
                    }

                    if (opp.StageName != oldOpp.StageName && oldOpp.StageName =='Contract Sent' && opp.StageName != 'Closed Lost' && opp.StageName != 'Closed Won') {
                        lineItem.Product2.Car_Status__c = 'Avaible';
                        productsToUdpate.add(lineItem.Product2);
                    }
                }
            }
        }
    }


    
update productsToUdpate;
   
}

}



