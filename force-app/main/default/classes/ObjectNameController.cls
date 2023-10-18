public with sharing class ObjectNameController {
    @AuraEnabled(cacheable=true)
    public static List<String> getObjectList() {
        List<String> objectNames = new List<String>();
        for (Schema.SObjectType objType : Schema.getGlobalDescribe().values()) {
            objectNames.add(objType.getDescribe().getName());
        }
        objectNames.sort();
        return objectNames;
    }
    @AuraEnabled(cacheable=true)
    public static List<SObject> getObjectRecords(List<String> objectNames) {
        List<SObject> relatedRecords = new List<SObject>();
        
        // Query related records based on the selected object names
        for (String objectName : objectNames) {
            // Customize the query as needed
            String query = 'SELECT Id, Name FROM ' + objectName + ' LIMIT 10';
            
            List<SObject> records = Database.query(query);
            relatedRecords.addAll(records);
        }
        
        return relatedRecords;
    }
        @AuraEnabled(cacheable=true)
    public static List<SObject> searchRecords(List<String> objectNames, String searchKeyword) {

        System.debug('objectNames-->'+objectNames);
        List<SObject> searchResults = new List<SObject>();

        String soslQuery = 'FIND \'' + searchKeyword + '\' IN ALL FIELDS RETURNING ';
        for (String objectName : objectNames) {
            soslQuery += objectName + '(' + String.join(new List<String>{'Name'}, ',') + ')';
            if (objectName != objectNames[objectNames.size() - 1]) {
                soslQuery += ', ';
            }
        }

        List<List<SObject>> searchList = search.query(soslQuery);

        for (List<SObject> results : searchList) {
            searchResults.addAll(results);
        }

        return searchResults;
    }
}