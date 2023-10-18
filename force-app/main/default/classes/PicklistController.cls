public with sharing class PicklistController {
    @AuraEnabled(cacheable=true)
    public static List<String> getAllObjectNames() {
        List<String> objectNames = new List<String>();
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        
        for (String sObjectName : gd.keySet()) {
            objectNames.add(sObjectName);
        }
        
        return objectNames;
    }

    @AuraEnabled(cacheable=true)
    public static List<SObject> getObjectRecords(String objectApiName) {
        String query = 'SELECT Id, Name FROM ' + objectApiName;
        
        try {
            return Database.query(query);
        } catch (QueryException e) {
            // Handle any exceptions or errors here
            System.debug('Error executing query: ' + e);
            return new List<SObject>(); // Return an empty list in case of an error
        }
    }
    // @AuraEnabled(cacheable=true)
    // public static List<SObject> displayobjectRecords(String searchKey)
    // {
    //     System.debug('searchKey'+searchKey);
    //     List<SObject> returnlist=new List<SObject>();
    //     for(SObject acc:[select Name,Id from SObject])
    //     {
    //         returnlist.add(acc);
    //     }
    //     return returnlist;
    // }
}