public class OpportunityTriggerHandler {
    public static void beforeUpdate(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunities) {
        for (Opportunity opp : newOpportunities) {
            // Trigger 1 logic
            opp.StageName = 'Prospecting';
            opp.CloseDate = Date.today().addDays(15);

            // Trigger 3 logic
            opp.Type = 'New Customer';
        }
    }

    public static void afterUpdate(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunities) {
        List<Task> tasksToInsert = new List<Task>();

        for (Opportunity updatedOpportunity : newOpportunities) {
            Opportunity oldOpportunity = oldOpportunities.get(updatedOpportunity.Id);

            if (oldOpportunity.Name != updatedOpportunity.Name) {
                Task newTask = new Task();
                newTask.Subject = 'Opportunity Name Update';
                newTask.Description = 'The name of the Opportunity has been modified.';
                newTask.Status = 'Not Started';
                newTask.Priority = 'Normal';
                newTask.OwnerId = updatedOpportunity.OwnerId;
                newTask.WhatId = updatedOpportunity.Id;

                tasksToInsert.add(newTask);
            }
        }

        if (!tasksToInsert.isEmpty()) {
            insert tasksToInsert;
        }
    }
}