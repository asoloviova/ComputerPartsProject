public with sharing class ContactPicklistApexController {
    @AuraEnabled
    public static List<String> getContactsPicklist(){
        List<Contact> allContacts = [SELECT Name FROM Contact];
        List<String> conNames = new List<String>();
        for(Contact contact : allContacts){
            conNames.add(contact.Name);
        }
        return conNames;
    }
}