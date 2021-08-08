trigger contacttrigger on Account (before insert, before delete) {
    /*List<Account> accountList = [Select Id, Name, (Select Id, FirstName, LastName From Contacts ) From Account];
   for (account a : accountList){
    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
    req1.setComments('Automatic submit.');
    req1.setObjectId(a.Contacts);

    // Submit the approval request for the account
    Approval.ProcessResult result = Approval.process(req1);
   }*/
   for(account a : trigger.new){
    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
    req1.setComments('Automatic submit.');
    req1.setObjectId(a.Contact);
    Approval.ProcessResult result = Approval.process(req1);
    if(result.isSuccess()){
        a.Contact.Active_c='true';
        a.Total_Contacts_c++;
    }
   }
}