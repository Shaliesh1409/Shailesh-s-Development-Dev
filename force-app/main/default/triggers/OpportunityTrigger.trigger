trigger OpportunityTrigger on Opportunity (before update, after update,before insert) {
    if (Trigger.isBefore) {
        if (Trigger.isUpdate || Trigger.isInsert) {
            OpportunityTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }
    } else if (Trigger.isAfter) {
        if (Trigger.isUpdate) {
            OpportunityTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}