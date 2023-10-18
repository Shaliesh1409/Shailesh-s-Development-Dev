public class Insertrecords implements Schedulable{
    public void execute(SchedulableContext sc) {
        List<Opportunity> opportunitiestoInsert = new List<Opportunity>();
        for (Integer i=0;i<=10;i++) {
            Opportunity opp = new Opportunity(Name = 'SHAILESH mishra '+ i, StageName = 'Prospecting', 	CloseDate =Date.today()+5 );
            opportunitiestoInsert.add(opp);

        }
        insert opportunitiestoInsert;
    }
}