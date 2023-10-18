trigger DeleteDuplicateAccountsTrigger on Account (before insert) {
    List<Account> accountsToDelete = new List<Account>();
    Set<String> newAccountNames = new Set<String>();
    for (Account newAccount : Trigger.new) {
        newAccountNames.add(newAccount.Name);
    }
    // Query for existing accounts with the same name
    List<Account> existingAccounts = [SELECT Id, Name FROM Account WHERE Name IN :newAccountNames];
    // Identify accounts to delete
    for (Account existingAccount : existingAccounts) {
        // Check if the existing account's name matches one of the new accounts being inserted
        if (newAccountNames.contains(existingAccount.Name)) {
            accountsToDelete.add(existingAccount);
        }
    }
    // Delete the duplicate accounts
    if (!accountsToDelete.isEmpty()) {
        delete accountsToDelete;
    }
}