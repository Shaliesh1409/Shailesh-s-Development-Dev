// import { LightningElement } from 'lwc';

// export default class ImageuploaderTask2 extends LightningElement {


//     fileName = '';
//     fileUrl = '';

//     handleFileUpload(event) {
//         const file = event.target.files[0];
//         this.fileName = file.name;
//         this.fileUrl = URL.createObjectURL(file);
//     }


// }

import { LightningElement, track } from 'lwc';

export default class InputFileUploadPDF extends LightningElement {


    @track fileUrl;
    @track fileName;
    

    handleFileUpload(event) {
        const file = event.target.files[0];
        this.fileName = file.name;
        this.fileUrl = URL.createObjectURL(file);
    }

}