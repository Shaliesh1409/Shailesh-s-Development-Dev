@isTest
public class LeadHandlerTest {

    @testSetup static void setup() {

        List<Lead> led = new List<Lead>();
        for(Integer i=0; i<=2 ; i++){
        String lastname = 'Test Lead'+i;
        String company = 'tcs';
        String stt ='Working - Contacted';
        Lead a = new Lead(LastName=lastname,Company=company,Status=stt);
        led.add(a);
        }

        Test.startTest();
        insert led;
        Test.stopTest();
    }   


    static testMethod void LeadHandlerRatingTest() {
        Test.startTest();
        List<Lead> updatedLeads = [SELECT Id, Rating FROM Lead LIMIT 2];
        LeadHandler.setDefaultRating(updatedLeads);
        for(Lead leadcase : updatedLeads){
            System.assertEquals('Hot',leadcase.Rating,'rating sahould be hot');
        }
        Test.stopTest();
}
}