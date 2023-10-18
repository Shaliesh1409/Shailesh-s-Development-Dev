trigger greatproblem2 on Contact (before insert, before update, before delete) {
    Map<Id, Decimal> accountMaxAmounts = new Map<Id, Decimal>();

    if (Trigger.isBefore) {
        Set<Id> accountIds = new Set<Id>();
        for (Contact contact : Trigger.new) {
            accountIds.add(contact.AccountId);
        }

        for (Account account : [SELECT Id, Max_Amount__c FROM Account WHERE Id IN :accountIds]) {
            accountMaxAmounts.put(account.Id, account.Max_Amount__c);
        }
    }

    if (Trigger.isInsert || Trigger.isUpdate) {
        List<Contact> contactsToUpdate = new List<Contact>();

        for (Contact contact : Trigger.new) {
            if (accountMaxAmounts.containsKey(contact.AccountId)) {
                Decimal maxAmount = accountMaxAmounts.get(contact.AccountId);
                Decimal contactAmount = contact.Amount__c;
                System.debug('contactAmount-->'+contactAmount);
                System.debug('maxAmount-->'+maxAmount);
                if (contactAmount > maxAmount) {
                    // Contact newContact = contact.clone(true,true,true,true);
                    // newContact.Amount__c = maxAmount

                    // 80 > 50

                    Contact con = new Contact();
                    con.LastName = contact.LastName + ' Shailesh';
                    con.Amount__c = contactAmount - maxAmount;
                    con.AccountId = contact.AccountId;
                    insert con;

                    contact.Amount__c = maxAmount;

                    // while (contactAmount > maxAmount) {
                    //     Contact newContact = contact.clone(true,true,true,true);
                    //     newContact.Amount__c = maxAmount;
                    //     System.debug('maxamount-->'+maxAmount);
                    //     contactsToUpdate.add(newContact);
                    //     System.debug('contactamount-->'+contactAmount);
                    //     contactAmount -= maxAmount;
                    //     System.debug('maxamount-->'+contactAmount);
                    // }
                }
            }
        }

        if (!contactsToUpdate.isEmpty()) {
            insert contactsToUpdate;
        }
    }
    
    if (Trigger.isDelete) {
        List<Contact> contactsToDelete = [SELECT Id FROM Contact WHERE AccountId IN :accountMaxAmounts.keySet()];
        delete contactsToDelete;
    }
}