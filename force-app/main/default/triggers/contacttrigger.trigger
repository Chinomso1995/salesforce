trigger contacttrigger on Contact (before insert, before delete) {
    /*List<Account> accountList = [Select Id, Name, (Select Id, FirstName, LastName From Contacts ) From Account];
   for (account a : accountList){
    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
    req1.setComments('Automatic submit.');
    req1.setObjectId(a.Contacts);

    // Submit the approval request for the account
    Approval.ProcessResult result = Approval.process(req1);
   }*/
   

   for(Contact c : [Select Id, Active__c, Account.Total_Contacts__c from Contact ]){
       Boolean Active = c.Active__c;
       Decimal TotalAccounts = c.Account.Total_Contacts__c;
       if(trigger.isInsert){
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Automatic submit.');
        req1.setObjectId(c.Id);
        Approval.ProcessResult result = Approval.process(req1);
        if(result.isSuccess()){
            Active = true;
            TotalAccounts++;
        }
       }
      if(trigger.isDelete){
          TotalAccounts--;
      }
   }
}