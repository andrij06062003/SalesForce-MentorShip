@isTest
public class TestDataFactory {
    public static List<Opportunity> createTestOpportunity(Integer oppCount , Boolean doInsert) {
        List<Opportunity> opportunities = new List<Opportunity>();
      for(Integer i =0 ; i<oppCount ; i++){
        Opportunity opp = new Opportunity(
            Name = 'TEst'+ i,
            StageName = 'Proposal',
            CloseDate = Date.today(),
            Pricebook2Id = Test.getStandardPricebookId()
        );
        opportunities.add(opp);
      }
        if (doInsert) {
            insert opportunities;
        }
        return opportunities;
    }

    public static Planned_Sales__c createPlannedSalesRecord( Boolean doInsert) {
        Planned_Sales__c ps = new Planned_Sales__c(
            Name = 'Test Planned'
        );
        if (doInsert) {
            insert ps;
        }
        return ps;
    }


    public static Product2 createTestProduct(Boolean doInsert) {
        Product2 prod = new Product2(
            Name = 'test',
            Brand__c = 'audi',
            Model__c = 'a4',
            VIN_Number__c = 'qv1213214fqfq',
            Mileage__c = 12000,
            Condition__c = 'New',
            Car_Status__c = 'Avaible'
        );
        if (doInsert) {
            insert prod;
        }
        return prod;
    }


    public static PricebookEntry createTestPricebookEntry(Product2 prod,  Boolean doInsert) {
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = prod.Id,
            UseStandardPrice = false,
            UnitPrice = 100000,
            IsActive = true
        );
        if (doInsert) {
            insert pbe;
        }
        return pbe;
    }

    public static List<OpportunityLineItem> createTestLineOpps(List<Opportunity> opportunities, Product2 prod, PricebookEntry pbe, Boolean doInsert) {
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        for (Opportunity opp : opportunities) {
            OpportunityLineItem oli = new OpportunityLineItem(
                OpportunityId = opp.Id,
                PricebookEntryId = pbe.Id,
                Quantity = 1,
                TotalPrice = 100000
            );
            oliList.add(oli);
        }
        if (doInsert) {
            insert oliList; // use Database.insert() for bulk insert
        }
        return oliList;
    }

}