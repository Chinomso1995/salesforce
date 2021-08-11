@RestResource(urlMapping='/Contact/*')
global with sharing class restresource {
    public restresource() {

    }
    @HttpPut
    global static void updateContacts(List<Contact> updateContacts) {
        RestResponse res = RestContext.Response;
        List<Contact> contactsToUpdateInDb = new List<Contact>();
        Map<Id, Contact> existingContacts = new Map<Id, Contact>([Select Id, FirstName, LastName from Contact]);
        for (Contact cont : updateContacts){
            if(existingContacts.containsKey(cont.id)){
                Contact record = existingContacts.get(cont.id);
                record.FirstName = !String.isBlank(cont.FirstName) ? cont.FirstName : record.FirstName;
                record.LastName = !String.isBlank(cont.LastName) ? cont.LastName : record.LastName;
                contactsToUpdateInDb.add(record);
            }
        }
        try {
            update contactsToUpdateInDb;
            res.statusCode = 200;
            res.responseBody = Blob.valueOf('Records updated successfully');
        }
        catch(Exception e){
                res.statusCode = 500;
                res.responseBody = Blob.valueOf('An Error Has occured While trying to update the records: ' + e.getMessage());
            }  
     }
}


