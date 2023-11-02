@IsTest
public class AccountRelatedObjAuraTest {

    static Id testAccountId;
    @TestSetup
    static void setupTestData() {
        Account testAccount = new Account(Name = 'Test Account', Description = 'initial description',Rating = 'Hot');
        insert testAccount;
        testAccountId=testAccount.Id;
 

        List<Opportunity> opplist = new List<Opportunity>();
            for(Integer i=0;i<10;i++){
                Opportunity testOpportunity = new Opportunity(
                    Name = 'Opportunity Name'+i,
                    StageName = 'Prospecting',
                    CloseDate = Date.today(),
                    AccountId = testAccount.Id
                );
                opplist.add(testOpportunity);
            }
                insert opplist;


        List<Contact> conlist = new List<Contact>();       
                for(Integer i=0;i<10;i++){
                    Contact testcontact = new Contact(
                        LastName = 'Opportunity Name'+i,
                        AccountId = testAccount.Id

                    );
                    conlist.add(testcontact);
                }
                    insert conlist ;
        }

        

    static testMethod void fetchAccountTest() {

        Test.startTest();
         List<Account> result = AccountRelatedObj.fetchAccount();
           System.assertEquals('Test Account', result[0].Name, 'Accounts fetched ');
           Test.stopTest();


    }

    static testMethod void getContactsTest() {

        Test.startTest();
        List<Contact> result = AccountRelatedObj.getContacts(testAccountId);
          System.assertEquals(10, result.size(), 'contacts fetched ');
          Test.stopTest();


   }

   static testMethod void fetchOpportunityTest() {

    Test.startTest();
    List<Opportunity> result = AccountRelatedObj.fetchOpportunity(testAccountId);
      System.assertEquals(10,result.size() , 'Opportunity fetched ');
      Test.stopTest();


}



}