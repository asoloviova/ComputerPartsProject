public with sharing class CalculationController {

    @AuraEnabled
    public static void saveOrderMethod(String contId, List<ItemWrapper> chosenItems, Decimal totalSumWithDiscount, 
            String purchDate, String discountType ){
        Date purchaseDate = Date.valueOf(purchDate);
        String discType = discountType.substring(0, 1).toUpperCase() + discountType.substring(1);
        Purchase__c purch = new Purchase__c(Contact__c = contId, Amount__c = totalSumWithDiscount, 
        Purchase_Date__c = purchaseDate, Discount_Type__c = discType);
        insert purch;
        List <Purchase_Item__c> purchItemsList = new List<Purchase_Item__c>();
        for(ItemWrapper chosenItem : chosenItems){
            if (String.isNotBlank(chosenItem.itemName)){
                Item__c item = [SELECT Id, Name FROM Item__c WHERE Name=:chosenItem.itemName];
                purchItemsList.add(new Purchase_Item__c (Discount__c = chosenItem.itemDiscount,
                        Item__c = item.Id, Purchase__c = purch.Id, Quantity__c = chosenItem.itemQuantity));
            }
        }
        insert purchItemsList;
    }

    public class ItemWrapper{
        @AuraEnabled
        public String itemName{get;set;}

        @AuraEnabled
        public Integer itemQuantity{get;set;}

        @AuraEnabled
        public Double itemPrice{get;set;}

        @AuraEnabled
        public Double itemDiscount{get;set;}
    }
}