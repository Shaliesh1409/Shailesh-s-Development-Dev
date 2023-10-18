public class GmailApiNamedCredential {

    public PageReference sendEmail() {
        List<ContentVersion> conVer = [SELECT Id, PathOnClient, FileType, Title, VersionData FROM ContentVersion WHERE FileType = 'PNG'];

        String boundary =  '__ctrlq_dot_org__';   // Replace with your desired boundary

        String mimeBody = 'MIME-Version: 1.0\r\n';
        mimeBody += 'To: recipient@example.com\r\n';
        mimeBody += 'Cc: cc@example.com\r\n';
        mimeBody += 'Bcc: bcc@example.com\r\n';
        mimeBody += 'Subject: Email_Testing\r\n';
        mimeBody += 'Content-Type: multipart/mixed; boundary=' + boundary + '\r\n';
        mimeBody += '\r\n';

        for (ContentVersion cv : conVer) {
            mimeBody += '--' + boundary + '\r\n';
            mimeBody += 'Content-Type: application/octet-stream; name=' + cv.Title + '\r\n';
            mimeBody += 'Content-Disposition: attachment; filename="' + cv.Title + '"\r\n';
            mimeBody += 'Content-Transfer-Encoding: base64\r\n';
            mimeBody += '\r\n';
            mimeBody += EncodingUtil.base64Encode(cv.VersionData) + '\r\n';
        }

        mimeBody += '--' + boundary + '\r\n';
        mimeBody += 'Content-Type: text/plain; charset=UTF-8\r\n';
        mimeBody += 'Content-Transfer-Encoding: base64\r\n';
        mimeBody += '\r\n';
        mimeBody += EncodingUtil.base64Encode(Blob.valueOf('Hello Testing')) + '\r\n';
        mimeBody += '--' + boundary + '--';

        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:gmail_api/v1/users/shailesh@developer.com/messages/send'); // Replace {userId} with the actual user ID
        req.setHeader('Content-Type', 'message/rfc822');
        req.setBody('{"raw":"' + EncodingUtil.base64Encode(Blob.valueOf(mimeBody)) + '"');
        req.setMethod('POST');
        req.setTimeout(60 * 1000);
        System.debug('req---->>' + req);
        
        HttpResponse response = http.send(req);
        System.debug('response---->>' + response.getBody());
        System.debug(response);

        if (response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                         response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        
        return null;
    }
}



// public class GmailApiNamedCredential {

//     public pagereference sendEmail(){
    
//             list conVer=[Select id,PathOnClient,FileType,Title,ContentSize,VersionData FROM ContentVersion where FileType=’PNG’];
    
//          String mimeBody = ”;
    
//          String nl = ‘\n’;
    
//          String boundary = ‘__ctrlq_dot_org__’;   
    
//          mimeBody += ‘MIME-Version: 1.0\n’;
    
//          mimeBody += ‘To: example@gmail.com\n’;
    
//          mimeBody += ‘cc: example1@gmail.com\n’;
    
//          mimeBody += ‘bcc: example2@gmail.com\n’;
    
//          mimeBody += ‘Subject: Email_Testing \n’;
    
//          mimeBody += ‘Hello Testing\n’;
    
//          mimeBody += ‘Content-Type: multipart/mixed; boundary=’+boundary+’\n’;
    
//          mimeBody += ‘–‘+boundary+’\n’;
    
//          mimeBody += ‘Content-Type: text/plain; charset=UTF-8\n’;
    
//          mimeBody += ‘Content-Transfer-Encoding: base64\n’;
    
//          mimeBody += EncodingUtil.base64Encode(blob.valueOf(‘Testinggg’))+’\n\n’;
    
//          mimeBody += ‘–‘+boundary+’\n’;
    
//          mimeBody += ‘Content-Type: text/html; charset=UTF-8\n’;
    
//          mimeBody += ‘Content-Transfer-Encoding: base64\n\n’;
    
//          mimeBody += EncodingUtil.base64Encode(blob.valueOf(‘Testinggg’))+’\n\n’;
    
//          mimeBody += ‘–‘+boundary+’\n’;
    
//             for(ContentVersion cv:conVer){
    
//          mimeBody += ‘Content-Type:image/png’+’;name=’+cv.Title+’\n’;
    
//          mimeBody += ‘Content-Disposition: attachment; filename=”‘+cv.PathOnClient+'”\n’;
    
//          mimeBody += ‘Content-Transfer-Encoding: base64\n\n’;
    
//          mimeBody += Encodingutil.base64Encode(cv.VersionData)+’\n\n’;
    
//          }
    
//          mimeBody += ‘–‘+boundary+’–‘;
    
//          Http http = new Http();
    
//          HttpRequest req = new HttpRequest();  
    
//         req.setEndpoint(‘callout:gmail_api/upload/gmail/v1/users/{userId}/messages/send?uploadType=media’);
    
//     //(Gmail_API)API Name of Name credential
    
//             req.setHeader(‘Authorization’, ‘Bearer ‘);
    
//         req.setHeader(‘Content-Type’, ‘message/rfc822’);
    
//             req.setBody(‘{“raw”:”‘+ mimeBody +'”}’);
    
//             req.setMethod(‘POST’);
    
//             req.setTimeout(60 * 1000);
    
//             system.debug(‘req——>>’+req);
    
//          HttpResponse response = http.send(req);
    
//             system.debug(‘response——>>’+response.getBody());
    
//             System.debug(response);
    
//          if (response.getStatusCode() != 201) {
    
//                 System.debug(‘The status code returned was not expected: ‘ +
    
//                              response.getStatusCode() + ‘ ‘ + response.getStatus());  
    
//          } else {
    
//                 System.debug(response.getBody());
    
//          }  
    
//          return null;
    
//     }
    
//     }
// }