public class handlerforcontact { 
    List<Contact> recordNewList = new List<contact>();
    List<Contact> recordOldList = new List<contact>();
    Map<Id, contact > recordNewMap = new Map<Id, contact>();
    Map<Id, contact> recordOldMap = new Map<Id, contact>();
    Boolean isInsert, isUpdate, isDelete, isUndelete = false;
    public static boolean recursionController = true;
    public static boolean flag = true;
    
    public handlerforcontact(List<contact> newList, List<contact> oldList, Map<Id, contact> newMap, Map<Id, contact> oldMap, boolean isInsert, boolean isUpdate, Boolean isDelete, Boolean isUndelete) {
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
        GreatProblem2Logic();
    }
    
    public void BeforeUpdateEvent(){
        GreatProblem2Logic();
    }
    
    public void BeforeDeleteEvent(){
        System.debug('*****BeforeDeleteEvent*****');
        GreatProblem2Logic();
        //UpdateTotalAmountOnContact();
    }
    
    public void AfterInsertEvent(){
        Event();
        UpdateTotalAmountOnContact();
        
    }
    
    public void AfterUpdateEvent(){
        UpdateTotalAmountOnContact();
        UpdateContactAccounts();
        
    }
    
    public void AfterDeleteEvent(){
       Deleteaccounts();
    //    UpdateTotalAmountOnContact();
    }
    
    public void AfterUndeleteEvent(){}

    public void Event() {
        List<Event> eventsToInsert = new List<Event>();
        for (Contact newContact : recordNewList ) {
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

    // public void Deleteaccounts() {
    //     List<Id> accountIds = new List<Id>();
    //     for(Contact c : recordOldList){
    //         accountIds.add(c.AccountId);
    //     }
    //     List<Account> accdelete = [SELECT Id FROM Account WHERE Id IN :accountIds];
    //     if(!accdelete.isEmpty()) {
    //         delete accdelete;
    //     }
    // }


    public void DeleteAccounts() {
        try{
                    Set<Id> accountIds = new Set<Id>();
    
        // Collect the AccountIds from the related Contacts
        for (Contact c : recordOldList) {
            System.debug('contact account id-->' +c.AccountId);
            if (c.AccountId != null){
            accountIds.add(c.AccountId);
            }
        }
    
        // Delete the related Account records
        if (!accountIds.isEmpty()) { 
            List<Account> accToDelete = new List<Account>();
            
            for (Id accId : accountIds) {
                accToDelete.add(new Account(Id = accId));
            }
            
            if(!acctodelete.isEmpty()){
                delete accToDelete;
            }
        }
        }catch(Exception e){
            System.debug('Error creating Error Log: ' + e.getMessage());
        }
    }
    

    public void UpdateTotalAmountOnContact() {
        System.debug('*****UpdateTotalAmountOnContact*****');
        Set<Id> accountIdsToUpdate = new Set<Id>();
    
        if (isInsert || isUpdate) {
            for (Contact contact : recordNewList) {
                accountIdsToUpdate.add(contact.AccountId);
            }
        }
    
        if (isDelete) {
            for (Contact contact : recordOldList) {
                accountIdsToUpdate.add(contact.AccountId);
            }
        }


        // Added by Nimit
        if(isInsert){
            Map<Id , Account> mapofacc = new Map<Id, Account>([ SELECT Id,Total_Amount__c FROM Account WHERE Id IN: accountIdsToUpdate ]);
            List<Account> acclist = new List<Account>();
            for (Contact con : recordNewList) {
                if(con.AccountId != null){
                    Account acc = mapofacc.get(con.AccountId);
                    if(acc.Total_Amount__c != null){
                        acc.Total_Amount__c += con.Amount__c;
                    } else {
                        acc.Total_Amount__c = 0;
                        acc.Total_Amount__c += con.Amount__c;
                    }
                    acclist.add(acc);
                }
            }
            update acclist;
        } else if (isUpdate) {
            Map<Id , Account> mapofacc = new Map<Id, Account>([ SELECT Id,Total_Amount__c FROM Account WHERE Id IN: accountIdsToUpdate ]);
                for (Contact newCon : recordNewList) {
                    Contact oldCon = recordOldMap.get(newCon.Id);
    
                    if ( newCon.Amount__c != oldCon.Amount__c) {
                        if (newCon.AccountId != null) {        
                            Account acc = mapOfAcc.get(newCon.AccountId);
        
                            if (acc.Total_Amount__c != null) {
                                acc.Total_Amount__c += newCon.Amount__c - oldCon.Amount__c;
                            } else {
                                acc.Total_Amount__c = 0;
                                acc.Total_Amount__c += newCon.Amount__c - oldCon.Amount__c;
                            }
                            
                        }
        
                    }
                }
        
                if (!mapOfAcc.isEmpty()) {
                    update mapOfAcc.values();
                }
            } else if(isDelete){
                System.debug('delete Shailesh');
                System.debug('delete');
                Map<Id , Account> mapofacc = new Map<Id, Account>([ SELECT Id,Total_Amount__c FROM Account WHERE Id IN: accountIdsToUpdate ]);
                    for (Contact oldCon : recordOldList) {
                        if (oldCon.AccountId != null) {
                            Account acc = mapOfAcc.get(oldCon.AccountId);

                            if (acc.Total_Amount__c != null) {
                                acc.Total_Amount__c -= oldCon.Amount__c;
                            } else {
                                acc.Total_Amount__c = 0;
                            }
                        }
                    }
                    if (!mapOfAcc.isEmpty()) {
                        update mapOfAcc.values();
                    }
            }
        }


    //      if (Trigger.isUpdate) {
    //         // Logic for update operation
    //         for (Contact newCon : Trigger.new) {
    //             Contact oldCon = Trigger.oldMap.get(newCon.Id);
    
    //             if (newCon.AccountId != oldCon.AccountId || newCon.Amount__c != oldCon.Amount__c) {
    //                 // Contact's Account or Amount__c field has changed
    //                 // we may want to update related Account records here
    //                 // Here, we will use similar logic as the insert operation
    //                 if (newCon.AccountId != null) {
    //                     // Check if the Account is already in the map, or query it if not
    //                     if (!mapOfAcc.containsKey(newCon.AccountId)) {
    //                         mapOfAcc.put(newCon.AccountId, new Account(Id = newCon.AccountId));
    //                     }
    
    //                     Account acc = mapOfAcc.get(newCon.AccountId);
    
    //                     if (acc.Total_Amount__c != null) {
    //                         acc.Total_Amount__c += newCon.Amount__c - oldCon.Amount__c;
    //                     } else {
    //                         acc.Total_Amount__c = 0;
    //                         acc.Total_Amount__c += newCon.Amount__c - oldCon.Amount__c;
    //                     }
    //                 }
    
    //             }
    //         }
    
    //         if (!mapOfAcc.isEmpty()) {
    //             update mapOfAcc.values();
    //         }
    //     }
    // }
    // added by shailesh
        // Added by Nimit
    
    //     List<Account> accountsToUpdate = new List<Account>();
    //     for (Id accountId : accountIdsToUpdate) {
    //         List<Contact> relatedContacts = [
    //             SELECT Amount__c
    //             FROM Contact
    //             WHERE AccountId = :accountId
    //         ];
    
    //         Decimal totalAmount = 0;
    //         for (Contact contact : relatedContacts) {
    //             if (contact.Amount__c != null) {
    //                 totalAmount += contact.Amount__c;
    //             }
    //         }
    
    //         accountsToUpdate.add(new Account(Id = accountId, Total_Amount__c = totalAmount));
    //     }
    
    //     if (!accountsToUpdate.isEmpty()) {
    //         update accountsToUpdate;
    //     }
    // }


  // SHEEP PROBLEM 

  public void UpdateContactAccounts() {
    Set<Id> oldaccountId = new Set<Id>();
    String Idcon;
    String newacid;

    for (Contact oldcontacts : recordOldList) {
        System.debug('oldContacts.AccountId-->' + oldcontacts.AccountId);
        System.debug('recordNewMap.get(oldcontacts.Id).AccountId-->' + recordNewMap.get(oldcontacts.Id).AccountId);

        newacid = recordNewMap.get(oldcontacts.Id).AccountId;
        System.debug('newacid-=>' + newacid);

        if (oldcontacts.AccountId != null && oldcontacts.AccountId != recordNewMap.get(oldcontacts.Id).AccountId) {
            oldaccountId.add(oldcontacts.AccountId);
            Idcon = oldcontacts.Id;
        }
    }

    System.debug('oldaccountId-->' + oldaccountId);

    List<Contact> relatedcontacts = [SELECT Id, AccountId, Account.Name, LastName FROM Contact WHERE AccountId IN :oldaccountId AND Id != :Idcon];
    List<Contact> contactstoupdate = new List<Contact>();
    System.debug('relatedcontacts-->' + relatedcontacts);
    System.debug('relatedcontacts-->' + relatedcontacts.size());

    for (Contact updateconaccid : relatedcontacts) {
        if (updateconaccid.AccountId != null) {
            updateconaccid.AccountId = newacid;
            contactstoupdate.add(updateconaccid);
            System.debug('contactstoupdate' + contactstoupdate);
        }
    }

    if (!contactstoupdate.isEmpty()) {
        update contactstoupdate;
    }
}
    
        // THE GREAT PROBLEM 

        public void GreatProblem2Logic() {
            System.debug('***GreatProblem2Logic***');
            try {
                
            
            Map<Id, Decimal> accountMaxAmounts = new Map<Id, Decimal>();
        
            if (Trigger.isBefore) {
                Set<Id> accountIds = new Set<Id>();
                for (Contact contact : recordNewList) {
                    accountIds.add(contact.AccountId);
                }
        
                for (Account account : [SELECT Id, Max_Amount__c FROM Account WHERE Id IN :accountIds]) {
                    accountMaxAmounts.put(account.Id, account.Max_Amount__c);
                }
            }
        
            if (isInsert || isUpdate) {
                List<Contact> contactsToUpdate = new List<Contact>();
        
                for (Contact contact : recordNewList) {
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
            
            }
        
            if (isDelete) {
                List<Contact> contactsToDelete = [SELECT Id FROM Contact WHERE AccountId IN :accountMaxAmounts.keySet()];
                delete contactsToDelete;
            }
        } catch (Exception e) {
            System.debug('Error-->'+e.getMessage() +'----' +e.getLineNumber());
        }
        }
        

        
        }