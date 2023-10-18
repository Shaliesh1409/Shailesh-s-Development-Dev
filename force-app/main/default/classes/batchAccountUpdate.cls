public class batchAccountUpdate implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator([
            SELECT Id, Name, Account.Name
            FROM Opportunity
            WHERE AccountId != null
        ]);
    }

    public void execute(Database.BatchableContext context, List<Opportunity> scope) {
        try {
            List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
        
            for (Opportunity opp : scope) {
                if (opp.Name != opp.Account.Name) {
                    opp.Name = opp.Account.Name;
                    opportunitiesToUpdate.add(opp);
                }
            }
            
            if (!opportunitiesToUpdate.isEmpty()) {
                update opportunitiesToUpdate;
            }   
        } catch (Exception e) {
            System.debug('ERROR+++>>>'+e.getMessage());
            System.debug('ERROR+++>>>'+e.getLineNumber());
        }
    }

    public void finish(Database.BatchableContext context) {
    }
}