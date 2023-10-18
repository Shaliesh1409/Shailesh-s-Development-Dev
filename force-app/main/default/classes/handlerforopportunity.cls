public class handlerforopportunity { 
    List<Opportunity> recordNewList = new List<Opportunity>();
    List<Opportunity> recordOldList = new List<Opportunity>();
    Map<Id, Opportunity  > recordNewMap = new Map<Id, Opportunity>();
    Map<Id, Opportunity> recordOldMap = new Map<Id, Opportunity>();
    Boolean isInsert, isUpdate, isDelete, isUndelete = false;
    public static boolean recursionController = true;
    public static boolean flag = true;
    
    public handlerforopportunity(List<Opportunity> newList, List<Opportunity> oldList, Map<Id, Opportunity> newMap, Map<Id, Opportunity> oldMap, boolean isInsert, boolean isUpdate, Boolean isDelete, Boolean isUndelete) {
        this.recordNewList = newList;
        this.recordOldList = oldList;
        this.recordNewMap = newMap;
        this.recordOldMap = oldMap;
        this.isInsert = isInsert;
        this.isUpdate = isUpdate;
        this.isDelete = isDelete;
        this.isUndelete = isUndelete;
    }
    
    public void BeforeInsertEvent(){
        type();
    }
    
    public void BeforeUpdateEvent(){
        stage();

    }
    
    public void BeforeDeleteEvent(){}
    
    public void AfterInsertEvent(){}
    
    public void AfterUpdateEvent(){
        Task();
    }
    
    public void AfterDeleteEvent(){}
    
    public void AfterUndeleteEvent(){}

    public  void stage() {
        for (Opportunity opp : recordNewList) {
            // Trigger 1 logic
            opp.StageName = 'Prospecting';
            opp.CloseDate = Date.today().addDays(15);
            opp.Type = 'New Customer';
             
        }
    }

    public void type() {
        for (Opportunity opp : recordNewList) {
            opp.Type = 'New Customer';
        }       
    }

    public void Task() {
        List<Task> tasksToInsert = new List<Task>();

        for (Opportunity updatedOpportunity : recordNewList) {
            Opportunity oldOpportunity =  recordOldMap.get(updatedOpportunity.Id);

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