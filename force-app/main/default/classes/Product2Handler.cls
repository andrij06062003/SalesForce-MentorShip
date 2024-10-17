/**
 * @description       : 
 * @author            : Svyatoslav Andrushchak
 * @group             : 
 * @last modified on  : 10-15-2024
 * @last modified by  : Svyatoslav Andrushchak
**/
public with sharing class Product2Handler {
    
   // after update
    public static void checkCarStatus() {

        Set<Id> reservedCarIds = new Set<Id>(); 
        Set<Id> notReservedOrSoldIds = new Set<Id>();

        for(Product2 car : (List<Product2>)Trigger.new){
            // If Car Status Changed and New Value is Reserved
            // Trigger.old -> List<Product2>
            // Trigger.oldMap -> Map<Id, Product2>
            if(car.Car_Status__c != ((Product2)Trigger.oldMap.get(car.Id)).Car_Status__c && (car.Car_Status__c == 'Reserved' || car.Car_Status__c == 'Sold')){
                reservedCarIds.add(car.Id);
            }
            else if (((Product2)Trigger.oldMap.get(car.Id)).Car_Status__c == 'Reserved' ||  ((Product2)Trigger.oldMap.get(car.Id)).Car_Status__c == 'Sold')  {
                notReservedOrSoldIds.add(car.Id);
            }
        }
        System.debug(reservedCarIds);
        if(reservedCarIds.isEmpty() && notReservedOrSoldIds.isEmpty()){
            return;
        }

        List<OpportunityLineItem> lineItems = [SELECT Id, OpportunityId , Product2Id FROM OpportunityLineItem WHERE Product2Id IN :reservedCarIds];
      

        Map<Id, List<String>> productIdToItsOpportunityIds = new Map<Id, List<String>>();
        for(OpportunityLineItem lineItem : lineItems){
            String productId = lineItem.Product2Id;
            if(productIdToItsOpportunityIds.containsKey(productId)){
                productIdToItsOpportunityIds.get(productId).add(lineItem.OpportunityId);
            } else {
                productIdToItsOpportunityIds.put(productId, new List<String>{lineItem.OpportunityId});
            }
        }

        List<Opportunity> oppToUpdate = new List<Opportunity>();
        for(String key : productIdToItsOpportunityIds.keySet()){
            for(String oppId : productIdToItsOpportunityIds.get(key)){
                if(((Product2)Trigger.newMap.get(key)).Opportunity__c != oppId){
                    oppToUpdate.add(
                        new Opportunity(
                            Id = oppId,
                            WarningPoint__c = true
                        )
                    );
                }
                
            }
        }
        update oppToUpdate;


        List<OpportunityLineItem> lineItemsNotSoldOrReserved = [SELECT Id, OpportunityId , Product2Id FROM OpportunityLineItem WHERE Product2Id IN :notReservedOrSoldIds];

        Map<Id, List<String>> productIdNotSoldOrReserved = new Map<Id, List<String>>();
        for(OpportunityLineItem lineItem : lineItemsNotSoldOrReserved){
            String productId = lineItem.Product2Id;
            if(productIdNotSoldOrReserved.containsKey(productId)){
                productIdNotSoldOrReserved.get(productId).add(lineItem.OpportunityId);
            } else {
                productIdNotSoldOrReserved.put(productId, new List<String>{lineItem.OpportunityId});
            }
        }

        List<Opportunity> oppToUpdateNotSoldOrReserved = new List<Opportunity>();
        for(String key : productIdNotSoldOrReserved.keySet()){
            for(String oppId : productIdNotSoldOrReserved.get(key)){
                if(((Product2)Trigger.newMap.get(key)).Opportunity__c != oppId){
                    oppToUpdateNotSoldOrReserved.add(
                        new Opportunity(
                            Id = oppId,
                            WarningPoint__c = false
                        )
                    );
                }
                
            }
        }      
        update oppToUpdateNotSoldOrReserved;

       
    }
  }
