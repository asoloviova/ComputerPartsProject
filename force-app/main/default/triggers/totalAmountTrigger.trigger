trigger totalAmountTrigger on Purchase__c (after insert) {
    
    for (Purchase__c newPurch : Trigger.new){
        if(newPurch.Contact__c != null){
            Contact con = [SELECT Id, Name, Total_Amount__c FROM Contact WHERE Id=:newPurch.Contact__c];
            if(con.Total_Amount__c == null){
                con.Total_Amount__c = newPurch.Amount__c;
            } else con.Total_Amount__c += newPurch.Amount__c;
            update con;
        }
        
    }
}