global with sharing class accountservice {

    webservice static String getContactsAndOpportunities(String accountId) {
        List<Contact> contacts = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE AccountId = :accountId];
        List<Opportunity> opportunities = [SELECT Id, Name, CloseDate, StageName FROM Opportunity WHERE AccountId = :accountId];

        String result = '';

        for (Contact contact : contacts) {
            result += 'Contact ID: ' + contact.Id + ', First Name: ' + contact.FirstName + ', Last Name: ' + contact.LastName + ', Email: ' + contact.Email + ', Phone: ' + contact.Phone + '\n';
        }

        for (Opportunity opportunity : opportunities) {
            result += 'Opportunity ID: ' + opportunity.Id + ', Name: ' + opportunity.Name + ', Close Date: ' + opportunity.CloseDate + ', Stage Name: ' + opportunity.StageName + '\n';
        }

        return result;
    }
}

