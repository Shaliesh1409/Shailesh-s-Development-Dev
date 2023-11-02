import { LightningElement, api } from 'lwc';
import myResource from "@salesforce/resourceUrl/PageNotFound";

export default class PageNotFound extends LightningElement {
    @api notFoundImage = myResource; 
    @api homeLink = '/'; 

    
}
