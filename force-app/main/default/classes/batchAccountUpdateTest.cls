@isTest
public class batchAccountUpdateTest{
    @TestSetup
    static void setupTestData() {
        Account testAccount = new Account(Name = 'Test Account', Description = 'initial description',Rating = 'Hot');
        insert testAccount;

        Opportunity testOpportunity = new Opportunity(
            Name = 'Opportunity Name',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            AccountId = testAccount.Id
        );
        insert testOpportunity;
    }

    @isTest
    static void testBatchExecution() {
        Test.startTest();

        batchAccountUpdate batchJob = new batchAccountUpdate();
        Database.executeBatch(batchJob);

        Test.startTest();

        Opportunity updatedOpportunity = [SELECT Id, Name FROM Opportunity];

        System.assertEquals('Test Account', updatedOpportunity.Name, 'Opportunity name should be updated');
    }

    @isTest
    static void testupdateAccountDescription(){
        Test.startTest();
        UpdateAccountDescriptionBatch batchjob  = new UpdateAccountDescriptionBatch();
        Database.ExecuteBatch(batchjob) ;
        Test.stopTest();    
        Account updatedAccount = [SELECT Id,Description FROM ACCOUNT];
        System.assertNotEquals ('initial description',updatedAccount.Description) ;
}

    @isTest 
    static void TestUpdateRating(){
        Test.StartTest();
        String CRON_EXP = '0 10 16 * * ? 2023';
        System.schedule('BorrarAseguradosTest', CRON_EXP, new UpdateRating());

        // UpdateRating scheduled = new UpdateRating();
        // UpdateRating.execute(null);

        Account updatedAccount = [SELECT Id,Rating FROM Account];
        System.assertEquals('warm',updatedAccount.Rating);
        Test.stopTest();

      
    }
}