import { LightningElement, wire, api } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import sendEmail from '@salesforce/apex/EmailServiceController.sendEmail';

const CONTACT_FIELDS = ['Contact.Email']; // Define the fields to retrieve from the Contact record

export default class EmailIntegrator extends LightningElement {
    @api recordId; // The Id of the current Contact record
    recipient = '';
    subject = '';
    body = '';
    attachment = null;
    isPopupOpen = false;

    @wire(getRecord, { recordId: '$recordId', fields: CONTACT_FIELDS })
    contact;

    // Wire method to retrieve the Contact's email address
    get contactEmail() {
        return getFieldValue(this.contact.data, CONTACT_FIELDS[0]);
    }

    openPopup() {
        this.isPopupOpen = true;
        this.recipient = this.contactEmail; // Automatically set recipient to Contact's email
    }

    closePopup() {
        this.isPopupOpen = false;
    }

    handleRecipientChange(event) {
        this.recipient = event.target.value;
    }

    handleSubjectChange(event) {
        this.subject = event.target.value;
    }

    handleBodyChange(event) {
        this.body = event.target.value;
    }

    handleAttachmentChange(event) {
        this.attachment = event.target.files[0];
    }

    sendEmail() {
        if (this.attachment) {
            // Read the attached file data
            const reader = new FileReader();
            reader.onload = (event) => {
                const fileData = event.target.result;
                this.sendEmailWithAttachment(fileData);
            };
            reader.readAsDataURL(this.attachment);
        } else {
            // If no attachment, send the email without it
            this.sendEmailWithoutAttachment();
        }
    }

    sendEmailWithAttachment(fileData) {
        // Call the Apex method with individual parameters
        sendEmail({
            toEmail: this.recipient,
            subject: this.subject,
            body: this.body,
            attachmentData: fileData,
        })
            .then(result => {
                // Handle success, e.g., show a success message
                console.log('Email sent successfully: ', result);
                this.closePopup();
            })
            .catch(error => {
                // Handle error, e.g., show an error message
                console.error('Email sending failed: ', error);
            });
    }

    sendEmailWithoutAttachment() {
        // Call the Apex method with individual parameters without attachment
        sendEmail({
            toEmail: this.recipient,
            subject: this.subject,
            body: this.body,
            attachmentData: null,
        })
            .then(result => {
                // Handle success, e.g., show a success message
                console.log('Email sent successfully: ', result);
                this.closePopup();
            })
            .catch(error => {
                // Handle error, e.g., show an error message
                console.error('Email sending failed: ', error);
            });
    }
}
