import { LightningElement } from 'lwc';

import classifyCase
from '@salesforce/apex/AICaseAssistantController.classifyCase';

import { ShowToastEvent }
from 'lightning/platformShowToastEvent';

export default class AiCaseAssistant extends LightningElement {

    message = '';

    result;

    handleMessageChange(event){

        this.message = event.target.value;

    }

    analyzeCase(){

        classifyCase({

            message : this.message

        })

        .then(result => {

            this.result = result;

        })

        .catch(error => {

            this.dispatchEvent(

                new ShowToastEvent({

                    title:'Error',

                    message:'Unable to analyze customer message.',

                    variant:'error'

                })

            );

            console.error(error);

        });

    }

}