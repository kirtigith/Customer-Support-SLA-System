import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getCustomer360 from '@salesforce/apex/SupportCustomer360Controller.getCustomer360';

const COLUMNS = [
    {
        label: 'Case Number',
        fieldName: 'CaseNumber',
        type: 'text'
    },
    {
        label: 'Status',
        fieldName: 'Status',
        type: 'text'
    },
    {
        label: 'Priority',
        fieldName: 'Priority',
        type: 'text'
    },
    {
        label: 'Created Date',
        fieldName: 'CreatedDate',
        type: 'date'
    }
];

export default class Customer360View extends LightningElement {

    @api recordId;

    customerData;
    error;

    columns = COLUMNS;

    @wire(getCustomer360, { caseId: '$recordId' })
    wiredCustomer({ data, error }) {

        if (data) {

            this.customerData = data;
            this.error = undefined;

        } else if (error) {

            this.customerData = undefined;
            this.error = error;

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Unable to load Customer 360 information.',
                    variant: 'error'
                })
            );

            console.error(error);
        }
    }

    // ==========================
    // Getters
    // ==========================

    get hasCustomer() {
        return this.customerData &&
               this.customerData.contact;
    }

    get hasPreviousCases() {
        return this.customerData &&
               this.customerData.previousCases &&
               this.customerData.previousCases.length > 0;
    }

    get hasFeedback() {
        return this.customerData &&
               this.customerData.feedbackList &&
               this.customerData.feedbackList.length > 0;
    }

}