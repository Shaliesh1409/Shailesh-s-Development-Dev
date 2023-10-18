// import { LightningElement, api } from 'lwc';
// import { ShowToastEvent } from 'lightning/platformShowToastEvent';
// import uploadFile from '@salesforce/apex/FileUploaderClass.uploadFile'
// export default class FileUploaderCompLwc extends LightningElement {
//     @api recordId;
//     fileData
//     openfileUpload(event) {
//         const file = event.target.files[0]
//         var reader = new FileReader()
//         reader.onload = () => {
//             var base64 = reader.result.split(',')[1]
//             this.fileData = {
//                 'filename': file.name,
//                 'base64': base64,
//                 'recordId': this.recordId
//             }
//             console.log(this.fileData)
//         }
//         reader.readAsDataURL(file)
//     }
    
//     handleClick(){
//         const {base64, filename, recordId} = this.fileData
//         uploadFile({ base64, filename, recordId }).then(result=>{
//             this.fileData = null
//             let title = `${filename} uploaded successfully!!`
//             this.toast(title)
//         })
//     }

//     toast(title){
//         const toastEvent = new ShowToastEvent({
//             title, 
//             variant:"success"
//         })
//         this.dispatchEvent(toastEvent)
//     }
// }
import { LightningElement, api } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class FileUploadLWC extends LightningElement {
    @api recordId;
    uploadedFileNames = [];
    fileNames =[];
    relatedListTitle;
    isUploaded = false;

    pageSize=2;
    pageNumber;
    totalPages;

    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        for(let i = 0; i < uploadedFiles.length; i++) {
            this.uploadedFileNames.push(uploadedFiles[i].name);
        }
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: uploadedFiles.length + ' Files uploaded Successfully: ' + this.uploadedFileNames,
                variant: 'success',
            }),
        );
        this.isUploaded =true;
        this.relatedListTitle =this.uploadedFileNames.length + " Files";

        this.pageNumber =1;
        this.totalPages = Math.ceil((this.uploadedFileNames.length)/this.pageSize);
        console.log("Total : " + this.uploadedFileNames);
        console.log( "number : " +this.pageNumber);
        this.fileNamesPaginate(this.pageNumber);
    }

    get disablePrevious(){
        if(this.pageNumber==1){
            return true;
        }
        return false;
    }
    get disableNext(){
        if(this.pageNumber==this.totalPages){
            return true;
        }
        return false;
    }

    sizeChanged(event){
        this.pageSize = event.target.value;
        this.totalPages = Math.ceil((this.uploadedFileNames.length)/this.pageSize);
        this.fileNamesPaginate(this.pageNumber);
    }

    onNext(){
        this.pageNumber+=1;
        this.fileNamesPaginate(this.pageNumber);
    }
    onPrevious(){
        this.pageNumber-=1;
        this.fileNamesPaginate(this.pageNumber);
    }

    fileNamesPaginate(pageNumber){
        this.fileNames = [];
        this.totalPages = Math.ceil((this.uploadedFileNames.length)/this.pageSize);
        console.log(Math.ceil((this.uploadedFileNames.length)/this.pageSize));
        this.fileNames = this.uploadedFileNames.slice((pageNumber*this.pageSize)-this.pageSize, Math.min(pageNumber*this.pageSize, this.uploadedFileNames.length));
        console.log("files: " + (pageNumber*this.pageSize)-this.pageSize+ " To "+ Math.min(pageNumber*this.pageSize, this.uploadedFileNames.length)+ "  ::: " +this.fileNames);
    }
}