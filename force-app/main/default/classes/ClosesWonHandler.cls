/**
 * @description       : 
 * @author            : Svyatoslav Andrushchak
 * @group             : 
 * @last modified on  : 10-14-2024
 * @last modified by  : Svyatoslav Andrushchak
**/
public without sharing class ClosesWonHandler {
    public static void updateClosesWonHandler() {
        
        List<Opportunity> oppToUpdate = new List<Opportunity>(); 

        List<Opportunity> closedOpps = [
                SELECT Id, Name ,Amount , CloseDate, StageName, (SELECT Id, Product2.Condition__c , ServiceDate , TotalPrice, UnitPrice FROM OpportunityLineItems) 
                FROM Opportunity 
                WHERE Id IN :Trigger.New 
                AND StageName = 'Closed Won'
            ];
         
            Set<Integer> month = new Set<Integer>();
            Set<Integer> year = new Set<Integer>();

            for(Opportunity opp : closedOpps){
                month.add(opp.CloseDate.month());
                year.add(opp.CloseDate.year());
            }

            System.debug('year: ' + year);
            System.debug('month: ' + month);

            List<Planned_Sales__c> planedSales = [
                SELECT Id, Year__c, Month__c, Car_Type__c 
                FROM Planned_Sales__c 
                WHERE Year__c IN :year AND Month__c IN :month
            ];

            for (Planned_Sales__c ps : planedSales) {
                ps.Count_of_Cars_Sold__c = 0;
                ps.Total_Amount_Earned__c = 0;
            }

            Map<String , Planned_Sales__c > planMap = new Map<String , Planned_Sales__c>();
            for (Planned_Sales__c plans : planedSales) {
                string key = plans.Month__c + ' ' + plans.Year__c + ' ' + plans.Car_Type__c;
                planMap.put(key, plans);
            }

            System.debug('planMap: ' + planMap);

            for (Opportunity oppnew : closedOpps) {
                if (oppnew.StageName == 'Closed Won' && ((Opportunity)Trigger.oldMap.get(oppnew.Id)).StageName != 'Closed Won') {
                    for (OpportunityLineItem oppold : oppnew.OpportunityLineItems) {
                    Planned_Sales__c ps = planMap.get(
                        oppnew.CloseDate.month() + ' ' + oppnew.CloseDate.year() + ' ' + oppold.Product2.Condition__c
                    );
                    
                        if (ps != null) {
                            ps.Count_of_Cars_Sold__c++;
                            ps.Total_Amount_Earned__c += oppold.UnitPrice;
                            System.debug(ps.Total_Amount_Earned__c);
                        }
                    } 
                }
                
            }

        update planedSales;
    }
}