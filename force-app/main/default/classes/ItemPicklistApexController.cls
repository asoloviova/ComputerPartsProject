public with sharing class ItemPicklistApexController {
    @AuraEnabled
    public static List<String> getItemsPicklist(String type){

        List<Item__c> allItems = [SELECT Name, Type__c FROM Item__c WHERE Type__c =: type];
        List<String> itemNames = new List<String>();
        for(Item__c item : allItems){
            itemNames.add(item.Name);
        }
        return itemNames;
    }

    @AuraEnabled
    public static Decimal getItemsPrice(String name){
    
        List<Item__c> itm = [SELECT Name, Price__c FROM Item__c WHERE Name=:name LIMIT 1];
        Decimal price = itm[0].Price__c;
        return price;
    }
}