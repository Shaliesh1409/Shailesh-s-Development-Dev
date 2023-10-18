public with sharing class DropboxController {

    @AuraEnabled
    public static String uploadFileByRecord(String recordId, List<Id> fileIds) {
        
        String fileUrl = '';

        for (Id fileId : fileIds) {
            ContentVersion content;
            try {
                content = [SELECT VersionData, Title,FileExtension FROM ContentVersion WHERE ContentDocumentId = :fileId LIMIT 1];
            } catch (QueryException e) {
                System.debug('ContentVersion record not found for Id: ' + fileId);
                continue; 
            }
            fileUrl = DropboxService.Upload(content);
            System.debug('fileUrl-->'+fileUrl);
      
        }

        return fileUrl;
    }

    @AuraEnabled
    public static String deleteFile(string filepath ) {
        
              System.debug(filepath);  
              HttpRequest request = new HttpRequest();
              request.setEndpoint('https://api.dropboxapi.com/2/files/delete_v2');
              request.setMethod('POST');
              request.setHeader('Authorization', 'Bearer ' + Label.DropBoxKey);
              request.setHeader('Content-Type', 'application/json');
              request.setBody('{"path": "' + filepath + '"}');
              System.debug(request);
              System.debug(request.getBody());
            
            Http http = new Http();
            HttpResponse response = http.send(request);
            System.debug('HTTP Response Status Code: ' + response.getStatusCode());
            System.debug('HTTP Response Body: ' + response.getBody());

            if (response.getStatusCode() == 200) {
        // File was successfully deleted
            return 'File deleted successfully';
            } else {
             // Handle delete failure
            System.debug('Dropbox API Error: ' + response.getStatus() + ' - ' + response.getBody());
            return 'Error deleting file';
                }
                  
        
    }
}



// public with sharing class DropboxController {

//     @AuraEnabled
//     public static String uploadFileByRecord(String recordId, List<Id> fileIds) {
//         List<FileStore__c> fileStores = new List<FileStore__c>();
        
//         for (Id fileId : fileIds) {
//             ContentVersion content;
//             try {
//                 content = [SELECT VersionData, Title, FileExtension FROM ContentVersion WHERE Id = :fileId LIMIT 1];
//             } catch (QueryException e) {
//                 System.debug('ContentVersion record not found for Id: ' + fileId);
//                 continue; 
//             }
//             String fileUrl = DropboxService.Upload(content);

//             if (String.isNotBlank(fileUrl)) {
//                 FileStore__c fileStore = new FileStore__c();
//                 fileStore.ServerUrl__c = fileUrl;
//                 fileStore.Name = content.Title + '.' + content.FileExtension.toLowerCase();
//                 fileStore.RecordId__c = recordId;
//                 fileStore.FileExtension__c = content.FileExtension.toLowerCase();
//                 fileStores.add(fileStore);
//             }
//         }

//         try {
//             insert fileStores;
//             System.debug('File records inserted successfully');
//         } catch (DMLException ex) {
//             System.debug('Error inserting file records: ' + ex.getMessage());
//             return 'Error uploading files: ' + ex.getMessage();
//         }
        
//         return 'Files uploaded successfully';
//     }

//     @AuraEnabled
//     public static String deleteFile(String fileId) {
//         try {
//             // Implement your file deletion logic here.
//             // You will need to call the Dropbox API to delete the file from Dropbox.
//             // Make sure to handle errors and return appropriate messages.

//             System.debug('File deleted successfully');
//             return 'File deleted successfully';
//         } catch (Exception ex) {
//             System.debug('Error deleting file: ' + ex.getMessage());
//             return 'Error deleting file: ' + ex.getMessage();
//         }
//     }
// }


// public class DropboxController 
// {
//      @AuraEnabled(cacheable=false)
// 	public static void uploadFileByRecord(string recordId)
//     {
//         List<ContentDocumentLink> links=[SELECT ContentDocumentId,LinkedEntityId FROM ContentDocumentLink where LinkedEntityId=:recordId];
//         Set<Id> ids=new Set<Id>();
//         for(ContentDocumentLink link:links)
//         {
//             ids.add(link.ContentDocumentId);
//         }
//         List<ContentVersion> versions=[SELECT VersionData,Title,ContentDocumentId,FileExtension FROM ContentVersion WHERE ContentDocumentId = :ids AND IsLatest = true];
        
//         for(ContentVersion attach:versions)
//         {
//             try
//             {
//                 string fileUrl=DropboxService.upload(attach);
//                	if (string.isNotBlank(fileUrl)) 
//                 {
//                     //Store Information in Object
//                     //Will be used for retrieving files
//                     FileStore__c fileStore=new FileStore__c();
//                     fileStore.ServerUrl__c=fileUrl;
//                     fileStore.Name=attach.Title+'.'+  attach.FileExtension.toLowerCase();
//                     fileStore.RecordId__c=recordId;
//                     fileStore.FileExtension__c=attach.FileExtension.toLowerCase();
//                     insert fileStore;
//                 }
//             }
//             catch(Exception ex)
//             {
//                throw (ex);
//             }
//         }
//     }
// }