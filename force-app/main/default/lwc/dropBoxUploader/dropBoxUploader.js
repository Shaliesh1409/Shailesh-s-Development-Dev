import { LightningElement, api , track } from 'lwc';
import uploadFileByRecord from '@salesforce/apex/DropboxController.uploadFileByRecord';
import deleteFile from '@salesforce/apex/DropboxController.deleteFile';
// import {NavigationMixin} from 'lightning/navigation'

export default class ContactFileUploader extends LightningElement {
    @api recordId;
    @api files;
    acceptedFormats = ['.jpg', '.jpeg', '.png', '.pdf'];




    handleRecordIdChange(event) {
        this.recordId = event.target.value;
    }
    handleUploadFinished(event) {
        const fileIds = event.detail.files.map((file) => file.documentId);

        if (fileIds && fileIds.length > 0) {
            uploadFileByRecord({ recordId: this.recordId, fileIds: fileIds })
                .then((result) => {
                    console.log('result-->',result);
                    this.files = result;
                    // this.files.push(result);
                    console.log('this.files-->',this.files);
                    if (result && result.length > 0) {
                        // this.files = result;
                        console.log('Success');
                        alert('file uploaded Successfully');

                    // if (result === 'Files uploaded successfully') {
                    //     console.log('Success');
                    //     // this.files =  fileIds;                                                
                    } else {
                        console.error('error :',result);
                        alert('error uploading files');
                    }
                })
                .catch((error) => {
                    console.error('Error uploading files: ' , error);
                });
        }
    }

    
    handleDeleteClick(event) {
        // const fileIds = event.detail.files.map((file) => file.documentId);
        // console.log(fileIds);
        console.log(this.files);
        if (this.files) {
            deleteFile({ filepath: this.files })
                .then((result) => {
                    if (result === 'File deleted successfully') {
                        console.log('file deleted successfullly');
                        alert('file deleted successfullly');
                    } else {
                        console.error(result);
                    }
                })
                .catch((error) => {
                    console.error('Error deleting file: ' + error);
                });
        }
    }

}




// import { LightningElement, api } from 'lwc';
// import uploadFileByRecord from '@salesforce/apex/DropboxController.uploadFileByRecord';

// export default class dropBoxUploader extends LightningElement {
//     @api recordId;

//     handleRecordIdChange(event) {
//         this.recordId = event.target.value;
//     }

//     handleUploadFinished(event) {
//         // Call the Apex method to upload the files with the recordId parameter
//         uploadFileByRecord({ recordId: this.recordId })
//             .then(result => {
//                 if (result === 'Files uploaded successfully') {
//                     console.log('Files uploaded successfully.');
//                     // You can handle success as needed.
//                 } else {
//                     console.error(result);
//                 }
//             })
//             .catch(error => {
//                 console.error('Error uploading files: ' + error);
//             });
//     }

//     handleViewClick(event) {
//         // Implement logic to view the file, e.g., open in a new window.
//     }
// }

// import { LightningElement, track, api } from 'lwc';
// import uploadFileByRecord from '@salesforce/apex/DropboxController.uploadFileByRecord';
// // // import deleteFile from '@salesforce/apex/DropboxController.deleteFile';

// export default class DropboxIntegration extends LightningElement {
//     @api recordId;
//     @track files = [];
//     acceptedFormats = ['.jpg', '.jpeg', '.png', '.pdf'];

//     handleRecordIdChange(event) {
//         this.recordId = event.target.value;
//         console.log(recordId);
//     }

//     handleUploadFinished(event) {
//         const fileIds = event.detail.files.map(file => file.documentId);
//         console.log(fileIds);
//         console.log(event.detail);
//         console.log(event);
    
//         if (fileIds && fileIds.length > 0) {
//             // Call the Apex method to upload the files
//             uploadFileByRecord({ recordId: this.recordId, fileIds: fileIds })
//                 .then(result => {
//                     if (result && Array.isArray(result) && result.length > 0) {
//                         console.log('Files uploaded successfully:', result);
//                         this.files = this.files.concat(result);
//                     } else {
//                         console.error('No files were uploaded or an error occurred during the upload.');
//                     }
//                 })
//                 .catch(error => {
//                     console.error('Error uploading files: ' + error);
//                 });
//         }
//     }
    
//         // uploadFileByRecord({ recordId: this.recordId })
//         //     .then(result => {
//         //         if (result === 'Files uploaded successfully') {
//         //             console.log('Files uploaded successfully.');
//         //             // You can handle success as needed.
//         //         } else {
//         //             console.error(result);
//         //         }
//         //     })
//         //     .catch(error => {
//         //         console.error('Error uploading files: ' + error);
//         //     });
       
    

//     handleViewClick(event) {
//         // Implement logic to view the file, e.g., open in a new window.
//     }

//     handleDeleteClick(event) {
//         const fileId = event.target.dataset.fileid;
        
//         if (fileId) {
//             // Call the Apex method to delete the file
//             deleteFile({ fileId: fileId })
//                 .then(result => {
//                     if (result === 'File deleted successfully') {
//                         // Remove the deleted file from the list
//                         this.files = this.files.filter(file => file.Id !== fileId);
//                         console.log('File deleted successfully:', fileId);
//                     } else {
//                         console.error(result);
//                     }
//                 })
//                 .catch(error => {
//                     console.error('Error deleting file: ' + error);
//                 });
//         }
//     }
// }
