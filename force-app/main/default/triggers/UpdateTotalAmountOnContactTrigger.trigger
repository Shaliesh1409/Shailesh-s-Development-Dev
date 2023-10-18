trigger UpdateTotalAmountOnContactTrigger on Contact (after insert, after update, after delete) {
    Set<Id> accountIdsToUpdate = new Set<Id>();

    if (Trigger.isInsert || Trigger.isUpdate) {
        for (Contact contact : Trigger.new) {
            accountIdsToUpdate.add(contact.AccountId);
        }
    }
    
    if (Trigger.isDelete) {
        for (Contact contact : Trigger.old) {
            accountIdsToUpdate.add(contact.AccountId);
        }
    }

   
    List<Account> accountsToUpdate = new List<Account>();
    for (Id accountId : accountIdsToUpdate) {
        List<Contact> relatedContacts = [
            SELECT Amount__c
            FROM Contact
            WHERE AccountId = :accountId
        ];

        Decimal totalAmount = 0;
        for (Contact contact : relatedContacts) {
            if (contact.Amount__c != null) {
                totalAmount += contact.Amount__c;
            }
        }

        accountsToUpdate.add(new Account(Id = accountId, Total_Amount__c = totalAmount));
    }

    if (!accountsToUpdate.isEmpty()) {
        update accountsToUpdate;
    }


    
}