public with sharing class Task3 {
    @AuraEnabled
    public static List<Contact> getContactsByAcc(String accountName) {  
        List<Contact> contacts = new List<Contact>();
        List<Account> accounts = [SELECT Id FROM Account WHERE Name = :accountName LIMIT 1 ];
        
        if (!accounts.isEmpty()) {
            contacts = [SELECT Id, Name, Email,	Phone FROM Contact WHERE AccountId = :accounts[0].Id ];         
        }
        return contacts;
    }
    @AuraEnabled
    public static Integer getContactcount(String accountName) {

        List<Account> accounts = [SELECT Id FROM Account WHERE Name = :accountName LIMIT 1 ];
        Integer contactcount =[SELECT COUNT()
        FROM Contact WHERE AccountId = :accounts[0].Id];

        System.debug('contactcount' +contactcount);

        return contactcount;
       
    }

    // @AuraEnabled
    // public static void updateContactParentAccount(String contactId, String newAccountName) {
    //     try {
    //         // Query the Contact record to get the current parent Account Id
    //         Contact contactToUpdate = [SELECT Id, AccountId FROM Contact WHERE Id = :contactId LIMIT 1];

    //         if (contactToUpdate != null) {
    //             // Query the new parent Account based on the provided Account Name
    //             Account newAccount = [SELECT Id FROM Account WHERE Name = :newAccountName LIMIT 1];

    //             if (newAccount != null) {
    //                 // Update the Contact's AccountId to the new parent Account's Id
    //                 contactToUpdate.AccountId = newAccount.Id;

    //                 // Update the Contact
    //                 update contactToUpdate;
    //             }
    //         }
    //     } catch (Exception e) {
    //         // Handle any exceptions that occur during the update
    //         // You can log the error or throw a custom exception if needed
    //         throw new AuraHandledException('Error updating contact\'s parent account: ' + e.getMessage());
    //     }
    // }
}