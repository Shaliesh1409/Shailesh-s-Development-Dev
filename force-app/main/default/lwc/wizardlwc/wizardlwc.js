import { LightningElement, track, wire,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import sendEmail from '@salesforce/apex/account_lead_contact.sendEmail';
import fetchAccount from '@salesforce/apex/account_lead_contact.fetchAccount';
import getContacts from '@salesforce/apex/account_lead_contact.getContacts';
import fetchLead from '@salesforce/apex/account_lead_contact.fetchLead';

// const columns = [
//     { label: 'Id', fieldName: 'Id' },
//     { label: 'Name', fieldName: 'Name' } 

// ];
// const columns2 = [
//     { label: 'Id', fieldName: 'Id' },
//     { label: 'LastName', fieldName: 'LastName' } 

// ];
// const columns3 =[
//      { label: 'Id', fieldName: 'Id' },
//     { label: 'Name', fieldName: 'Name' } 

// ];
const columns = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'Name', fieldName: 'Name' },
    { label: 'LastName', fieldName: 'LastName' },
    { label: 'FirstName', fieldName: 'FirstName' }
];


export default class wizardlwc extends LightningElement {


    @track currentStep = '1';
    // @track acc;
    // @track con;
    // @track lead;
    selectedOption = '';
    @track selectedObjectRecords = [];
    columns = columns;
    // columns2 = columns2;
    // columns3 = columns3;

    @api toEmail = '';
    @api subject = '';
    @api message = '';


    connectedCallback() {
        let a = { Id: 'ok', Name: 'ok' }
        this.acc = a;
    }

    handleOnStepClick(event) {
        this.currentStep = event.target.value;
    }

    get isStepOne() {
        return this.currentStep === "1";
    }

    get isStepTwo() {
        return this.currentStep === "2";
    }

    get isStepThree() {
        return this.currentStep === "3";
    }

    get isEnableNext() {
        return this.currentStep != "3";
    }

    get isEnablePrev() {
        return this.currentStep != "1";
    }

    get isEnableFinish() {
        return this.currentStep === "3";
    }

    handleNext() {
        if (this.currentStep == "1") {
            this.currentStep = "2";
        }
        else if (this.currentStep = "2") {
            this.currentStep = "3";
        }
    }

    handlePrev() {
        if (this.currentStep == "3") {
            this.currentStep = "2";
        }
        else if (this.currentStep = "2") {
            this.currentStep = "1";
        }
    }

    handleFinish() {

    }

    changeHandler(event) {
        try {

            // Get the selected value from the event
            this.selectedOption = event.target.value;
            // You can now use this.selectedOption to access the selected value
            console.log('Selected Option:', this.selectedOption);
            if (this.selectedOption == "OPTION A") {
                fetchAccount()
                    .then(result => {
                        this.selectedObjectRecords = result;

                        console.log(JSON.stringify(result));
                        console.log("result1 con", this.acc);
                    })
            }
            else if (this.selectedOption == "OPTION B") {
                getContacts()
                    .then(result => {
                        this.selectedObjectRecords = result;

                        console.log(JSON.stringify(result));
                        console.log("result1 con", this.con);
                    })
            }
            else if (this.selectedOption == "OPTION C") {
                fetchLead()
                    .then(result => {
                        this.selectedObjectRecords = result;

                        console.log(JSON.stringify(result));
                        console.log("result1 lead", this.lead);
                    })
            }
        } catch (error) {
            console.log('OUTPUT : abc ', error.message);
        }
    }

    handleToEmailChange(event) {
        this.toEmail = event.target.value;
    }

    // Handler for changes in the subject
    handleSubjectChange(event) {
        this.subject = event.target.value;
    }

    // Handler for changes in the message
    handleMessageChange(event) {
        this.message = event.target.value;
    }

    // Function to send the email
    sendEmail() {
        sendEmail({ toAddress: this.toEmail, subject: this.subject, body: this.message })
            .then(() => {
                // Show success toast notification
                this.showToast('Success', 'Email sent successfully', 'success');
                // Clear input fields
                this.clearFields();
            })
            .catch(error => {
                // Show error toast notification
                this.showToast('Error', 'Failed to send email', 'error');
                console.error(error);
            });
    }

    // Function to show toast notifications
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }

    // Function to clear input fields
    clearFields() {
        this.toEmail = '';
        this.subject = '';
        this.message = '';
    }
}