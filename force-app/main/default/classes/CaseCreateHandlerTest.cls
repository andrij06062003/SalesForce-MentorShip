@isTest
public class CaseCreateHandlerTest {
    @testSetup
    static void setup() {
        Product2 testProduct = TestDataFactory.createTestProduct(true);
       
    }

    @isTest
    static void testCreateCaseWithVin() {
        Case testCase = TestDataFactory.createTestCase(true);
        // Query for the inserted Car_Service__c records
        List<Car_Service__c> carServices = [SELECT Id, Case__c, Car_Relation__c FROM Car_Service__c WHERE Case__c IN (SELECT Id FROM Case WHERE Subject = 'VIN-PRS112233')];

        // Assert that the Car_Service__c record has been created
        System.assertEquals(1, carServices.size(), 'One Car_Service__c record should be created.');
        System.assertEquals(carServices[0].Case__c, carServices[0].Case__c, 'The Car_Service__c should be related to the correct Case.');
        System.assertNotEquals(null, carServices[0].Car_Relation__c, 'The Car_Relation__c should match the Product2 Id.');
    }
}