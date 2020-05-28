trigger purchaseDateTrigger on Purchase__c (after insert) {
    
        for (Purchase__c newPurch : Trigger.new){
            if(newPurch.Contact__c != null){
                Contact con = [SELECT Id, First_Purchase__c, Last_Purchase__c FROM Contact WHERE Id=:newPurch.Contact__c];

                if (con.First_Purchase__c == null && con.Last_Purchase__c == null){
                    con.First_Purchase__c = newPurch.Purchase_Date__c;
                    con.Last_Purchase__c = newPurch.Purchase_Date__c;
                } else if(newPurch.Purchase_Date__c >=con.Last_Purchase__c){
                    con.Last_Purchase__c = newPurch.Purchase_Date__c;
                } else if(newPurch.Purchase_Date__c <= con.Last_Purchase__c){
                    con.First_Purchase__c = newPurch.Purchase_Date__c;
                }
                update con;
            }
            
        }
    }