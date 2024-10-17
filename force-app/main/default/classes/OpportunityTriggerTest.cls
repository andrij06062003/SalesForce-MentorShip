@isTest
public class OpportunityTriggerTest {
    public static Product2 createCar(String Name, String brand, String model, String vinNumber, Integer mileage, String condition) {
        Product2 car = new Product2();
        car.Name = 'test';
        car.Brand__c = brand;
        car.Model__c = model;
        car.VIN_Number__c = vinNumber;
        car.Mileage__c = mileage;
        car.Condition__c = condition;
        insert car;
        return car;
    }

    @isTest
    static void testOpportunityTriggerUpdate() {
        // Create a new TriggerControl__c record
        TriggerControl__c controlSetting = new TriggerControl__c(
            Name = 'Trigger Control',
            Is_Active__c = true
        );
        insert controlSetting;

        // Create a new Car__c record
        Product2 car = createCar('Test Car', 'Test Brand', 'Test Model', '1234567890', 10000, 'New');

        // Create a new Planned_Sales__c record
        Planned_Sales__c plannedSale = new Planned_Sales__c(
            Car_Type__c = car.Condition__c,
            Year__c = 2023,
            Month__c = 5,
            Count_of_Cars_Sold__c = 0,
            Total_Amount_Earned__c = 0
        );
        insert plannedSale;

        // Create a new Opportunity record
        Opportunity opp = new Opportunity(
            Name = 'Test opp',
            CloseDate = Date.newInstance(2023, 5, 15),
            StageName = 'Closed Won',
            Amount = 11000,
            Car__c = car.Id
        );
        insert opp;

        // Update the Opportunity record
        opp.Amount = 20000;
        update opp;

        // Verify that the Planned_Sales__c record was updated correctly
        List<Planned_Sales__c> updatedPlannedSales = [SELECT Id, Count_of_Cars_Sold__c, Total_Amount_Earned__c FROM Planned_Sales__c WHERE Id = :plannedSale.Id];
        if (!updatedPlannedSales.isEmpty()) {
            Planned_Sales__c updatedPlannedSale = updatedPlannedSales.get(0);
            System.assertEquals(1, updatedPlannedSale.Count_of_Cars_Sold__c);
            System.assertEquals(20000, updatedPlannedSale.Total_Amount_Earned__c);
        } else {
            System.debug('No planned sales found for the given criteria');
        }
    }

    @isTest
    static void testOpportunityTriggerDelete() {
        // Create a new TriggerControl__c record
        TriggerControl__c controlSetting = new TriggerControl__c(
            Name = 'Trigger Control',
            Is_Active__c = true
        );
        insert controlSetting;

        // Create a new Car__c record
        Product2 car = createCar('Test Car', 'Test Brand', 'Test Model', '1234567890', 10000, 'New');

        // Create a new Planned_Sales__c record
        Planned_Sales__c plannedSale = new Planned_Sales__c(
            Car_Type__c = car.Condition__c,
            Year__c = 2023,
            Month__c = 5,
            Count_of_Cars_Sold__c = 1,
            Total_Amount_Earned__c = 11000
        );
        insert plannedSale;

        // Create a new Opportunity record
        Opportunity opp = new Opportunity(
            Name = 'Test opp',
            CloseDate = Date.newInstance(2023, 5, 15),
            StageName = 'Closed Won',
            Amount = 11000,
            Car__c = car.Id
        );
        insert opp;

        // Delete the Opportunity record
        delete opp;

        // Verify that the Planned_Sales__c record was updated correctly
        List<Planned_Sales__c> updatedPlannedSales = [SELECT Id, Count_of_Cars_Sold__c, Total_Amount_Earned__c FROM Planned_Sales__c WHERE Id = :plannedSale.Id];
        if (!updatedPlannedSales.isEmpty()) {
            Planned_Sales__c updatedPlannedSale = updatedPlannedSales.get(0);
            System.assertEquals(0, updatedPlannedSale.Count_of_Cars_Sold__c);
            System.assertEquals(0, updatedPlannedSale.Total_Amount_Earned__c);
        } else {
            System.debug('No planned sales found for the given criteria');
        }
    }
}