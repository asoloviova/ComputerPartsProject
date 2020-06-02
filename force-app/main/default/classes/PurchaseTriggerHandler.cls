public with sharing class PurchaseTriggerHandler {
    public static void purchaseDataSetup(List<Purchase__c> purchases) {
        for (Purchase__c newPurch : purchases){
            if(newPurch.Contact__c != null){
                Contact con = [SELECT Id, First_Purchase__c, Last_Purchase__c, Total_Amount__c FROM Contact WHERE Id=:newPurch.Contact__c];

                if (con.First_Purchase__c == null && con.Last_Purchase__c == null){
                    con.First_Purchase__c = newPurch.Purchase_Date__c;
                    con.Last_Purchase__c = newPurch.Purchase_Date__c;
                } else if(newPurch.Purchase_Date__c >=con.Last_Purchase__c){
                    con.Last_Purchase__c = newPurch.Purchase_Date__c;
                } else if(newPurch.Purchase_Date__c <= con.Last_Purchase__c){
                    con.First_Purchase__c = newPurch.Purchase_Date__c;
                }

                if(con.Total_Amount__c == null){
                    con.Total_Amount__c = newPurch.Amount__c;
                } else con.Total_Amount__c += newPurch.Amount__c;

                update con;
            }
            
        }
    }

}