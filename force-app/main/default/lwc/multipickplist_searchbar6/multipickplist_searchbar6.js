import { LightningElement, track, wire } from 'lwc';
import getObjectRecords from '@salesforce/apex/PicklistController.getObjectRecords';
import getAllObjectNames from '@salesforce/apex/PicklistController.getAllObjectNames';

const columns = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'Name', fieldName: 'Name' },
    { label: 'LastName', fieldName: 'LastName' },
    { label: 'FirstName', fieldName: 'FirstName' }
];

export default class ObjectPicker extends LightningElement {
    @track selectedObject = [];
    @track objectOptions = [];
    @track objectRecords = [];
    @track columns = [];

    
    connectedCallback() {
        this.loadObjectOptions();
    }

    @wire(getAllObjectNames)
    wiredObjectNames({ error, data }) {
        if (data) {
            this.objectOptions = data.map(objName => ({ label: objName, value: objName }));
        }
    }

    loadObjectOptions() {
        // getAllObjectNames()
        //     .then(result => {
        //         this.objectOptions = result.map(objName => ({ label: objName, value: objName }));
        //     })
        //     .catch(error => {
        //         console.error('Error loading object options', error);
        //     });
        getObjectRecords({ objectApiName: this.selectedObject })
            .then(result => {
                if (result) {
                    this.objectRecords = result;
                    // Assuming you have at least one record to determine columns
                    const recordFields = Object.keys(this.objectRecords[0]);
                    this.columns = recordFields.map(field => ({
                        label: field,
                        fieldName: field,
                        type: 'text'
                    }));
                } else {
                    this.objectRecords = [];
                    this.columns = [];
                }
            })
            .catch(error => {
                console.error('Error loading object records', error);
            });
    }

    handleObjectSelection(event) {
        this.selectedObject = Array.from(event.target.selectedOptions, option => option.value); 
                this.loadObjectOptions();

        // const selectedValue = event.target.value;

        // if (event.target.checked) {
        //     this.selectedObject.push(selectedValue);
        // } else {
        //     const index = this.selectedObject.indexOf(selectedValue);
        //     if (index !== -1) {
        //         this.selectedObject.splice(index, 1);
        //     }
        // }
    }
}
// event.detail.value;