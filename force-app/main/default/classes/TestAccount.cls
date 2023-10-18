@isTest public  class TestAccount {
    
    @TestSetup static void set(){
        List<Account> Accountstoinsert = new List<Account>();
        for(Integer i=0; i<2 ; i++){
            String accname = 'shailesh'+i;
            Account acc = new Account(Name=accname);

            AccountstoInsert.add(acc);
        } 
        Test.startTest();
        insert Accountstoinsert ;
        System.debug('accounts inserted successfully'+AccountstoInsert[0].Name);
        Test.stopTest();

    }

    static testMethod void TestprefixAccountNames(){
        List<Account> insertedAccounts = [SELECT Name FROM Account WHERE Name LIKE 'shailesh%' LIMIT 2];
        for(Account acc : insertedAccounts ){
            System.assertEquals('Mr.shailesh0',acc.Name);
        }

    }


}