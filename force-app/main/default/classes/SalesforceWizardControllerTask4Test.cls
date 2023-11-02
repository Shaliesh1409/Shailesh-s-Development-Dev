@IsTest
public with sharing class SalesforceWizardControllerTask4Test {
    static testmethod void  saveTest() {


        Account acc = new Account(Name = 'Harish',AccountNumber='123456' ,Description='honest');
        Contact con = new Contact(FirstName= 'Satyavdi ', LastName = 'HarishContact', Phone='63354520482');

        Datetime startDateTime = Datetime.newInstanceGmt(2023, 10, 19, 9, 0, 0);
        Datetime endDateTime = Datetime.newInstanceGmt(2023, 10, 19, 10, 0, 0);

        Event evt = new Event(Subject = 'Wizard Task',	Location='contact',StartDateTime=startDateTime ,EndDateTime=endDateTime);

        String result = SalesforceLightningWizardController.save(acc,con,evt);

        System.assertEquals('Record successfully inserted',result,'Success');


        Account InsertedAccount =[SELECT Id,Name FROM Account WHERE Id =:acc.Id];
        Contact InsertedContact =[SELECT Id,Name,AccountId FROM Contact WHERE Id =:con.Id];
        Event InsertedEVENT =[SELECT Subject,WhoId,Id FROM Event WHERE Id=:evt.Id];

        System.assertEquals(InsertedAccount.Id,InsertedContact.AccountId);
        System.assertEquals(InsertedContact.Id,InsertedEVENT.WhoId);
    }
}