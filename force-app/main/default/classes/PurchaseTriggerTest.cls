@isTest
public with sharing class PurchaseTriggerTest {

    @TestSetup
    static void setup(){
        Profile pf= [SELECT Id FROM Profile WHERE Name='Custom Platform User']; 
        User u1 = new User(Alias = 'standt', Email='test1@sashaorg.com', 
            EmailEncodingKey='UTF-8', LastName='Test1', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = pf.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='test1@sashaorg.com');
        User u2 = new User(Alias = 'standt', Email='test2@sashaorg.com', 
            EmailEncodingKey='UTF-8', LastName='Test2', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = pf.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='test2@sashaorg.com');
        
        insert u1;
        insert u2;

        Contact con = new Contact(LastName = 'Jackson', OwnerId=u1.Id, First_Purchase__c = Date.today().addDays(-24), Last_Purchase__c = Date.today(), Total_Amount__c = 3456.12);
        insert con;

    }

    @isTest private static void sharePurchTest(){
        User u2 = [SELECT Id FROM User WHERE Email='test2@sashaorg.com'];
        Contact con = [SELECT Id, OwnerId FROM Contact];

        Test.startTest();
            Purchase__c purch = new Purchase__c(Purchase_Date__c = Date.today(), Contact__c = con.Id);
            insert purch;
        Test.stopTest();

        List<Purchase__Share> pShrs1 = [SELECT Id, UserOrGroupId, AccessLevel,
            RowCause FROM Purchase__Share WHERE ParentId = :purch.Id AND UserOrGroupId = :con.OwnerId];

        List<Purchase__Share> pShrs2 = [SELECT Id, UserOrGroupId, AccessLevel,
            RowCause FROM Purchase__Share WHERE ParentId = :purch.Id AND UserOrGroupId = :u2.Id];


        System.assertEquals(pShrs2.size(), 0);
        System.assertEquals(pShrs1.size(), 1);
        System.assertEquals(pShrs1[0].AccessLevel, 'Edit');
        System.assertEquals(pShrs1[0].UserOrGroupId, con.OwnerId);

    }

    @isTest private static void purchDataTest(){
        Contact con = [SELECT Id, First_Purchase__c, Last_Purchase__c, Total_Amount__c FROM Contact];
        Test.startTest();
            Purchase__c purch = new Purchase__c(Purchase_Date__c = Date.today().addDays(17), Contact__c = con.Id, Amount__c = 100.12);
            insert purch;
        Test.stopTest();
        Contact conUpd = [SELECT Id, First_Purchase__c, Last_Purchase__c, Total_Amount__c FROM Contact];

        System.assertEquals(conUpd.Total_Amount__c, 3556.24);
        System.assertEquals(conUpd.First_Purchase__c, con.First_Purchase__c);
        System.assertEquals(conUpd.Last_Purchase__c, Date.today().addDays(17));



    }
}
