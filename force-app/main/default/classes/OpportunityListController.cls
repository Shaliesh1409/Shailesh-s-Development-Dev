public with sharing class OpportunityListController {
    public String selectedAccountId { get; set; }
    public List<SelectOption> accountOptions { get; set; }
    public List<Opportunity> opportunities { get; set; }
    public List<Opportunity> displayedOpportunities { get; set; }
    public Integer pageNumber { get; set; }
    public Integer pageSize { get; set; }
    public Integer totalRecords { get; set; }
    public Integer totalPages {
        get {
            return (totalRecords + pageSize - 1) / pageSize;
        }
    }

    public OpportunityListController() {
        loadAccountOptions();
        pageNumber = 1;
        pageSize = 5;
        loadOpportunities();
    }

    public void loadAccountOptions() {
        accountOptions = new List<SelectOption>();
        for (Account acc : [SELECT Id, Name FROM Account]) {
            accountOptions.add(new SelectOption(acc.Id, acc.Name));
        }
    }

    public void loadOpportunities() {
        opportunities = [SELECT Name, StageName, CloseDate FROM Opportunity WHERE AccountId = :selectedAccountId ];
        totalRecords = opportunities.size();
        updateDisplayedOpportunities();
    }

    private void updateDisplayedOpportunities() {
        Integer startIndex = (pageNumber - 1) * pageSize;
        Integer endIndex = startIndex + pageSize - 1;
        displayedOpportunities = new List<Opportunity>();
        
        for (Integer i = startIndex; i <= endIndex && i < opportunities.size(); i++) {
            displayedOpportunities.add(opportunities[i]);
        }
    }

    public Boolean getHasPrevious() {
        return pageNumber > 1;
    }

    public Boolean getHasNext() {
        return pageNumber < totalPages;
    }

    public void Previous() {
        if (pageNumber > 1) {
            pageNumber--;
            updateDisplayedOpportunities();
        }
    }

    public void Next() {
        if (pageNumber < totalPages) {
            pageNumber++;
            updateDisplayedOpportunities();
        }
    }
}