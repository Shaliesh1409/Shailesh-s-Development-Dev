trigger triggerforopportunity on Opportunity (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    handlerforopportunity handler = new handlerforopportunity(trigger.new, trigger.old, trigger.newMap, trigger.oldMap, trigger.isInsert,trigger.isUpdate, trigger.isDelete, trigger.isUndelete);
    if(trigger.isBefore){
        if(trigger.isUpdate){
            handler.BeforeUpdateEvent();
        }
        else if(trigger.isInsert){
            handler.BeforeInsertEvent();
        }
    }
    else if(trigger.isAfter){
         if(trigger.isUpdate){
            handler.AfterUpdateEvent();
        }
    }
}