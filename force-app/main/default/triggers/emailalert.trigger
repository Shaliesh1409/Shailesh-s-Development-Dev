trigger emailalert on Account (after update) {
    Set<Id> accountIds = new Set<Id>();

    for (Account updatedAccount : Trigger.new) {
        // Check if the Account's name has been modified
        if (Trigger.oldMap.get(updatedAccount.Id).Name != updatedAccount.Name) {
            accountIds.add(updatedAccount.Id);
        }
    }

    if (!accountIds.isEmpty()) {
        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        List<Contact> relatedContacts = [SELECT Id, Email FROM Contact WHERE AccountId IN :accountIds];

        for (Contact contact : relatedContacts) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{contact.Email});
            email.setSubject('Account Name Update Notification');
            email.setPlainTextBody('The name of the associated Account has been updated.');

            emailMessages.add(email);
        }

        if (!emailMessages.isEmpty()) {
            Messaging.sendEmail(emailMessages);
        }
    }
}