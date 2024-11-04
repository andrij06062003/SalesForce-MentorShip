/**
 * @description       : 
 * @author            : Svyatoslav Andrushchak
 * @group             : 
 * @last modified on  : 10-31-2024
 * @last modified by  : Svyatoslav Andrushchak
**/
public with sharing class getCARS {
    @AuraEnabled
    public static List<Product2> getCarsFields(String name , String model ,String brand, Date YearOfManufacture , Decimal EnginePower, List<String> fields){

        String query = 'SELECT Id';
        for(String field : fields){
            query += ', ' + field;
        }
        query += ' FROM Product2 WHERE Model__c =: model AND Engine_Power__c =: EnginePower AND Name =:name AND Brand__c =:brand';

        return (List<Product2>)Database.query(query);
    }

    @AuraEnabled
    public static List<Fields_for_Comparer__mdt> getCarFieldMappings(){
      return [SELECT DeveloperName , MasterLabel , ApiName__c FROM Fields_for_Comparer__mdt];
    }
}