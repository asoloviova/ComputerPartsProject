public with sharing class PurchaseTriggerHandler {
    public static void purchaseDataSetup(List<Purchase__c> purchases) {
        List<Id> contIdList = new List<Id>();
        
        for (Purchase__c newPurch : purchases){
            if(String.isNotBlank(newPurch.Contact__c)){
                contIdList.add(newPurch.Contact__c);
            }
        }
        
        Map<Id,Contact> consForUpdate = new Map<Id, Contact> ([SELECT Id, First_Purchase__c, Last_Purchase__c, Total_Amount__c FROM Contact WHERE Id IN :contIdList]);

        for (Purchase__c newPurch : purchases){
            if(newPurch.Contact__c != null){
                Contact con = consForUpdate.get(newPurch.Contact__c);

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
            }
            
        }
        update consForUpdate.values();

    }

}