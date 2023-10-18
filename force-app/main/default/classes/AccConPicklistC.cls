public class AccConPicklistC {
    
    public String selectedAccId{get;set;}
    public String selectedConId{get;set;}
    public String selectedOppId{get;set;}
    
    public List<SelectOption> getAccountNames() {
        List<SelectOption> accOptions= new List<SelectOption>();
        accOptions.add( new SelectOption('','--Select--'));
        for( Account acc : [select Id,name from Account ] ) {
            accOptions.add( new SelectOption(acc.Id,acc.name));
        }
        return accOptions;
    }
    
    
    public List<SelectOption> getOpportunityNames() {
        List<SelectOption> oppOptions= new List<SelectOption>();
        List<SelectOption> options = new List<SelectOption>();
        if(selectedAccId != null)
        {     
            for( Opportunity opp : [select Id, Name, accountid from Opportunity 
                                    where accountid=:selectedAccId]) {
                oppOptions.add( new SelectOption(opp.Id,opp.name));
            }
            System.debug('oppOptions--> ' + oppOptions);
        }                  
        else
        {
            oppOptions.add( new SelectOption('--None--','--None--'));
        }
        return oppOptions;
    }
}