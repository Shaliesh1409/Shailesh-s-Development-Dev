// public with sharing class EmailServiceController {
//     @AuraEnabled
//     public static String sendEmail(String toEmail, String subject, String body, String attachmentData) {
//         String sendTo = toEmail;
//         String subjectMail = subject;
//         String bodyGmail = body;
//         String boundary = '__ctrlq_dot_org__';
//         String nl = '\n';
//         String mimeBody = 'MIME-Version: 1.0\n';
//         mimeBody += 'To: ' + sendTo + '\n';
//         mimeBody += 'Subject: ' + subjectMail + '\n';
//         mimeBody += 'Content-Type: multipart/mixed; boundary=' + boundary + '\n\n';

//         mimeBody += '--' + boundary + '\n';
//         mimeBody += 'Content-Type: text/plain; charset=UTF-8\n';
//         mimeBody += 'Content-Transfer-Encoding: base64\n\n';
//         mimeBody += EncodingUtil.base64Encode(Blob.valueOf(bodyGmail)) + '\n\n';

//         mimeBody += '--' + boundary + '\n';
//         mimeBody += 'Content-Type: text/html; charset=UTF-8\n';
//         mimeBody += 'Content-Transfer-Encoding: base64\n\n';
//         mimeBody += EncodingUtil.base64Encode(Blob.valueOf(bodyGmail)) + '\n\n';

//         if (!String.isBlank(attachmentData)) {
//             mimeBody += '--' + boundary + '\n';
//             mimeBody += 'Content-Type: image/png’; name="attachment.pdf"\n';
//             mimeBody += 'Content-Disposition: attachment; filename="attachment.pdf"\n';
//             mimeBody += 'Content-Transfer-Encoding: base64\n\n';
//             mimeBody += attachmentData + '\n\n';
//         }

//         mimeBody += '--' + boundary + '--';

//         Http http = new Http();
//         HttpRequest req = new HttpRequest();

//         req.setEndpoint('callout:gmail_api/gmail/v1/users/me/messages/send');
//         // Replace {userId} with the actual user ID.

//         // req.setHeader('Authorization', 'Bearer YOUR_ACCESS_TOKEN');
//         req.setHeader('Content-Type', 'message/rfc822');
//         req.setBody('{"raw":"' + EncodingUtil.urlEncode(mimeBody, 'UTF-8') + '"}');
//         req.setMethod('POST');
//         req.setTimeout(60 * 1000);

//         HttpResponse response = http.send(req);

//         System.debug('req: ' + req);
//         System.debug('response: ' + response.getBody());

//         if (response.getStatusCode() != 200) {
//             System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
//             return 'Email sending failed';
//         } else {
//             System.debug('Email sent successfully: ' + response.getBody());
//             return 'Email sent successfully';
//         }
//     }
// }






public with sharing class EmailServiceController {
    @AuraEnabled
    public static void sendEmail(String toEmail, String subject, String body, String attachmentData) {
        String sendTo = toEmail;
        String subjectMail = subject;
        String bodyGmail = body;

        // Construct the email message
        String emailMessage = 'From: Your Name <your.email@gmail.com>\n' +
            'To: ' + sendTo + '\n' +
            'Subject: ' + subjectMail + '\n' +
            'MIME-Version: 1.0\n' +  // Add MIME version
            'Content-Type: multipart/mixed; boundary=boundary_1\n\n' +
            'This is a multi-part message in MIME format.\n' +
            '--boundary_1\n' +
            'Content-Type: text/html; charset="UTF-8"\n\n' + bodyGmail;

        // If there's an attachment, include it
        if (!String.isBlank(attachmentData)) {
            emailMessage += '\n\n--boundary_1\n';
            emailMessage += 'Content-Type: image/jpeg; name="attachment.jpeg"\n';
            emailMessage += 'Content-Disposition: attachment; filename="attachment.jpeg"\n\n';
            emailMessage += EncodingUtil.base64Encode(Blob.valueOf(attachmentData)); // Encode attachment data as base64
        }

        emailMessage += '\n--boundary_1--'; // End the MIME boundary

        Blob emailBlob = Blob.valueOf(emailMessage);

        // Create a JSON payload for Gmail API
        String emailBody = EncodingUtil.base64Encode(emailBlob); // Encode the entire email message
        // String payload = '{"raw":"' + EncodingUtil.urlEncode(emailBody, 'UTF-8') + '"}';
        String payload = '{"raw":"' + emailBody + '"}';

        Http httpMail = new Http();
        HttpRequest httpReqMail = new HttpRequest();
        HttpResponse httpResMail = new HttpResponse();
        httpReqMail.setEndpoint('callout:gmail_api/gmail/v1/users/me/messages/send');
        httpReqMail.setMethod('POST');
        httpReqMail.setHeader('Content-Type', 'application/json');
        httpReqMail.setBody(payload);

        httpResMail = httpMail.send(httpReqMail);
        System.debug(httpResMail);
        System.debug(httpResMail.getBody());
    }
}
