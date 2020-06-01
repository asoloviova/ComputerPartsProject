@IsTest 
private with sharing class ContactPicklistTest {
    
    @isTest private static void getContactsPicklistTest(){
        ItemPicklistController itemController = new ItemPicklistController();
        Contact con = new Contact (LastName = 'Bold', FirstName='John');
        insert con;
        List<Contact> allContacts = [SELECT Name, Personal_Discount__c FROM Contact];
        ContactPicklistController.ContactWrapper contWrapp = new ContactPicklistController.ContactWrapper(con.Name,JSON.serialize(con));
        System.assertEquals(con.Name, contWrapp.name);
        System.assertEquals(JSON.serialize(con), contWrapp.value);
        ContactPicklistController.getContactsPicklist();
    }
}