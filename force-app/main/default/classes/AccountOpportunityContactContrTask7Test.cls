@IsTest
public with sharing class AccountOpportunityContactContrTask7Test {
    static testmethod void getAccountsWithOpportunitiesAndContactsTest() {
        Account acc = new Account(Name = 'Shailesh');
        Contact con = new Contact (LastName='Mishra', AccountId=acc.Id);
         Date closedate = Date.newInstance(2023, 10, 19);
        Opportunity opp = new Opportunity(Name='Shailesh opp',AccountId=acc.Id,CloseDate=closedate,StageName='Prospecting');

        insert acc;
        insert con;
        insert opp;

        List<AccountOpportunityContactController.AccountOpportunityContactWrapper> result =AccountOpportunityContactController.getAccountsWithOpportunitiesAndContacts();

        System.assertEquals(acc.Id,result[0].account.Id, 'Success');
        System.assertEquals(con.Id,result[0].contacts[0].Id, 'Success');
        System.assertEquals(opp.Id,result[0].opportunities[0].Id, 'Success');
        System.assertNotEquals(null, result, 'Success');






    }
}