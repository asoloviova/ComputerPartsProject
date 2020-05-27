public with sharing class CalculationApexController {

    @AuraEnabled
    public static List<ItemWrapper> getChosenItemsList(){
        List<ItemWrapper> chosenItemsList = new List<ItemWrapper>();
        return chosenItemsList;
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
    @AuraEnabled
    public static List<ItemWrapper> combineItemLists(List<ItemWrapper> procRows, List<ItemWrapper> ramsRows, 
    List<ItemWrapper> motherboardsRows, List<ItemWrapper> videocardsRows){
        List<ItemWrapper> fullList = new List <ItemWrapper>();
        fullList.addall(procRows);
        fullList.addall(ramsRows);
        fullList.addall(motherboardsRows);
        fullList.addall(videocardsRows);
        return fullList;

    }
    @AuraEnabled
        public static void saveOrderMethod(String contId, List<ItemWrapper> chosenItems, Decimal totalSumWithDiscount, 
        String purchDate, String discountType ){
        Contact contact = [SELECT Id FROM Contact WHERE Id=:contId LIMIT 1];
        Date purchaseDate = Date.valueOf(purchDate);
        String discType = discountType.substring(0, 1).toUpperCase() + discountType.substring(1);
        Purchase__c purch = new Purchase__c(Contact__c = contact.Id, Amount__c = totalSumWithDiscount, 
        Purchase_Date__c = purchaseDate, Discount_Type__c = discType);
        insert purch;
        List <Purchase_Item__c> purchItemsList = new List<Purchase_Item__c>();
        for(ItemWrapper chosenItem : chosenItems){
            if (!String.isBlank(chosenItem.itemName)){
                Item__c item = [SELECT Id, Name FROM Item__c WHERE Name=:chosenItem.itemName];
                purchItemsList.add(new Purchase_Item__c (Discount__c = chosenItem.itemDiscount,
            Item__c = item.Id, Purchase__c = purch.Id, Quantity__c = chosenItem.itemQuantity));
            }
            System.debug('chosenItem: '+ chosenItem);
        }
        insert purchItemsList;
    }
    }
