public with sharing class SendEmailToContactController {
    public String emailSubject { get; set; }
    public String emailBody { get; set; }
    public Blob attachment { get; set; }
    public String attachmentName { get; set; }

    private Contact contact;

    public SendEmailToContactController(ApexPages.StandardController controller) {
        this.contact = (Contact)controller.getRecord();
    }

    public PageReference sendEmail() {
        // Logic to send an email with attachments
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { contact.Email });
        email.setSubject(emailSubject);
        email.setPlainTextBody(emailBody);

        if (attachment != null) {
            Messaging.EmailFileAttachment emailAttachment = new Messaging.EmailFileAttachment();
            emailAttachment.setFileName(attachmentName);
            emailAttachment.setBody(attachment);
            email.setFileAttachments(new Messaging.EmailFileAttachment[] { emailAttachment });
        }

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });

        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email sent successfully.'));
        return null;
    }
}
