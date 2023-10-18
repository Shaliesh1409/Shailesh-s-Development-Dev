public with sharing class OpportunityRelatedToAccount {
    public List<Opportunity> records { get; set; }
    public String selectedAccountId { get; set; }
    public Integer pageSize { get; set; }
    public Integer pageNumber { get; set; }
    public Integer totalRecords { get; set; }
    public OpportunityRelatedToAccount(){
        pageSize=3;
        pageNumber=1;
        totalRecords=0;
    }
    public List<SelectOption> getAccountOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('The id Of The Selected Account Will Show Here', '-- Select an Account --'));
        for (Account acc : [SELECT Id, Name FROM Account]) {
            options.add(new SelectOption(acc.Id, acc.Name));
        }
        return options;
    }
    public PageReference showAccountId() {
        return null;
    }
    public void refreshPage(){
        System.debug('done');
    }
    public void GetTheOpportunities(){
        showAccountId();
        List<String> AccId =new List<String>{selectedAccountId};
        records = [SELECT Name FROM Opportunity WHERE AccountId in :AccId LIMIT :pageSize OFFSET :((pageNumber - 1) * pageSize)];
        totalRecords = [SELECT COUNT() FROM Opportunity WHERE AccountId in :AccId];
    }
    public void nextPage() {
        if (pageNumber * pageSize < totalRecords) {
            pageNumber++;
            GetTheOpportunities();
        }
    }
    public void previousPage() {
        if (pageNumber > 1) {
            pageNumber--;
            GetTheOpportunities();
        }
    }
}