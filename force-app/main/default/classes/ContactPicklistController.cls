public with sharing class ContactPicklistController {
    @AuraEnabled
    public static List<ContactWrapper> getContactsPicklist(){
        List<Contact> allContacts = [SELECT Name, Personal_Discount__c, Phone FROM Contact];
        List <ContactWrapper> wrappContacts = new List<ContactWrapper>();
        for (Contact con : allContacts){
            wrappContacts.add(new ContactWrapper(con.name, JSON.serialize(con)));
        }
        return wrappContacts;
    }

    public class ContactWrapper{
        @AuraEnabled
        public String name;
        @AuraEnabled
        public String value;
        public ContactWrapper(String name, String value){
            this.name = name;
            this.value = value;
        }
    }
}