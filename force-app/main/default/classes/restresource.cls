@RestResource(urlMapping='/Contact/')
global with sharing class restresource {
    public restresource() {

    }
    @HttpPost
    global static List<Contact> createRecord(List<Contact> Contacts) {
        insert Contacts;
        return Contacts;
    }
}
