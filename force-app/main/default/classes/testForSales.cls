@isTest
public class testForSales {
    @isTest
    static void testPlannedSalesTrigger() {
        // Create a Planned Sales record
        Planned_Sales__c plannedSale = TestDataFactory.createPlannedSalesRecord(true);
        Product2 car = TestDataFactory.createTestProduct(true);
        Opportunity opp = TestDataFactory.createTestOpportunity(true);

        // Update the Opportunity record to trigger the PlannedSales trigger
        opp.StageName = 'Closed Won';
        update opp;

        // Verify the Count of Cars Sold and Total Amount Earned fields
        List<Planned_Sales__c> updatedPlannedSales = [SELECT Count_of_Cars_Sold__c, Total_Amount_Earned__c FROM Planned_Sales__c WHERE Id = :plannedSale.Id];
        System.assertEquals(1, updatedPlannedSales.size());
        Assert.areEqual(1, updatedPlannedSales.Count_of_Cars_Sold__c);
        Assert.areEqual(10000, updatedPlannedSales.Total_Amount_Earned__c);

    }
}