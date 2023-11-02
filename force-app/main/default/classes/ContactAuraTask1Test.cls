@IsTest
public class ContactAuraTask1Test {

    @IsTest
    static void Contactcreatetest(){
        
        Test.startTest();

        String testname = 'karan patel';

        ContactAura controller = new ContactAura();
        String CreatedContactId = controller.CreateContact(testname);

        Contact CreatedContact = [ SELECT Id,LastName FROM Contact Where Id =: CreatedContactId];
        System.assertEquals(CreatedContact.LastName , testname,'Contact Name is not matching');
        System.assertEquals(CreatedContact.Id,CreatedContactId,'Id not matched');



        Test.stopTest();
        
    } 

}