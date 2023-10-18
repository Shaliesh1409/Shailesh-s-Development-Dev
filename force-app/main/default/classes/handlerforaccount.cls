public class handlerforaccount { 
    List<Account> recordNewList = new List<Account>();
    List<Account> recordOldList = new List<Account>();
    Map<Id, Account> recordNewMap = new Map<Id, Account>();
    Map<Id, Account> recordOldMap = new Map<Id, Account>();
    Boolean isInsert, isUpdate, isDelete, isUndelete = false;
    public static boolean recursionController = true;
    public static boolean flag = true;
    
    public handlerforaccount(List<Account> newList, List<Account> oldList, Map<Id, Account> newMap, Map<Id, Account> oldMap, boolean isInsert, boolean isUpdate, Boolean isDelete, Boolean isUndelete) {
        this.recordNewList = newList;
        this.recordOldList = oldList;
        this.recordNewMap = newMap;
        this.recordOldMap = oldMap;
        this.isInsert = isInsert;
        this.isUpdate = isUpdate;
        this.isDelete = isDelete;
        this.isUndelete = isUndelete;
    }
    
    public void BeforeInsertEvent(){
        prefixAccountNames();
        deleteDuplicateAccounts();
    }
    
    public void BeforeUpdateEvent(){}
    
    public void BeforeDeleteEvent(){}
    
    public void AfterInsertEvent(){
        submitForApproval();
        createDependentContacts();
        logTriggerContextVariables();
    }
    
    public void AfterUpdateEvent(){
        sendEmailAlert();
        shareAccountsWithWilson();

    }
    
    public void AfterDeleteEvent(){}
    
    public void AfterUndeleteEvent(){}

    public void submitForApproval() {
        List<Approval.ProcessSubmitRequest> approvalRequests = new List<Approval.ProcessSubmitRequest>();

        for (Account acc : recordNewList) {
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


    public void createDependentContacts() {
        List<Contact> dependentContacts = new List<Contact>();

        for (Account acc : recordNewList) {
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


    public void logTriggerContextVariables() {
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


    public void sendEmailAlert() {
        Set<Id> accountIds = new Set<Id>();

        for (Account updatedAccount : recordNewList) {
            // Check if the Account's name has been modified
            if (recordOldMap.get(updatedAccount.Id).Name != updatedAccount.Name) {
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

    public void prefixAccountNames() {
        for (Account acc : recordNewList) {
            acc.Name = 'Mr.' + acc.Name;
        }
    }

    public void deleteDuplicateAccounts() {
        Set<String> newAccountNames = new Set<String>();
        for (Account newAccount : recordNewList) {
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



    public void shareAccountsWithWilson() {
        List<AccountShare> accountSharesToInsert = new List<AccountShare>();

        String targetUserOrGroupId = System.Label.TargetUserOrGroupIdLabel;

        for (Account updatedAccount : recordNewList) {
            if (updatedAccount.Rating == 'Hot') {
                AccountShare accountShare = new AccountShare();
                accountShare.AccountId = updatedAccount.Id;
                accountShare.UserOrGroupId = targetUserOrGroupId; // Replace with the actual User or Group Id
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