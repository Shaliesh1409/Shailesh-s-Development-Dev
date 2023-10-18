public class ScheduleUpdateAccountDescription implements Schedulable {
    public void execute(SchedulableContext ctx) {
        UpdateAccountDescriptionBatch batchJob = new UpdateAccountDescriptionBatch();
        Database.executeBatch(batchJob);
    }
}