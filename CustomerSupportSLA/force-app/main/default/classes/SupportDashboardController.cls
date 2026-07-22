    public with sharing class SupportDashboardController {

        @AuraEnabled(cacheable=true)
        public static DashboardData getDashboardData(){

            DashboardData data = new DashboardData();

            data.totalCases =
                [SELECT COUNT() FROM Case];

            data.openCases =
                [SELECT COUNT()
                FROM Case
                WHERE Status='Open'];

            data.highPriorityCases =
                [SELECT COUNT()
                FROM Case
                WHERE Priority='High'];

            data.slaBreachedCases =
                [SELECT COUNT()
                FROM Case
                WHERE Status='Open'
                AND SLA_Deadline__c < :System.now()];

            return data;
        }

        public class DashboardData{

            @AuraEnabled
            public Integer totalCases;

            @AuraEnabled
            public Integer openCases;

            @AuraEnabled
            public Integer highPriorityCases;

            @AuraEnabled
            public Integer slaBreachedCases;

        }

    }