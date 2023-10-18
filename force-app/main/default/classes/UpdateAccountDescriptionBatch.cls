public class UpdateAccountDescriptionBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator([
            SELECT Id, Description
            FROM Account
        ]);
    }

    public void execute(Database.BatchableContext context, List<Account> scope) {
        for (Account acc : scope) {
            acc.Description = DateTime.now().format('MM/dd/yyyy HH:mm:ss');
        }
        update scope;
    }

    public void finish(Database.BatchableContext context) {
    }
}