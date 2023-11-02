@RestResource(urlMapping='/myRestService/*')
global with sharing class webservices {
    
    @HttpGet
    global static List<Account> doGet() {
        List<Account> records = [SELECT Id, Name FROM Account];
        return records;
    }



    @HttpPOST
    global static String doPost(String name, String description) {
        try {
            // Create a new Account
            Account newAccount = new Account();
            newAccount.Name = 'name';
            newAccount.Description = 'description';

            // Insert the Account into the database
            insert newAccount;

            return 'Account with ID ' + newAccount.Id + ' created successfully.';
        } catch (Exception e) {
            RestResponse res = RestContext.response;
            res.statusCode = 500; // Internal Server Error
            return 'Error creating the Account: ' + e.getMessage();
        }
    }
    

    
    @HttpDelete
    global static String doDelete() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String recordId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
    
        try {
            List<Account> recordsToDelete = [SELECT Id FROM Account WHERE Id = :recordId];
    
            if (!recordsToDelete.isEmpty()) {
                Account recordToDelete = recordsToDelete[0];
                delete recordToDelete;
                return 'Account with ID ' + recordId + ' deleted successfully.';
            } else {
                res.statusCode = 404;
                return 'Record with ID ' + recordId + ' not found or cannot be deleted.';
            }
        } catch (DmlException e) {
            res.statusCode = 500;
            return 'Error deleting the record: ' + e.getMessage();
        }
    }
    
    
    


        @HttpPut
        global static String doPut(String Id, String Name) {
            Account existingRecord = [SELECT Id, Name FROM Account WHERE Id = :Id LIMIT 1];
        
            if (existingRecord != null) {
                existingRecord.Name = Name;
        
                try {
                    upsert existingRecord;
                    return 'Record with ID ' + existingRecord.Id + ' upserted successfully.';
                } catch (DmlException e) {
                    return 'Error upserting the record: ' + e.getMessage();
                }
            } else {
                return 'Record with ID ' + Id + ' not found for upsert.';
            }
        }
        
        @HttpPatch
        global static String doPatch(String Id, String Name) {
            Account existingRecord = [SELECT Id, Name FROM Account WHERE Id = :Id LIMIT 1];
        
            if (existingRecord != null) {
                existingRecord.Name = Name;
        
                try {
                    update existingRecord;
                    return 'Record with ID ' + existingRecord.Id + ' updated successfully.';
                } catch (DmlException e) {
                    return 'Error updating the record: ' + e.getMessage();
                }
            } else {
                return 'Record with ID ' + Id + ' not found for update.';
            }
        }
        
}

// https://mvclouds-9f-dev-ed.develop.my.salesforce.com/services/apexrest/myRestService/
// https://mvclouds-9f-dev-ed.develop.my.salesforce.com/services/data/v55.0/query?q=SELECT+Id+FROM+Account+limit+5

// {
//     "name": "New Account Name",
//     "description": "A description for the new account"
// }  post method


// /services/data/v58.0
