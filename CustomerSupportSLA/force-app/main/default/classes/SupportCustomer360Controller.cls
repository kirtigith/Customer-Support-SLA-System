public with sharing class SupportCustomer360Controller {
    @AuraEnabled(cacheable=true)
    public static Customer360Wrapper getCustomer360(Id caseId) {

        Customer360Wrapper wrapper = new Customer360Wrapper();

        Case currentCase = [
            SELECT
                Id,
                CaseNumber,
                ContactId,
                Contact.Name,
                Contact.Email,
                Contact.Phone,
                Contact.AccountId
            FROM Case
            WHERE Id = :caseId
            LIMIT 1
        ];

        if (currentCase.ContactId == null) {
            return wrapper;
        }

        wrapper.contact = [
            SELECT
                Id,
                Name,
                Email,
                Phone,
                AccountId
            FROM Contact
            WHERE Id = :currentCase.ContactId
            LIMIT 1
        ];

        if (wrapper.contact.AccountId != null) {

            wrapper.account = [
                SELECT
                    Id,
                    Name,
                    Industry,
                    Phone,
                    Website
                FROM Account
                WHERE Id = :wrapper.contact.AccountId
                LIMIT 1
            ];
        }

        wrapper.previousCases = [
            SELECT
                Id,
                CaseNumber,
                Status,
                Priority,
                CreatedDate
            FROM Case
            WHERE ContactId = :wrapper.contact.Id
            ORDER BY CreatedDate DESC
        ];

        wrapper.feedbackList = [
            SELECT
                Id,
                Rating__c,
                Comments__c,
                Feedback_Date__c
            FROM Customer_Feedback__c
            WHERE Related_Case__c = :caseId
        ];

        return wrapper;
    }

    public class Customer360Wrapper {

        @AuraEnabled
        public Contact contact;

        @AuraEnabled
        public Account account;

        @AuraEnabled
        public List<Case> previousCases;

        @AuraEnabled
        public List<Customer_Feedback__c> feedbackList;

    }
}