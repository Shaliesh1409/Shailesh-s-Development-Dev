@isTest
private class EmailServiceControllerTest {
    @isTest
    static void testSendEmailWithMock() {
        String toEmail = 'test@example.com';
        String subject = 'Test Subject';
        String body = 'Test Body';
        String attachmentData = 'Test Attachment Data';

        EmailMockHttpResponseGenerator mock = new EmailMockHttpResponseGenerator();

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock);

        String result = EmailServiceController.sendEmail(toEmail, subject, body, attachmentData);
        System.debug(result);
        Test.stopTest();

        System.assert('email sent successfully' == result, 'Email should be sent successfully.');
    }
}
