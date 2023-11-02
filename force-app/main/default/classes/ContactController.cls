// public with sharing class ContactController {
//     @AuraEnabled
//     public static void createRecordsFromCSV(String recordId,Id fileId ) {
//       try {
//         Integer recordsCreated = 0;
//         List <Contact> RecordToInsert = new List <Contact> ();
//         ContentVersion csvFile = [SELECT VersionData FROM ContentVersion WHERE ContentDocumentId = :fileId LIMIT 1];
  
//         if (csvFile  != null) {
//           String csvData = csvFile.VersionData.toString();
  
//           List<String> rows = csvData.split('\n');
  
//               for (String row : rows) {
//                   List<String> tokens = row.split(',');
  
//                   if (tokens.size() >= 1) {
//                     Contact record = new Contact();
//                     record.FirstName = tokens[0];
//                     record.LastName = tokens[1];
//                     record.AccountId = recordId;
//                     RecordToInsert.add(record);
//                   } else {
//                       // Handle invalid CSV lines or log an error
//                   }
//               }
//         }
//           recordsCreated = RecordToInsert.size();
//           system.debug('recordsCreated ->' + recordsCreated);

//           if (!RecordToInsert.isEmpty()) {
//             insert RecordToInsert;
//         }
  
//       } catch (Exception e) {
//           System.debug(e.getMessage());
//           throw new AuraHandledException(e.getMessage()+e.getStackTraceString()+e.getLineNumber());
//       }
//     }
  
//   }

public with sharing class ContactController {
  @AuraEnabled
  public static Map<String, Object> createRecordsFromCSV(String recordId, Id fileId) {
      Map<String, Object> result = new Map<String, Object>();
      try {
          List<Contact> RecordToInsert = new List<Contact>();
          ContentVersion csvFile = [SELECT VersionData FROM ContentVersion WHERE ContentDocumentId = :fileId LIMIT 1];

          if (csvFile != null) {
              String csvData = csvFile.VersionData.toString();
              List<String> rows = csvData.split('\n');

              for (String row : rows) {
                  List<String> tokens = row.split(',');

                  if (tokens.size() >= 2) {
                      Contact record = new Contact();
                      record.FirstName = tokens[0];
                      record.LastName = tokens[1];
                      record.AccountId = recordId;
                      RecordToInsert.add(record);
                  } else {
            
                  }
              }
          }

          if (!RecordToInsert.isEmpty()) {
              try {
                  insert RecordToInsert;
                  result.put('successMessage', 'Records created successfully.');
              } catch (DMLException e) {
             
                  result.put('errorMessage', 'Error creating records: ' + e.getMessage());
              }
          } else {
             
              result.put('errorMessage', 'No valid records found in the CSV.');
          }
      } catch (Exception e) {
          System.debug(e.getMessage());
          throw new AuraHandledException(e.getMessage() + e.getStackTraceString() + e.getLineNumber());
      }
      return result;
  }
}
