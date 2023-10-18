trigger ShareAccountWithWilsonTrigger on Account(after insert,after update){

    List<AccountShare> accountSharesToInsert = new List<AccountShare>();
    if(Trigger.isInsert && Trigger.isAfter){
    for (Account updatedAccount : Trigger.new){

        if( updatedAccount.Rating=='Hot'){

            AccountShare accountShare = new AccountShare();
            System.debug(' updatedAccount.Id ' +updatedAccount.Id);
            accountShare.AccountId = updatedAccount.Id;
            accountShare.UserOrGroupId = '0055j000009WjZY'; 
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