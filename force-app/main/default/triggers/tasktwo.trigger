trigger tasktwo on Opportunity (after update) {
    List<Task> tasksToInsert = new List<Task>();

    for (Opportunity updatedOpportunity : Trigger.new) {
        Opportunity oldOpportunity = Trigger.oldMap.get(updatedOpportunity.Id);

        // Check if the Opportunity's name has been modified
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