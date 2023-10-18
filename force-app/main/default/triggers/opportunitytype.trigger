trigger opportunitytype on Opportunity (before insert,before update) {
    for(Opportunity newopp : Trigger.new){
        newopp.Type= 'New Customer'  ;
    }

}