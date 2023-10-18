public class AccountTriggerHandler {
    public static void logTriggerContextVariables() {
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

    public static void sendEmailAlert(List<Account> updatedAccounts, Map<Id, Account> oldAccountMap) {
        Set<Id> accountIds = new Set<Id>();

        for (Account updatedAccount : updatedAccounts) {
            // Check if the Account's name has been modified
            if (oldAccountMap.get(updatedAccount.Id).Name != updatedAccount.Name) {
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

    public static void prefixAccountNames(List<Account> newAccounts) {
        for (Account acc : newAccounts) {
            acc.Name = 'Mr.' + acc.Name;
        }
    }

    public static void submitForApproval(List<Account> accounts) {
        List<Approval.ProcessSubmitRequest> approvalRequests = new List<Approval.ProcessSubmitRequest>();

        for (Account acc : accounts) {
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Submitted for approval. Please approve.');
            req.setObjectId(acc.Id);
            approvalRequests.add(req);
        }

        List<Approval.ProcessResult> results = Approval.process(approvalRequests);

        for (Approval.ProcessResult result : results) {
            System.debug('Submitted for approval successfully: ' + result.isSuccess());
        }
    }

    public static void createDependentContacts(List<Account> accounts) {
        List<Contact> dependentContacts = new List<Contact>();

        for (Account acc : accounts) {
            Contact con = new Contact();
            con.AccountId = acc.Id;
            con.LastName = acc.Name;
            dependentContacts.add(con);
        }

        // Insert dependent contacts
        if (!dependentContacts.isEmpty()) {
            insert dependentContacts;
        }
    }

    public static void deleteDuplicateAccounts(List<Account> newAccounts) {
        Set<String> newAccountNames = new Set<String>();
        for (Account newAccount : newAccounts) {
            newAccountNames.add(newAccount.Name);
        }

        List<Account> existingAccounts = [SELECT Id, Name FROM Account WHERE Name IN :newAccountNames];
        List<Account> accountsToDelete = new List<Account>();

        for (Account existingAccount : existingAccounts) {
            if (newAccountNames.contains(existingAccount.Name)) {
                accountsToDelete.add(existingAccount);
            }
        }

        if (!accountsToDelete.isEmpty()) {
            delete accountsToDelete;
        }
    }


    public static void shareAccountsWithWilson(List<Account> accountsToShare) {
        List<AccountShare> accountSharesToInsert = new List<AccountShare>();

        for (Account updatedAccount : accountsToShare) {
            if (updatedAccount.Rating == 'Hot') {
                AccountShare accountShare = new AccountShare();
                accountShare.AccountId = updatedAccount.Id;
                accountShare.UserOrGroupId = '0055j000009WjZY'; // Replace with the actual User or Group Id
                accountShare.AccountAccessLevel = 'Read';
                accountShare.OpportunityAccessLevel = 'None';
                accountSharesToInsert.add(accountShare);
            }
        }

        if (!accountSharesToInsert.isEmpty()) {
            insert accountSharesToInsert;
        }
    }
}