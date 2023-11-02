@IsTest
public with sharing class AuraTask3Test {
    static testmethod void getContactsByAccTest() {

        Account acc = new Account (Name = 'viajay maliya');
        insert acc;

        List<Contact> ContactList = new List<Contact>();
        for (Integer i=0;i<10;i++) 
        {
            Contact con = new Contact(  AccountId = acc.Id , LastName = 'Kanha'+i);
            ContactList.add(con);
        } 
        insert ContactList;
        List <Contact> conlist = Task3.getContactsByAcc('viajay maliya');

        System.assertEquals(10,conlist.size(),'Same : Succes');
    }

    static testmethod void getContactcountTest() {

        Account acc = new Account (Name = 'viajay maliya');
        insert acc;

        List<Contact> ContactList = new List<Contact>();
        for (Integer i=0;i<10;i++) 
        {
            Contact con = new Contact(  AccountId = acc.Id , LastName = 'Kanha'+i);
            ContactList.add(con);
        } 
        insert ContactList;
         Integer concount = Task3.getContactcount('viajay maliya');

        System.assertEquals(10,concount,'Same : Succes');

    }


}