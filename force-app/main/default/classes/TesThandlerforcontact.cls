@isTest
public class TesThandlerforcontact {
    @TestSetup
    static void setupdata(){
    
        Account acc = new Account(Name='mahira',Max_Amount__c=1000);
        insert acc;
        Account acc2 =  new Account(Name='sahira');
        insert acc2;

        // List<Contact> testcontacts = new List<Contact>();
        Contact con = new Contact();
        con.LastName = 'Test';
        con.Amount__c = 1000;
        con.AccountId = acc.Id;
        // for(Integer i=0; i<2; i++){
        //      Contact con = new Contact(LastName='mishra ' +i,Amount__c = 100.0, AccountId = acc.Id);
        //     testcontacts.add(con);
        // }
        insert  con;
        Contact con2 = new Contact();
        con2.LastName = 'Test2';
        con2.Amount__c = 1000;
        con2.AccountId = acc.Id;
        insert con2;

        Contact con3 = new Contact();
        con3.LastName = 'Test3';
        con3.Amount__c = 1900;
        con3.AccountId = acc.Id;
        insert con3;

        // delete con;
    }

    static testMethod void TestDeleteAccounts(){
        Contact deleteContacts = [SELECT Id,LastName,AccountId FROM Contact WHERE LastName = 'Test2'];
        Test.startTest();
        delete deleteContacts;
        Test.stopTest();

        List<Account> remainingAccounts = [SELECT Id,Name FROM Account];
        System.assertEquals(1,remainingAccounts.size());

        // Contact con = new Contact();
        // con.LastName = 'Test';
        // con.Amount__c = 1000;
        // con.AccountId = acc.Id;
        // // for(Integer i=0; i<2; i++){
        // //      Contact con = new Contact(LastName='mishra ' +i,Amount__c = 100.0, AccountId = acc.Id);
        // //     testcontacts.add(con);
        // // }
        // insert  con;

        // delete con;
        // // List<Contact> InsertedContacts = [SELECT Id FROM Contact];
        // // Test.startTest();
        // // delete InsertedContacts;
        // // Test.stopTest();

        // // List<Account> deleteaccounts = [SELECT Id from Account];
        // // System.assertEquals(0,deleteaccounts.size());

    }

        static testMethod void TestEvent(){

            List<Event> createdEvents = [SELECT Subject, StartDateTime, EndDateTime, WhoId FROM Event];

            System.assertEquals(4, createdEvents.size());

        }


        @isTest
        static void testUpdateTotalAmountOnContactBulk() {

        Account testAccounts = [SELECT Id,Name,Total_Amount__c FROM Account WHERE Name= 'mahira' LIMIT 1];
            System.assertEquals(3900,testAccounts.Total_Amount__c);  
            
            List<Contact> Contactstoupdate = [SELECT Id,Name FROM Contact WHERE LastName = 'Test' LIMIT 1];
                for( Contact cons : Contactstoupdate  ){
                    cons.Amount__c=600;
                }
                update Contactstoupdate ;

            testAccounts = [SELECT Id,Name,Total_Amount__c FROM Account WHERE Name= 'mahira' LIMIT 1];
            System.assertEquals(3500,testAccounts.Total_Amount__c);  
                
            // List<Contact> Contactstodelete = [SELECT Id,Name FROM Contact WHERE LastName = 'Test' LIMIT 1];
            // delete Contactstodelete ;

            // testAccounts = [SELECT Id,Name,Total_Amount__c FROM Account WHERE Name= 'mahira' LIMIT 1];
            // System.assertEquals(0,testAccounts.Total_Amount__c);  
    }


    static testMethod void testUpdateContactAccounts(){

        List<Contact> Contactstoupdate = [SELECT Id,AccountId FROM Contact WHERE LastName = 'Test' LIMIT 1];
        Account newAccount = new Account(Name = 'New Account');
        insert newAccount;
        for( Contact cons : Contactstoupdate  ){
            cons.AccountId=newAccount.Id;
        }
        update Contactstoupdate ;
        List<Contact> contactsconnected = [SELECT Id,AccountId FROM Contact WHERE LastName = 'Test2' LIMIT 1];
        System.Assert(Contactstoupdate[0].AccountId==contactsconnected[0].AccountId,'both have same Id');

    }



    static testmethod void testGreatProblem2Logic(){
        List<Contact> multipleContacts = [SELECT Id,AccountId,Amount__c FROM Contact WHERE LastName LIKE 'Test%'];
        System.assertEquals(4,multipleContacts.size());
        for(Contact contacts : multipleContacts){
            System.assertEquals(900,multipleContacts[2].Amount__c);
        }
         
    }
    }