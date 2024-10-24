@isTest
public class Product2TestHandler {

    @testSetup
    static void setup() {
        
        List<Opportunity> opportunities = TestDataFactory.createTestOpportunity(2, true);
        Product2 testProduct = TestDataFactory.createTestProduct(true);
        PricebookEntry testPBE = TestDataFactory.createTestPricebookEntry(testProduct, true);
        TestDataFactory.createTestLineOpps(opportunities, testProduct, testPBE, true);
    }

    @isTest
    static void testCheckCarStatusReserved() {

        Product2 testProduct = [SELECT Id, Car_Status__c FROM Product2 LIMIT 1];
        testProduct.Car_Status__c = 'Reserved';
        update testProduct;

        OpportunityLineItem oli = [SELECT OpportunityId FROM OpportunityLineItem WHERE Product2Id = :testProduct.Id LIMIT 1];
        Opportunity opp = [SELECT Id, WarningPoint__c FROM Opportunity WHERE Id = :oli.OpportunityId];

        System.assertEquals(true, opp.WarningPoint__c, 'WarningPoint should be set to true when the product is reserved');
    }

    @isTest
    static void testCheckCarStatusSold() {
        Product2 testProduct = [SELECT Id, Car_Status__c FROM Product2 LIMIT 1];
        
        testProduct.Car_Status__c = 'Sold';
        update testProduct;

        
        OpportunityLineItem oli = [SELECT OpportunityId FROM OpportunityLineItem WHERE Product2Id = :testProduct.Id LIMIT 1];
        Opportunity opp = [SELECT Id, WarningPoint__c FROM Opportunity WHERE Id = :oli.OpportunityId];

        System.assertEquals(true, opp.WarningPoint__c, 'WarningPoint should be set to true when the product is sold');
    }

    @isTest
    static void testCheckCarStatusAvailable() {
       
        Product2 testProduct = [SELECT Id, Car_Status__c FROM Product2 LIMIT 1];

        testProduct.Car_Status__c = 'Reserved';
        update testProduct;

        testProduct.Car_Status__c = 'Avaible';
        update testProduct;

    
        OpportunityLineItem oli = [SELECT OpportunityId FROM OpportunityLineItem WHERE Product2Id = :testProduct.Id LIMIT 1];
        Opportunity opp = [SELECT Id, WarningPoint__c FROM Opportunity WHERE Id = :oli.OpportunityId];

        Assert.areEqual(false, opp.WarningPoint__c, 'WarningPoint should be removed when the product is not reserved or sold');
    }
}
