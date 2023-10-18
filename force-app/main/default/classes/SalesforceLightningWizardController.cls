public class SalesforceLightningWizardController {

    @AuraEnabled
    public static String save(Account accountData, Contact contactData, Event eventData) {    //, String eventSubject,String eventlocation,  DateTime eventStartDateTime,DateTime eventendDateTime
        
        String returnval;
        try {
            System.debug('accountData::::' + accountData);
            System.debug('contactData::::' + contactData);
            System.debug('eventData::::' + eventData);

            // Insert the Account record
            insert accountData;

            // Set the AccountId on the Contact record
            contactData.AccountId = accountData.Id;

            // Insert the Contact record
            insert contactData;

            // eventData.duration = 60;
            // eventData.StartDateTime = System.Now();
            // datetime myDate =System.Now();
            // datetime newDate = mydate.addHours(1);
            // System.debug(mydate);
            // eventData.EndDateTime = mydate;
            eventData.WhoId = contactData.Id;
            String subject = 'Wizard Task';
            eventData.Subject = subject ;
            insert eventData;



        //     Event eventRecord = new Event(
        //     Subject = eventSubject,
        //     WhoId = contactData.Id,
        //     StartDateTime = eventStartDateTime,
        //     EndDateTime = eventendDateTime,
        //     Location = eventlocation
        //     );
        // insert eventRecord;

        returnval = 'Record successfully inserted';

        } catch (Exception ex) {
            System.debug('event not created ' + ex);
            returnval = ex.getLineNumber() + '---'+ ex.getMessage();
            // return String.valueOF(ex);
        }
        return returnval;
    }
}