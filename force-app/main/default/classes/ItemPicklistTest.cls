@isTest
private class ItemPicklistTest {

    @TestSetup
    static void setup(){
        Item__c itm = new Item__c(Name='New Item', Type__c='Processor');
        insert itm;
        Profile pf= [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='test@sashaorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = pf.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='test@sashaorg.com');
        insert u;
    }
   @isTest private static void getItemsPicklistTest() {
    String type='Processor';
        Item__c itm = [SELECT Id, Name FROM Item__c];
        System.Test.startTest();
            ItemPicklistController.Option optn = new ItemPicklistController.Option(itm.Name, JSON.serialize(itm));
            List<ItemPicklistController.Option> optnList = ItemPicklistController.getItemsPicklist(type);
        System.Test.stopTest();
        System.assertEquals(itm.Name, optn.label);
        System.assertEquals(JSON.serialize(itm), optn.value);
        System.assertEquals(1, optnList.size());
    }

    @isTest private static void getMaxCustomDiscountTest(){
        User u = [SELECT Id FROM User WHERE Email='test@sashaorg.com'];
        System.Test.startTest();
            System.runAs(u){
                Discount__c disc = Discount__c.getInstance(u.Id);
                Decimal testDisc = disc.Max_Discount__c;
                Decimal maxDisc = ItemPicklistController.getMaxCustomDiscount();
                System.assertEquals(testDisc, maxDisc);
            }
        System.test.stopTest();
    }
    
}