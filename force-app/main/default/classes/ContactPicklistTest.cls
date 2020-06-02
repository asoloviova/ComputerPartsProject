@IsTest 
private with sharing class ContactPicklistTest {
    
    @isTest private static void getContactsPicklistTest(){
        Contact con = new Contact (LastName = 'Bold', FirstName='John');
        insert con;
        System.Test.startTest();
            ContactPicklistController.ContactWrapper contWrapp = new ContactPicklistController.ContactWrapper(con.Name,JSON.serialize(con));
            List <ContactPicklistController.ContactWrapper> wrappList = ContactPicklistController.getContactsPicklist();
        System.Test.stopTest();
        System.assertEquals(1, wrappList.size());
        System.assertEquals(con.Name, contWrapp.name);
        System.assertEquals(JSON.serialize(con), contWrapp.value);
        
    }
}