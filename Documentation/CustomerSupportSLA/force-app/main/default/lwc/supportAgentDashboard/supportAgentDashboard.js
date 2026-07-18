import { LightningElement, wire } from 'lwc';
import getDashboardData from '@salesforce/apex/SupportDashboardController.getDashboardData';

export default class SupportAgentDashboard extends LightningElement {

    dashboard;

    @wire(getDashboardData)
    wiredData({ error, data }) {

        if (data) {
            this.dashboard = data;
        } else if (error) {
            console.error(error);
        }

    }

}