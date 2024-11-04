/**
 * @description       : 
 * @author            : Svyatoslav Andrushchak
 * @group             : 
 * @last modified on  : 10-24-2024
 * @last modified by  : Svyatoslav Andrushchak
**/
public with sharing class CaseCreateHandler {
    public static void createCaseWithVin() {

        List<Case> cs =Trigger.new;
        Set<String> vinNumb = new Set<String>();
        for (Case c : cs) {
            if (c.CarVinCode__c != null) {
                vinNumb.add(c.CarVinCode__c);
            }
            
        }


        Map<Id , String > vinmap = new Map<Id,String>(); 
        
        for (Case subcase : cs) {
            if (subcase.Subject != null && subcase.Subject.contains('VIN-')) {
                Integer startIndex = subcase.Subject.indexOf('VIN-') + 4;
                Integer endIndex = subcase.Subject.indexOf(' ', startIndex);

                if (endIndex == -1) {
                    endIndex = subcase.Subject.length();
                }

                String vinCode = subcase.Subject.substring(startIndex, endIndex);

                vinNumb.add(vinCode);
                vinmap.put(subcase.Id, vinCode);

            }
        }

       List<Product2> prodList = [SELECT Id ,VIN_Number__c FROM Product2 WHERE VIN_Number__c IN : vinNumb ];
       Map<String , Product2> carMap = new Map<String , Product2>();
        for (Product2 prod : prodList) {
            String key = prod.VIN_Number__c;
            carMap.put(key , prod);
        }

        List<Car_Service__c> carServ = new List<Car_Service__c>();
        for (Case c : cs) {
            String vincode = c.CarVinCode__c != null ? c.CarVinCode__c : vinmap.get(c.Id);
            if (vincode != null && !carMap.containsKey(vincode)) {
                c.addError('No Car exists with VIN: ' + vincode);
            }
            else {
                Car_Service__c carS = new Car_Service__c();
                carS.Date__c = Date.today();
                System.debug(vincode);
                carS.Car_Relation__c = carMap.get(vincode).Id;
                carS.Case__c = c.Id;
                System.debug(c.Id);
                carServ.add(carS);
               
                
            }
        }
      
        insert carServ;

    }
}