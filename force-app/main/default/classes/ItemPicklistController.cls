public with sharing class ItemPicklistController {
    @AuraEnabled
    public static List<Option> getItemsPicklist(String type){

        List<Item__c> allItems = [SELECT Name, Type__c, Price__c FROM Item__c WHERE Type__c =: type];
        List<Option> itemNames = new List<Option>();
        for(Item__c item : allItems){
            itemNames.add(new Option(item.name,JSON.serialize(item)));
        }
        return itemNames;
    }

    @AuraEnabled
    public static Decimal getMaxCustomDiscount(){
        Id userId=userinfo.getUserId();
        Discount__c disc = Discount__c.getInstance(userId);
        Decimal maxDisc = disc.Max_Discount__c;
        return maxDisc;

    }
    
    public class Option{
        @AuraEnabled
        public String label;
        @AuraEnabled
        public String value;
        public Option(String label, String value){
            this.label = label;
            this.value = value;
        }
    }
}