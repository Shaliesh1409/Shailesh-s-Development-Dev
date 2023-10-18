import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import ACCOUNT_SELECTED_MESSAGE from '@salesforce/messageChannel/SampleMessageChannel__c';
import fetchAccount from '@salesforce/apex/AccountRelatedObj.fetchAccount';
export default class LwcTask4  extends LightningElement {
    selectedAccount = '';
    accountOptions = [];

    @wire(MessageContext) messageContext;

    @wire(fetchAccount)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accountOptions = data.map(account => ({
                label: account.Name,
                value: account.Id
            }));
        } else if (error) {
            console.error('Error loading accounts', error);
        }
    }

    handleAccountSelection(event) {
        this.selectedAccount = event.detail.value;
        const message = {
            accountId: this.selectedAccount
        };
        publish(this.messageContext, ACCOUNT_SELECTED_MESSAGE, message);
    }
}










// import { publish, MessageContext } from 'lightning/messageService';
// import { LightningElement, track, wire } from 'lwc';
// import fetchAccount from '@salesforce/apex/AccountRelatedObj.fetchAccount';
// import MyMessageChannel from '@salesforce/messageChannel/SampleMessageChannel__c';
// export default class LwcTask4 extends LightningElement {
//     @track acc;
//     selectedAccount = '';

//     message;
//     msg;

//     @wire(MessageContext) messageContext;

//     @wire(fetchAccount)
//     wiredAccounts({ error, data }) {
//         if (data) {
//             this.acc = result;

//             console.log(JSON.stringify(result));
//             console.log("result", this.acc);
//         } else if (error) {
//             console.error('Error loading accounts', error);
//         }
//     }

//         handleAccountSelection(event) {
//             this.selectedAccount = event.detail.value;
//              message = {
//                 accountId: this.selectedAccount
//             };
//             publish(this.messageContext, MyMessageChannel, message);
//         }

//     }



    // @track selectedOption;
    // changeHandler(event) {
    // const field = event.target.name;
    // if (field === 'optionSelect') {
    //     this.selectedOption = event.target.value;
    //         alert("you have selected : ",this.selectedOption);
    //     } 
    // }