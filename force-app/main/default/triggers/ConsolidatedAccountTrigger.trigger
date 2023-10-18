trigger ConsolidatedAccountTrigger on Account (before insert, before update, after update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            AccountTriggerHandler.prefixAccountNames(Trigger.new);
            AccountTriggerHandler.deleteDuplicateAccounts(Trigger.new);
        }
    }

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            AccountTriggerHandler.createDependentContacts(Trigger.new);
            AccountTriggerHandler.submitForApproval(Trigger.new);

        }
        if (Trigger.isUpdate ) {
            AccountTriggerHandler.sendEmailAlert(Trigger.new, Trigger.oldMap);

        }
        if (Trigger.isInsert || Trigger.isUpdate) {
            AccountTriggerHandler.shareAccountsWithWilson(Trigger.new);
        }
    }

    if (Trigger.isBefore || Trigger.isAfter) {
        AccountTriggerHandler.logTriggerContextVariables();
    }
}