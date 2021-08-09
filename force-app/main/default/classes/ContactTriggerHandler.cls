public with sharing class ContactTriggerHandler {
    public ContactTriggerHandler() {

    }
    private static Map<id,Account> allAccounts = new Map<Id,Account>([Select Id , Name,  Total_Contacts__c from Account]);
    
    public static void handle (Map<Id, Contact> newContacts) {
        System.debug(allAccounts.size());
        System.debug(newContacts.size());
        map<Id,List<Contact>> accountToContactMap = new Map<Id,List<Contact>>();
        List<Account> accountToUpdate  = new List<Account>();
        if(newContacts != null && newContacts.size()>0){
           
            for(Id contactId : newContacts.keySet()){
                Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                System.debug(contactId);
                req1.setComments('Automatic submit.');
                req1.setObjectId(contactId);
                Approval.ProcessResult result = Approval.process(req1);
                List<Id> newWorkItemIds = result.getNewWorkitemIds();
                Approval.ProcessWorkitemRequest req2 = new Approval.ProcessWorkitemRequest();
                req2.setComments('Approving request.');
                req2.setAction('Approve');
                req2.setWorkitemId(newWorkItemIds.get(0));
                Approval.ProcessResult result2 =  Approval.process(req2);
                //System.debug(result);
                Contact contVar = newContacts.get(contactId);
                System.debug(allAccounts.get(contVar.accountId).name);
                System.debug(contVar.accountId);
                if(accountToContactMap.containsKey(contVar.accountId)){
                    System.debug('contain account');
                    accountToContactMap.get(contVar.accountId).add(contVar);
                }
                else{
                    accountToContactMap.put(contVar.accountId, new List<Contact>{contVar});
                    System.debug('does not contain account');
                }
            } 
            System.debug(accountToContactMap.size());
            for(Id accountId : accountToContactMap.keySet()){
                if(allAccounts.containsKey(accountId)){
                    Account parentAccount = allAccounts.get(accountId);
                    System.debug(accountToContactMap.get(accountId).size());
                    parentAccount.Total_Contacts__c = accountToContactMap.get(accountId).size();
                    accountToUpdate.add(parentAccount);
                }
            }
            upsert accountToUpdate;
        }
        
    }
    public static void handleDelete (Map<Id, Contact> deletedContacts){
        List<Account> accountUpdate = new List<Account>();
        for (Id contactId : deletedContacts.keySet()){
            Contact deleteContVar = deletedContacts.get(contactId);
            if(allAccounts.containsKey(deleteContVar.accountId)){
                Account parentAccount = allAccounts.get(deleteContVar.accountId);
                parentAccount.Total_Contacts__c--;
                accountUpdate.add(parentAccount);
            }
        }
        upsert accountUpdate;
    }
}
