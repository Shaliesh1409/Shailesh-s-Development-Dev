public class ContactTriggerHandler {
    public static void handleInsert(List<Contact> newContacts) {
        List<Event> eventsToInsert = new List<Event>();
        for (Contact newContact : newContacts) {
            Event newEvent = new Event();
            newEvent.Subject = 'New Contact Created';
            newEvent.StartDateTime = System.now(); 
            newEvent.EndDateTime = System.now().addHours(1); 
            newEvent.WhoId = newContact.Id; 
            eventsToInsert.add(newEvent);
        }

        if (!eventsToInsert.isEmpty()) {
            insert eventsToInsert;
        }
    }

    public static void handleDelete(List<Contact> deletedContacts) {
        List<Id> accountIds = new List<Id>();
        for(Contact c : deletedContacts){
            accountIds.add(c.AccountId);
        }

        List<Account> accdelete = [SELECT Id FROM Account WHERE Id IN :accountIds];
        if(!accdelete.isEmpty()) {
            delete accdelete;
        }
    }

    public static void handleBefore(List<Contact> newContacts, Map<Id, Contact> oldContactMap) {
        Map<Id, Decimal> accountMaxAmounts = new Map<Id, Decimal>();

        Set<Id> accountIds = new Set<Id>();
        for (Contact contact : newContacts) {
            accountIds.add(contact.AccountId);
        }

        for (Account account : [SELECT Id, Max_Amount__c FROM Account WHERE Id IN :accountIds]) {
            accountMaxAmounts.put(account.Id, account.Max_Amount__c);
        }

        List<Contact> contactsToUpdate = new List<Contact>();

        for (Contact contact : newContacts) {
            if (accountMaxAmounts.containsKey(contact.AccountId)) {
                Decimal maxAmount = accountMaxAmounts.get(contact.AccountId);
                Decimal contactAmount = contact.Amount__c;

                System.debug('contactAmount-->' + contactAmount);
                System.debug('maxAmount-->' + maxAmount);

                if (contactAmount > maxAmount) {
                    Contact con = new Contact();
                    con.LastName = contact.LastName + ' Shailesh';
                    con.Amount__c = contactAmount - maxAmount;
                    con.AccountId = contact.AccountId;
                    insert con;

                    contact.Amount__c = maxAmount;
                }
            }
        }

        if (!contactsToUpdate.isEmpty()) {
            insert contactsToUpdate;
        }

        List<Contact> contactsToDelete = [SELECT Id FROM Contact WHERE AccountId IN :accountMaxAmounts.keySet()];
        delete contactsToDelete;
    }
}