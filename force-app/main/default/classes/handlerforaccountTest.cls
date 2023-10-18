@isTest
public class handlerforaccountTest {
    //   List<Account> newaccount = new List<Account>();
    //  static List<Contact> newcontact = new List<Contact>();

    @TestSetup static void Setup() {
        // List<Contact> newContact = new List<Contact>();
        List<Account> newaccount = new List<Account>();

        for (Integer i=0 ; i<2 ; i++){
                String accname = 'test account'+i;
                Account acc = new Account(Name=accname,Rating = 'Hot');
                newaccount.add(acc);
                // String conEmail = 'testcontact' + i + '@example.com';
                // Contact con = new Contact(LastName='test contact'+i , AccountId=acc.Id ,Email=conEmail);
                // newContact.add(con);
        } 
        // for(Integer i=0 ; i<2 ; i++){
        //     String conEmail = 'testcontact' + i + '@example.com';
        //     Contact con = new Contact(LastName='test contact'+i,Email=conEmail,AccountId=newaccount[i].Id);
        //     newcontact.add(con);
        // }

        Test.startTest();
        insert newaccount;
        // insert newcontact;
        Test.stopTest();
    }

    @isTest
    static void testCreateContactForNewAccount() {
        Test.startTest();
        // Query for the created Contacts
        List<Contact> createdContacts = [
            SELECT Id, FirstName, LastName, AccountId
            FROM Contact 
        ];
 
        // Assert that the correct number of Contacts were created
        System.assertEquals(2, createdContacts.size(), 'Expected 2 Contacts.');

        // Assert that each Contact has the same name as its corresponding Account
        for (Contact contact : createdContacts) {
            Account correspondingAccount = [
                SELECT Name
                FROM Account
                WHERE Id = :contact.AccountId
            ];
            System.assertEquals(correspondingAccount.Name, contact.LastName, 'Contact name should match Account name.');
        }

        Test.stopTest();
    }



    static testMethod void submitForApprovalTest(){

        List<Approval.ProcessSubmitRequest> approvalRequests = new  List<Approval.ProcessSubmitRequest>();
        System.assertEquals(2,approvalRequests.size());


        }

        static testMethod void TestprefixAccountNames(){
            List<Account> insertedAccounts = [SELECT Name FROM Account WHERE Name LIKE 'test account%' LIMIT 2];
            for(Account acc : insertedAccounts ){
                System.assertEquals('Mr.test account0',acc.Name);
            }

        }

         static testmethod void deleteDuplicateAccounts(){

            List<Account> remainingAccounts = [SELECT Name FROM Account WHERE Name = 'Mr.test account0'];
            for(Account acc : remainingAccounts ){
            System.assertEquals(1,remainingAccounts.size());
            }

          }


        @isTest
        static void testShareAccountsTrigger() {
            List<AccountShare> insertedAccountShares = [SELECT AccountId, UserOrGroupId, AccountAccessLevel, OpportunityAccessLevel FROM AccountShare];
            System.assertEquals(2, insertedAccountShares.size());
        }



        static testMethod void testsendemail() {
                Test.startTest();
                List<Account> testAccountsstoupdate = [SELECT Id,Name FROM Account WHERE Name LIKE 'test account%' LIMIT 2];
                for( Account Accs : testAccountsstoupdate ){
                    Accs.name = 'updated';
                }
                update testAccountsstoupdate;
                Test.stopTest();
                for (Account acc : testAccountsstoupdate) {
                    System.assertEquals('updated', acc.Name, 'Account name should be updated to "updated"');
                }       
             }

        // static testMethod void sendEmailAlert(){

        //     Test.startTest();
        //     for( Integer i=0;i<2;i++ ){
        //         newAccount[i].name = 'updated account name '+ i;
        //     }
        //     update newAccount;

        //    List<EmailMessage> sentEmails = [SELECT Id, Subject FROM EmailMessage];
        //     System.assertNotEquals( 2,sentEmails.size());
        //     Test.stopTest();


        // }



}