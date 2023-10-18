trigger ctreateddependency on Account (After  insert) {
    list<Contact> lstCon = new list<Contact>();
    for(Account Acc: trigger.new){
        Contact con = new Contact ();
        Con.AccountId = Acc.Id;
        Con.LastName = Acc.Name;
        lstCon.Add(Con);
        
    }
insert lstCon;
System.debug('success');
}