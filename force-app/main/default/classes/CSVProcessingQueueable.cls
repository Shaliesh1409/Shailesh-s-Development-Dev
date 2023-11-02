public with sharing class CSVProcessingQueueable implements Queueable {
    private List<Contact> recordsToInsert;

    public CSVProcessingQueueable(List<Contact> recordsToInsert) {
        this.recordsToInsert = recordsToInsert;
    }

    public void execute(QueueableContext context) {
        try{
            if (!recordsToInsert.isEmpty()) {
                insert recordsToInsert;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}