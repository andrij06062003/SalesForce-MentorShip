public without sharing class PlannedSalesHandler {
    public static void updatePlannedSales() {  

        List<Planned_Sales__c> plannedSales = Trigger.new;
      
        Set<Integer> month = new Set<Integer>();
        Set<Integer> year = new Set<Integer>();

        for (Planned_Sales__c ps : plannedSales) {
             month.add((Integer)ps.Month__c);
             year.add((Integer)ps.Year__c);
             ps.Count_of_Cars_Sold__c = 0;
             ps.Total_Amount_Earned__c = 0;
           
        }
        
            List<Opportunity> opportunities = [
                SELECT Id , Amount , CloseDate , (SELECT Id , Product2.Condition__c , ServiceDate , TotalPrice , UnitPrice  FROM OpportunityLineItems)
                FROM Opportunity 
                WHERE StageName = 'Closed Won'
                AND CALENDAR_YEAR(CloseDate) IN : year 
                AND CALENDAR_MONTH(CloseDate) IN :month
            ];

            Map<String , Planned_Sales__c> planesMap= new Map<String,Planned_Sales__c>();
            for (Planned_Sales__c plannedSale : plannedSales) {
                string key = plannedSale.Month__c + ' ' + plannedSale.Year__c + ' ' + plannedSale.Car_Type__c;
                planesMap.put(key , plannedSale);
            }
            System.debug(planesMap);
    
            for (Opportunity opportunity : opportunities){
                for (OpportunityLineItem lineopp : opportunity.OpportunityLineItems) {
                  Planned_Sales__c ps = planesMap.get(
                    opportunity.CloseDate.month() + ' ' + opportunity.CloseDate.year() + ' ' + lineopp.Product2.Condition__c
                  );
                    if (ps != null) {
                        ps.Count_of_Cars_Sold__c++;
                        ps.Total_Amount_Earned__c += lineopp.UnitPrice;
                    }
                }
            }
           
        }
     
    
}