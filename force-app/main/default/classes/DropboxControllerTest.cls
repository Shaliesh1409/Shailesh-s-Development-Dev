@isTest
private class DropboxControllerTest {
    public static Contact testContact;
    public static ContentVersion testContentVersion;

    @TestSetup
    static void setupTestData() {
         testContact = new Contact(LastName = 'Test Opportunity');
        insert testContact;
        
         testContentVersion = new ContentVersion(
            Title = 'Test File',
            PathOnClient = 'testfile.txt',
            VersionData = Blob.valueOf('Test file content'),
            FirstPublishLocationId = testContact.Id
        );
        insert testContentVersion;
        System.debug(testContact.LastName);
        System.debug(testContentVersion);
    }

    @isTest
    static void testUploadFileByRecord() {
        String mockResponse = '{"path": "/folderforintegration/testfile.txt"}';
        

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new DropboxMockHttpResponseGenerator());

        if (testContact != null && testContentVersion != null) {
            String result = DropboxController.uploadFileByRecord(testContact.Id, new List<Id>{testContentVersion.Id});
            System.assertEquals('/folderforintegration/testfile.txt', result, 'File should be uploaded successfully');
        }
        
        Test.stopTest();

    }

    @isTest
    static void testDeleteFile() {
        String mockResponse = '{"metadata": { "name": "testfile.txt", "path_display": "/folderforintegration/testfile.txt" } }';
        

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new DropboxMockHttpResponseGenerator());
        
        String result = DropboxController.deleteFile('/folderforintegration/testfile.txt');

        Test.stopTest();

        System.assertEquals('File deleted successfully', result, 'File should be deleted successfully');
    }
}


// @isTest

// public class DropboxControllerTest{

//      @isTest static void testCallout() {

//         Test.setMock(HttpCalloutMock.class, new DropboxMockHttpResponseGenerator());

            
//          Contact testcontact = new Contact(LastName = 'Test Contact');
//                 insert testcontact;

//             ContentVersion cv = new ContentVersion(
//             Title = 'TestFile',
//             VersionData = Blob.valueOf('Test file content'),
//             PathOnClient = 'testfile.txt',
//             FirstPublishLocationId = testcontact.Id
//         );
//         insert cv;

//        Test.startTest();

//        String result = DropboxController.uploadFileByRecord(recordId, contentDocumentIds);

//        Test.stopTest();



//         // System.assertEquals(/folderforintegration/Screenshot (47).png, result,Success);
//         System.assertEquals('/folderforintegration/testfile.txt', result);


//     }

// }