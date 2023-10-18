trigger ConsolidatedContactTrigger on Contact (after insert, after update, after delete, before insert, before update, before delete) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            ContactTriggerHandler.handleBefore(Trigger.new, Trigger.oldMap);
        }
    }
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            ContactTriggerHandler.handleInsert(Trigger.new);
        }
        if (Trigger.isDelete) {
            ContactTriggerHandler.handleDelete(Trigger.old);
        }
    }
}