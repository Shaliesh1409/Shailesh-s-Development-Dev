import { LightningElement,api } from 'lwc';
export default class Custommultiselectpicklist extends LightningElement {

    @api label;
    @api options = [];
    @api value = [];

    handleSelection(event) {
        this.value = Array.from(event.target.selectedOptions, option => option.value);
    }
}