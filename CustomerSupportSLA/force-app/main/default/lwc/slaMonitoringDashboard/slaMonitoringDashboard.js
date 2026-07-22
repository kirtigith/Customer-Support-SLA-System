import { LightningElement, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getDashboardData from '@salesforce/apex/SLAMonitoringController.getDashboardData';

export default class SlaMonitoringDashboard extends LightningElement {

    dashboard;
    error;

    isLoading = true;

    @wire(getDashboardData)
    wiredDashboard({ data, error }) {

        // Apex call completed
        this.isLoading = false;

        if (data) {

            this.dashboard = data;
            this.error = undefined;

        } else if (error) {

            this.dashboard = undefined;
            this.error = error;

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Unable to load SLA Dashboard.',
                    variant: 'error'
                })
            );

            console.error(error);
        }
    }

    // ==========================
    // Getters
    // ==========================

    get hasData() {
        return this.dashboard;
    }

    get hasNoData() {
        return !this.isLoading && !this.dashboard;
    }

}