import { LightningElement,track,wire,api } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { getRecordId } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createRecordsFromCSV from '@salesforce/apex/ContactController.createRecordsFromCSV';

export default class CSVuploader extends LightningElement {
    @track uploadedFiles;
    @wire(CurrentPageReference) pageRef;
    @api recordId;

    connectedCallback() {
        console.log(' this.pageRef.state>>'+ this.pageRef.state);
        this.recordId = this.pageRef.attributes.recordId;
        console.log(this.recordId);
    }

    handleUploadFinished(event) {
        this.uploadedFiles = event.detail.files;
        // console.log(this.recordId);
        
    }

    // createRecords() {
    //     if (this.uploadedFiles.length > 0) {
    //         const fileId = this.uploadedFiles[0].documentId;
    //         createRecordsFromCSV({recordId: this.recordId, fileId })
    //             .then(result => {
    //                 const toastEvent = new ShowToastEvent({
    //                     title: 'Success',
    //                     message: 'Records are being processed in background.',
    //                     variant: 'success'
    //                 });
    //                 console.log('Records are being processed asynchronously.');
    //                 this.dispatchEvent(toastEvent);
    //             })
    //             .catch(error => {
    //                 const toastEvent = new ShowToastEvent({
    //                     title: 'Error',
    //                     message: `An error occurred while creating records ->  ${error}`,
    //                     variant: 'error'
    //                 });
    //                 this.dispatchEvent(toastEvent);
    //             });
    //     }
    // }
        createRecords() {
        if (this.uploadedFiles.length > 0) {
            const fileId = this.uploadedFiles[0].documentId;
            createRecordsFromCSV({ recordId: this.recordId, fileId })
                .then(result => {
                    if (result.errorMessage) {
                        const toastEvent = new ShowToastEvent({
                            title: 'Error',
                            message: result.errorMessage,
                            variant: 'error'
                        });
                        this.dispatchEvent(toastEvent);
                    } else if (result.successMessage) {
                        const toastEvent = new ShowToastEvent({
                            title: 'Success',
                            message: result.successMessage,
                            variant: 'success'
                        });
                        this.dispatchEvent(toastEvent);
                    }
                })
                .catch(error => {
                    const toastEvent = new ShowToastEvent({
                        title: 'Error',
                        message: `An error occurred while creating records -> ${error}`,
                        variant: 'error'
                    });
                    this.dispatchEvent(toastEvent);
                });
        }
    }
}







