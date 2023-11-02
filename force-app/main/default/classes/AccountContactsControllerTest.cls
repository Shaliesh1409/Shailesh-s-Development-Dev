@IsTest
public  class AccountContactsControllerTest {
    static testmethod void  testGetContactsByAccountName() {


        Account acc = new Account(Name = 'himanshu trivedi');
        insert acc;
        System.debug(acc.Name);


        List<Contact> testContacts = new List<Contact>();
        for(Integer i=0;i<=10;i++)
        {
            Contact con = new Contact(FirstName = 'dubey'+i , LastName = 'dubey'+i , AccountId = acc.Id) ;
            testContacts.add(con);
        }
        insert testContacts;
        System.debug(testContacts.size());
        

        Test.startTest();
        // AccountContactsController handler = new AccountContactsController();
        // handler.getContactsByAccountName('himanshu trivedi',1,5);
        AccountContactsController.ContactWrapper result = AccountContactsController.getContactsByAccountName(
            'himanshu trivedi', 1, 5);


        System.assertEquals(11,result.totalContacts,'SUCCESS');

    }
}