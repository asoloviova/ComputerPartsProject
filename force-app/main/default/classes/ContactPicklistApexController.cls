public with sharing class ContactPicklistApexController {
    @AuraEnabled
    public static List<ContactWrapper> getContactsPicklist(){
        List<Contact> allContacts = [SELECT Name, Personal_Discount__c FROM Contact];
        List <ContactWrapper> wrappContacts = new List<ContactWrapper>();
    for (Contact con : allContacts){
        wrappContacts.add(new ContactWrapper(con.name, JSON.serialize(con)));
    }
        // List<String> cons = new List<String>();
        // for(Contact contact : allContacts){
        //     cons.add(JSON.serialize(Name));
        // }
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