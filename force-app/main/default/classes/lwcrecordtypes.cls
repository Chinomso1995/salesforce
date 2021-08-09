public with sharing class lwcrecordtypes {
    public lwcrecordtypes() {

    }
    @AuraEnabled(cacheable=true)
    public static List<List<sObject>> retrieveContactData(string keySearch){       
        return [Find :keySearch IN All Fields RETURNING Contact(Id,Name), Account(Id,Name)];
    }
}
