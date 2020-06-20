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
            if(newPurch.Contact__c != null && newPurch.Amount__c != null){
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

    public static void sharePurchWithContactOwner(List<Purchase__c> purchases){
        List<Id> contIdList = new List<Id>();
        
        for (Purchase__c newPurch : purchases){
            if(String.isNotBlank(newPurch.Contact__c)){
                contIdList.add(newPurch.Contact__c);
            }
        }
        Map<Id,Contact> consMap = new Map<Id, Contact> ([SELECT Id, OwnerId FROM Contact WHERE Id IN :contIdList]);

        List<Purchase__Share> purchShares = new List<Purchase__Share>();
        
        for(Purchase__c p : purchases){
            Contact con = consMap.get(p.Contact__c);
            Purchase__Share purchRecord = new Purchase__Share();
            purchRecord.ParentId = p.Id;
            purchRecord.UserOrGroupId = con.OwnerId;
            purchRecord.AccessLevel = 'edit';
            purchRecord.RowCause = Schema.Purchase__Share.RowCause.Sharing_with_Contact_Owner__c;
            purchShares.add(purchRecord);
        }
        Database.SaveResult[] purchShareInsertResult = Database.insert(purchShares,false);
        
    }

}