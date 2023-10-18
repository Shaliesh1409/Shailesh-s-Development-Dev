trigger TriggerForAccount on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    handlerforaccount handler = new handlerforaccount(trigger.new, trigger.old, trigger.newMap, trigger.oldMap, trigger.isInsert,trigger.isUpdate, trigger.isDelete, trigger.isUndelete);
    if(trigger.isAfter){
        if(trigger.isInsert){
            handler.AfterInsertEvent();
        }
        else if(trigger.isUpdate){
            handler.AfterUpdateEvent();
        }
    }
    else if(trigger.isBefore){
        if(trigger.isInsert){
            handler.BeforeInsertEvent();
        }
    }
}