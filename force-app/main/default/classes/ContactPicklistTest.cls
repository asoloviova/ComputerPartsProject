@IsTest 
private with sharing class ContactPicklistTest {
    @TestSetup
    static void setup(){
        Contact con = new Contact (LastName = 'Bold', FirstName='John');
        insert con;
    }
    @isTest private static void getContactsPicklistTest(){
        Contact con = [SELECT Id, Name FROM Contact WHERE LastName = 'Bold'];
        Test.startTest();
            ContactPicklistController.ContactWrapper contWrapp = new ContactPicklistController.ContactWrapper(con.Name,JSON.serialize(con));
            List <ContactPicklistController.ContactWrapper> wrappList = ContactPicklistController.getContactsPicklist();
        Test.stopTest();
        System.assertEquals(1, wrappList.size());
        System.assertEquals(con.Name, contWrapp.name);
        System.assertEquals(JSON.serialize(con), contWrapp.value);
        
    }
}