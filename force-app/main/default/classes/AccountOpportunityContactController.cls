public class AccountOpportunityContactController {
    @AuraEnabled
    public static List<AccountOpportunityContactWrapper> getAccountsWithOpportunitiesAndContacts() {
        List<AccountOpportunityContactWrapper> result = new List<AccountOpportunityContactWrapper>();

        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities), (SELECT Id, LastName FROM Contacts) FROM Account];

        for (Account acc : accounts) {
            result.add(new AccountOpportunityContactWrapper(acc, acc.Opportunities, acc.Contacts));
        }

        return result;
    }

    public class AccountOpportunityContactWrapper {
        @AuraEnabled
        public Account account { get; set; }
        @AuraEnabled
        public List<Opportunity> opportunities { get; set; }
        @AuraEnabled
        public List<Contact> contacts { get; set; }
    
        public AccountOpportunityContactWrapper(Account acc, List<Opportunity> opps, List<Contact> conts) {
            account = acc;
            opportunities = opps;
            contacts = conts;
        }
    }
    
}