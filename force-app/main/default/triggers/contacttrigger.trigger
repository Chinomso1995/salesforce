trigger contacttrigger on Contact (before insert, after insert, before update, before delete) {
   
 if(trigger.isInsert && trigger.isAfter){
    System.debug('executing after insert');
    ContactTriggerHandler.handle(Trigger.newMap);
 }
  if(trigger.isDelete){
      contactTriggerHandler.handleDelete(Trigger.OldMap);
  }
 }
   