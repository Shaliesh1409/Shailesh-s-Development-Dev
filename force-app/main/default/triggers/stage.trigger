trigger stage on Opportunity (before update) {
    for( Opportunity opp : Trigger.new){
        opp.StageName = 'Prospecting' ;
        opp.CloseDate = Date.Today()+15;
            
        }

    }