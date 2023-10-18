public class account_lead_contact {
    @auraEnabled(cacheable=true)
    public static List<Account> fetchAccount()
    {
        List<Account> accList=[SELECT Id,Name FROM Account LIMIT 10000];
        return accList;
    }
     @auraEnabled
    public static List<Contact> getContacts()
    {
        List<Contact> conList=[SELECT Id,LastName FROM Contact LIMIT 10000];
        return conList;
    }
    @auraEnabled
    public static List<Lead> fetchLead()
    {
        List<Lead> LeadList=[SELECT Id,Name FROM Lead LIMIT 10000];
        return LeadList;
    } 
    @AuraEnabled
    public static void sendEmail(String toAddress, String subject, String body) {
        // Create a new SingleEmailMessage object
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        // Set the recipient's email address
        mail.setToAddresses(new List<String>{ toAddress });

        // Set the email subject
        mail.setSubject(subject);

        // Set the email body (HTML content)
        mail.setHtmlBody(body);

        // Send the email using the Messaging.sendEmail method
        Messaging.sendEmail(new List<Messaging.Email> { mail });
    }

}