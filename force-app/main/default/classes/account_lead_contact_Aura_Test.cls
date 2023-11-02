@IsTest
public class account_lead_contact_Aura_Test {
    @TestSetup
    static void setupTestData() {

        List<Account> acclist = new List<Account>();
            for(Integer i=0;i<10;i++){
                Account testAcount = new Account(
                    Name = 'Account Name'+i);

                    acclist.add(testAcount);
            }
            insert acclist;       

        List<Lead> leadlist = new List<Lead>();
            for(Integer i=0;i<10;i++){
                Lead testLead = new Lead(
                    LastName = 'Lead Name'+i,
                    Status='Open - Not Contacted',
                    Company='MV clouds'
                );
                leadlist.add(testLead);
            }
                insert leadlist ;


        List<Contact> conlist = new List<Contact>();       
                for(Integer i=0;i<10;i++){
                    Contact testcontact = new Contact(
                        LastName = 'Contact Name'+i
                    );
                    conlist.add(testcontact);
                }
                    insert conlist ;
        }

        

    static testMethod void fetchAccountTest() {

        Test.startTest();
         List<Account> result = account_lead_contact.fetchAccount();
           System.assertEquals('Account Name0', result[0].Name, 'Accounts fetched ');
           System.assertEquals(10, result.size(), 'Accounts fetched ');

           Test.stopTest();


    }

    static testMethod void getContactsTest() {

        Test.startTest();
        List<Contact> result =account_lead_contact.getContacts();
          System.assertEquals(10, result.size(), 'contacts fetched ');
          System.assertEquals('Contact Name0',result[0].LastName, 'contacts fetched ');

          Test.stopTest();


   }

   static testMethod void fetchLeadTest() {

    Test.startTest();
    List<Lead> result = account_lead_contact.fetchLead();
      System.assertEquals(10,result.size() , 'Lead fetched ');
      System.assertEquals('Lead Name0',result[0].Name, 'Leads fetched');

      Test.stopTest();


}

static testMethod void SendEmailTest() {
        Test.startTest();
        String toAddress = 'mishrashailesh1409@gmail.com';
        String subject = 'Test Email Subject';
        String body = 'This is a test email body';

        account_lead_contact.sendEmail(toAddress, subject, body);
        Test.stopTest();

        List<EmailMessage> capturedEmails = [SELECT Subject, HtmlBody, ToAddress FROM EmailMessage];
        System.assertEquals(1, capturedEmails.size(), 'One email should have been captured.');
    

}

}