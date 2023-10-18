import { LightningElement, track, wire } from 'lwc';
import getObjectList from '@salesforce/apex/ObjectNameController.getObjectList';
import getObjectRecords from '@salesforce/apex/ObjectNameController.getObjectRecords';
import searchRecords from '@salesforce/apex/ObjectNameController.searchRecords';

export default class MultiSelectComboBox extends LightningElement {
    @track selectedObjects = new Set();
    objectOptions = [];
    dropdownOpen = false;
    filter = '';
    optionState = [];
    relatedRecords = []; // Store related records
    @track searchKeyword = ''; // Initialize the search keyword
    searchResults = []; // Store search results

    @wire(getObjectList)
    wiredObjects({ data, error }) {
        if (data) {
            this.objectOptions = data.map(obj => ({ label: obj, value: obj, checked: false }));
        } else if (error) {
            console.error('Error fetching object list', error);
        }
    }

    get dropdownClass() {
        return this.dropdownOpen ? 'dropdown-content show' : 'dropdown-content';
    }

    toggleDropdown() {
        this.dropdownOpen = !this.dropdownOpen;
    }

    handleOptionChange(event) {
        const selectedValue = event.target.value;
        const checked = event.target.checked;

        // Update the object options
        this.objectOptions = this.objectOptions.map(option => ({
            ...option,
            checked: option.value === selectedValue ? checked : option.checked
        }));

        // Update the selected objects
        if (checked) {
            this.selectedObjects.add(selectedValue);
        } else {
            this.selectedObjects.delete(selectedValue);
        }
    }

    async fetchRelatedRecords() {
        try {
            // Convert selected objects to an array for Apex call
            const selectedObjectArray = Array.from(this.selectedObjects);
            
            // Call the Apex method to fetch related records
            const result = await getObjectRecords({ objectNames: selectedObjectArray });

            if (result) {
                this.relatedRecords = result;
            }
        } catch (error) {
            console.error('Error fetching related records', error);
        }
    }

    handlechange(e) {
        this.searchKeyword = e.target.value;
    }

    handleSearchClick() {
        // Fetch related records when the search button is clicked
        // this.fetchRelatedRecords();
        console.log('selectedObjects-->',this.selectedObjects);
        console.log('selectedObjects-->',Array.from(this.selectedObjects));
        console.log('searchKeyword-->',this.searchKeyword);
           searchRecords({
            objectNames: Array.from(this.selectedObjects),
            // objectNames: this.selectedObjects,
            searchKeyword: this.searchKeyword
        })
            .then(result => {
                if (result) {
                    this.searchResults = result;
                    console.log(result);
                }
            })
            .catch(error => {
                console.error('Error performing SOSL search', error);
            });

        // Close the dropdown
        this.dropdownOpen = false;
    }

    get isSelected() {
        return (value) => this.selectedObjects.has(value);
    }
}