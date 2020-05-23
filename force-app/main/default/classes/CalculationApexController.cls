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


        // public ItemWrapper (String itemName, Integer itemQuantity, Double itemPrice, Double itemDiscount){
        //     this.itemName = itemName;
        //     this.itemQuantity=itemQuantity;
        //     this.itemPrice=itemPrice;
        //     this.itemDiscount=itemDiscount;
        // }
    }
    @AuraEnabled
    public static List<ItemWrapper> combineItemLists(List<ItemWrapper> procRows, List<ItemWrapper> ramsRows, 
    List<ItemWrapper> motherboardsRows, List<ItemWrapper> videocardsRows){
        List<ItemWrapper> fullList = new List <ItemWrapper>();
        fullList.addall(procRows);
        fullList.addall(ramsRows);
        fullList.addall(motherboardsRows);
        fullList.addall(videocardsRows);
        System.debug('hello');
        System.debug(fullList);
        return fullList;

        
    }
}

    // public static List<ItemWrapper> getChosenItemsList() {
        
        
    //     // List<Item__c> itemsList = [SELECT Id, Name, Price__c, Type__c FROM Item__c ];
    //     // List<Contact> conList = [SELECT Id, Name, Personal_Discount__c FROM Contact];
    //     // List<ItemsWrapper> lst = new List<ItemsWrapper>();
    //     // for (Item_c item : itemsList){
    //     //     lst.add(new ItemsWrapper(JSON.serialize(item),JSON.serialize()))
    //     // }
    //     // return lst;
    // }
    //     @AuraEnabled
    // public static ItemWrapper getChosenItemsList(){
    //     List<Item__c> itms = [SELECT Name, Price__c FROM Item__c];
    //     List<Purchase_Item__c> purchItms = [SELECT Quantity__c, Discount__c FROM Purchase_Item__c];
    //     ItemWrapper chosenItemsList = new ItemWrapper(Item__c.Name, Purchase_Item__c.Quantity__c, Item__c.Price__c, Purchase_Item__c.Discount__c);
    //     // chosenItemsList.itemName = itms.Name;
    //     // chosenItemsList.itemPrice = itms.Price__c;
    //     // chosenItemsList.itemQuantity = purchItms.Quantity__c;
    //     // chosenItemsList.itemDiscount = purchItms.Discount__c; 
    //     System.debug(chosenItemsList);
    //     return chosenItemsList;
    // }

