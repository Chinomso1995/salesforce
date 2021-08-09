public with sharing class Utils {
    public Utils() {

    }
    public static sObject findRecord(List<sObject> recordBank, String fieldApiName, Object value){
         for(sObject record : recordBank){
             if(record.get(fieldApiName) == value){
                 return record;
             }
         }
         return null;
    }
}
