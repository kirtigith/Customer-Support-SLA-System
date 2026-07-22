public with sharing class AICaseAssistantController {

    @AuraEnabled
    public static AIResponse classifyCase(String message) {

        AIResponse response = new AIResponse();

        if(String.isBlank(message)){
            response.category = 'Unknown';
            response.priority = 'Low';
            response.team = 'Customer Support';
            return response;
        }

        String input = message.toLowerCase();

        // Payment Issues
        if(input.contains('payment') ||
           input.contains('refund') ||
           input.contains('transaction')){

            response.category = 'Payment Issue';
            response.priority = 'High';
            response.team = 'Finance';
        }

        // Technical Issues
        else if(input.contains('login') ||
                input.contains('password') ||
                input.contains('otp')){

            response.category = 'Technical Issue';
            response.priority = 'Medium';
            response.team = 'Technical Support';
        }

        // Delivery Issues
        else if(input.contains('delivery') ||
                input.contains('shipment') ||
                input.contains('courier') ||
                input.contains('tracking') ||
                input.contains('package')){

            response.category = 'Delivery Issue';
            response.priority = 'Medium';
            response.team = 'Logistics';
        }

        // Default
        else{

            response.category = 'General Inquiry';
            response.priority = 'Low';
            response.team = 'Customer Support';

        }

        return response;
    }

    public class AIResponse{

        @AuraEnabled
        public String category;

        @AuraEnabled
        public String priority;

        @AuraEnabled
        public String team;

    }

}