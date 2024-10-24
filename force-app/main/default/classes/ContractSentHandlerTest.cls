@isTest
public class ContractSentHandlerTest {
    @testSetup
    static void setup() {
        Product2 testProduct = TestDataFactory.createTestProduct(true);
        PricebookEntry testPbe = TestDataFactory.createTestPricebookEntry(testProduct, true);
        List<Opportunity> testOpportunities = TestDataFactory.createTestOpportunity(3, true);

        TestDataFactory.createTestLineOpps(testOpportunities, testProduct, testPbe, true);
    }

    @isTest
    static void testContractSentStageUpdate() {
        
        List<Opportunity> testOpportunities = [SELECT Id, StageName FROM Opportunity LIMIT 3];
        List<OpportunityLineItem> lineItems = [SELECT Id, Product2Id, PricebookEntryId FROM OpportunityLineItem WHERE OpportunityId IN :testOpportunities];
        Product2 testProduct = [SELECT Id, Car_Status__c FROM Product2 LIMIT 1];

        testOpportunities[0].StageName = 'Contract Sent';
        update testOpportunities;

        Product2 updatedProduct = [SELECT Id, Car_Status__c FROM Product2 WHERE Id = :testProduct.Id];
        System.assertEquals('Reserved', updatedProduct.Car_Status__c);
    }
}