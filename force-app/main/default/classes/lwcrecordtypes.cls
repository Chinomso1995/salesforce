public with sharing class lwcrecordtypes {
    public lwcrecordtypes() {

    }
    @AuraEnabled(cacheable=true)
    public static List<String> retrieveContactData(string keySearch){       
        List<List<sObject>> contactAndAccountList = [Find :keySearch IN All Fields RETURNING Contact(Id), Account(Id) ];
        List<String> ids = new List<String>();
        for (List<SObject> sobjs : contactAndAccountList) {
            for (SObject sobj : sobjs) {
              ids.add(sobj.Id);
            }
          }
        return ids;
    }
}
