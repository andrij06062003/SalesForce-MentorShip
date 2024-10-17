@isTest
public class PlannedSalesHandlerTest {
    @isTest
    static void testUpdatePlannedSales() {
        Planned_Sales__c pl = TestDataFactory.createPlannedSalesRecord(false);
       
        List<Opportunity> opps = TestDataFactory.createTestOpportunity(10, false); 
        insert opps;
        
        Product2 prod = TestDataFactory.createTestProduct(true);
        PricebookEntry pbe = TestDataFactory.createTestPricebookEntry(prod, true);
        
      
        List<OpportunityLineItem> oliList = TestDataFactory.createTestLineOpps(opps, prod, pbe, false);
        insert oliList;
        
        insert pl;

        for(OpportunityLineItem oppline : oliList){
        if (pl.Month__c == 11 && pl.Year__c == 2024 && oppline.Product2.Condition__c == 'New') {
            Assert.areEqual(opps.size(), pl.Count_of_Cars_Sold__c); 
            Assert.areEqual(opps.size() * 100000, pl.Total_Amount_Earned__c); 
             
        }
        
      }
    }
}