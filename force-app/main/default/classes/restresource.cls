@RestResource(urlMapping='/Contact/*')
global with sharing class restresource {
    public restresource() {

    }
    @HttpPut
    global static void updateRecords(List<Contact> Contacts) {
        List<Id> insertedContactIds = new List<Id>();
        for (Contact c : Contacts){
            insertedContactIds.add(c.Id);
        }
        RestResponse res = RestContext.response;
        if(Contacts != null){
            List<Contact> orgContacts = [Select Id, FirstName, LastName from Contact];
            if(orgContacts != null && orgContacts.size() > 0){
                List<Id> orgContactIds = new List<Id>();
                for(Contact c : orgContacts){
                    orgContactIds.add(c.Id);
                }
                for (Contact insertedContact : Contacts){
                    for (Contact orgContact : Contacts){
                        if(insertedContact.id == orgContact.id){
                            orgContact.FirstName = String.isBlank(insertedContact.FirstName) || insertedContact.FirstName == null ? orgContact.FirstName : insertedContact.FirstName;
                            orgContact.LastName = String.isBlank(insertedContact.LastName) || insertedContact.LastName == null ? orgContact.LastName : insertedContact.LastName;
                        }
                    }
                }
                try {
                    update orgContacts;
                    res.statusCode = 200;
                    res.responseBody = Blob.valueOf('Records updated successfully');
                }
                catch(Exception e){
                        res.statusCode = 500;
                        res.responseBody = Blob.valueOf('An Error Has occured While trying to update the records: ' + e.getMessage());
                    }  
            }
        }
    }
}


