public with sharing class lwcrecordtypes {
    public lwcrecordtypes() {

    }
    @AuraEnabled(cacheable=true)
    public static String retrieveContactData(string keySearch){  
        List<SearchQueryResponse> auraResponse = new List<SearchQueryResponse>();  
        List<List<sObject>> response =  [Find :keySearch IN All Fields RETURNING Contact(Id,Name), Account(Id,Name)];
        for (integer i = 0; i<response.size(); i++){
            if(i==0){
             List<Contact> contacts = (List<Contact>)response[0];
             if(contacts != null && contacts.size() > 0){
                 for (Contact c : contacts){
                     SearchQueryResponse responsePerContact = new SearchQueryResponse();
                     responsePerContact.recordId = c.Id;
                     responsePerContact.recordName = c.Name;
                     responsePerContact.recordSobjectType = 'Contact'; 
                     responsePerContact.recordUrl = URL.getOrgDomainUrl().toExternalForm() + '/lightning' + '/r' + '/Contact/' +c.Id + '/view';
                     auraResponse.add(responsePerContact);
                 }
             }
            }
            if(i==1){
                List<Account> accounts = (List<Account>)response[1];
                if(accounts != null && accounts.size() > 0){
                    for (Account a : accounts){
                        SearchQueryResponse responsePerAccount = new SearchQueryResponse();
                        responsePerAccount.recordId = a.Id;
                        responsePerAccount.recordName = a.Name;
                        responsePerAccount.recordSobjectType = 'Account';
                        responsePerAccount.recordUrl = Url.getOrgDomainUrl().toExternalForm() + '/lightning' + '/r' + '/Account/' +a.Id + '/view';
                        auraResponse.add(responsePerAccount);
                    }
                }
               }
        }
        return JSON.serialize(auraResponse);
    }

    public class SearchQueryResponse {
        public string recordId {get; set;}
        public string recordName {get; set;}
        public string recordSobjectType{get; set;}
        public string recordUrl {get; set;}
    }
}

