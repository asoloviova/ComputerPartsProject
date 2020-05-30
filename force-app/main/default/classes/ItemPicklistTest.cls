@isTest
private class ItemPicklistTest {
   @isTest private static void getItemsPicklistTest() {
    
        System.Test.startTest();
            String type='processor';
            Item__c itm = new Item__c(Name='New Item');
            insert itm;
            List<Item__c> allItems = [SELECT Name, Type__c, Price__c FROM Item__c WHERE Type__c =: type];
            ItemPicklistApexController.Option optn = new ItemPicklistApexController.Option(itm.Name, JSON.serialize(itm));
            System.assertEquals(itm.Name, optn.label);
            System.assertEquals(JSON.serialize(itm), optn.value);
            ItemPicklistApexController.getItemsPicklist(type);
            System.assertEquals(allItems.size(), ItemPicklistApexController.getItemsPicklist(type).size());
        System.Test.stopTest();

    }

    @isTest private static void getMaxCustomDiscountTest(){
        System.Test.startTest();
            Profile pf= [SELECT Id FROM Profile WHERE Name='System Administrator']; 
            String orgId=UserInfo.getOrganizationId(); 
            Discount__c disc = Discount__c.getInstance(pf.Id);
            Decimal testDisc = disc.Max_Discount__c;
            Decimal maxDisc = ItemPicklistApexController.getMaxCustomDiscount();
            System.assertEquals(testDisc, maxDisc);
        System.test.stopTest();
    }
    
}
