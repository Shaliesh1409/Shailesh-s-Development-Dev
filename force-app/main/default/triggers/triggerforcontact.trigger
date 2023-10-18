trigger triggerforcontact on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    handlerforcontact handler = new handlerforcontact(trigger.new, trigger.old, trigger.newMap, trigger.oldMap, trigger.isInsert,trigger.isUpdate, trigger.isDelete, trigger.isUndelete);
    if(trigger.isAfter){
        if(trigger.isInsert){
            handler.AfterInsertEvent();
        }
        else if(trigger.isUpdate){
            handler.AfterUpdateEvent();
        }
        else if(trigger.isDelete){
            handler.AfterDeleteEvent();
        }
    }
    else if(trigger.isBefore){
        if(trigger.isInsert){
            handler.BeforeInsertEvent();
        }else if(trigger.isUpdate){
            handler.BeforeUpdateEvent();
        }else if(trigger.isDelete){
        //    handler.BeforeDeleteEvent();
        }
    }
}