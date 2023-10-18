trigger DisplayTriggerContextVariables on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    // Log the Trigger Context Variables
    System.debug('--- Trigger Context Variables ---');
    System.debug('IsExecuting: ' + Trigger.isExecuting);
    System.debug('IsInsert: ' + Trigger.isInsert);
    System.debug('IsUpdate: ' + Trigger.isUpdate);
    System.debug('IsDelete: ' + Trigger.isDelete);
    System.debug('IsBefore: ' + Trigger.isBefore);
    System.debug('IsAfter: ' + Trigger.isAfter);
    System.debug('IsUndelete: ' + Trigger.isUndelete);
    System.debug('New Records: ' + Trigger.new);
    System.debug('Old Records: ' + Trigger.old);
    System.debug('New Map: ' + Trigger.newMap);
    System.debug('Old Map: ' + Trigger.oldMap);
    System.debug('User ID: ' + UserInfo.getUserId());
    System.debug('--- End of Trigger Context Variables ---');
}