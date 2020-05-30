@IsTest 
private with sharing class ContactPicklistTest {
    
    @isTest private static void getContactsPicklistTest(){
        ItemPicklistApexController itemController = new ItemPicklistApexController();
        Contact con = new Contact (LastName = 'Bold', FirstName='John');
        insert con;
        List<Contact> allContacts = [SELECT Name, Personal_Discount__c FROM Contact];
        ContactPicklistApexController.ContactWrapper contWrapp = new ContactPicklistApexController.ContactWrapper(con.Name,JSON.serialize(con));
        System.assertEquals(con.Name, contWrapp.name);
        System.assertEquals(JSON.serialize(con), contWrapp.value);
        ContactPicklistApexController.getContactsPicklist();
    }
}
