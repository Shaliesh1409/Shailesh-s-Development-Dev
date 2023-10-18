import { LightningElement, wire,track } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import ACCOUNT_SELECTED_MESSAGE from '@salesforce/messageChannel/SampleMessageChannel__c';
import getContacts from '@salesforce/apex/AccountRelatedObj.getContacts';
import fetchOpportunity from '@salesforce/apex/AccountRelatedObj.fetchOpportunity';


    const columns = [{
    label: 'First Name',
    fieldName: 'FirstName'
},
{
    label: 'Last Name',
    fieldName: 'LastName'
}];

const columnsOpp = [{
    label: 'Name',
    fieldName: 'Name'

}

];


export default class ChildlwcTask4 extends LightningElement {
    selectedAccountId;
    @track con;
    @track opp;

    @wire(MessageContext) messageContext;

    subscription;

    connectedCallback() {
        this.subscription = subscribe(
            this.messageContext,
            ACCOUNT_SELECTED_MESSAGE,
            (message) => this.handleAccountSelected(message)
        );
    }

    handleAccountSelected(message) {
        this.selectedAccountId = message.accountId;
        getContacts({ accountId: this.selectedAccountId })
            .then(result => {
                this.con = result;

                console.log(JSON.stringify(result));
                console.log("result1 con", this.con);
            })
        fetchOpportunity({ accountId: this.selectedAccountId })
            .then(result => {
                this.opp = result;

                console.log(JSON.stringify(result));
                console.log("result1 opp", this.opp);
            })
        // Fetch and display Contacts and Opportunities related to the selected Account
    }

    disconnectedCallback() {
        unsubscribe(this.subscription);
    }
}