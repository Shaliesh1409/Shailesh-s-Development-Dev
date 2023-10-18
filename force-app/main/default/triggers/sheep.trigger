trigger sheep on Contact (after update) {

    Set<Id> oldaccountId = new Set<Id>();
    String Idcon;
    String newacid;

    for(Contact oldcontacts : Trigger.old){
        System.debug('oldContacts.AccountId-->'+oldContacts.AccountId);
        System.debug('Trigger.newMap.get(oldContacts.Id).AccountId-->'+Trigger.newMap.get(oldContacts.Id).AccountId);

        newacid = Trigger.newMap.get(oldContacts.Id).AccountId;
        System.debug('newacid-=>'+newacid);

        if(oldcontacts.AccountId != null && oldContacts.AccountId != Trigger.newMap.get(oldContacts.Id).AccountId){
        oldaccountId.add(oldcontacts.AccountId);
        Idcon = oldcontacts.Id;
        }
    }
    
    // String newaccname = [SELECT Id, Name FROM Account WHERE Id =: newacid ].Name;

    System.debug('oldaccountId-->'+oldaccountId);
        
    List <Contact> relatedcontacts = [SELECT Id,AccountId, Account.Name, LastName    FROM Contact WHERE AccountId IN : oldaccountId AND Id !=: Idcon];
    List <Contact> contactstoupdate = new List<Contact>();
    System.debug('relatedcontacts-->'+relatedcontacts);
    System.debug('relatedcontacts-->'+relatedcontacts.size());
    // System.debug('newaccname-->'+newaccname);

    for ( Contact updateconaccid : relatedcontacts )
    if(updateconaccid.AccountId != null){
    {

        updateconaccid.AccountId = newacid;
        // System.debug('updateconaccid.LastName'+updateconaccid.LastName);
        contactstoupdate.add(updateconaccid);
        System.debug('contactstoupdate'+contactstoupdate);
    }
    }
    Update contactstoupdate;
    
}