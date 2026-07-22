public with sharing class SLAMonitoringController {
    @AuraEnabled(cacheable=true)
    public static DashboardData getDashboardData(){

        DashboardData data = new DashboardData();
        
        Integer totalCases = [
            SELECT COUNT()
            FROM Case
        ];

        Integer breachedCases = [
            SELECT COUNT()
            FROM Case
            WHERE SLA_Deadline__c < :System.now()
            AND Status != 'Closed'
        ];

        AggregateResult ratingResult = [
            SELECT AVG(Customer_Rating__c) avgRating
            FROM Case
            WHERE Customer_Rating__c != null
        ];
        Decimal averageRating = 0;

        if(ratingResult.get('avgRating') != null){
            averageRating =
                (Decimal)ratingResult.get('avgRating');
        }

        List<Case> closedCases = [

            SELECT
                CreatedDate,
                ClosedDate
            FROM Case
            WHERE
                Status='Closed'
                AND ClosedDate != null

        ];

        Decimal totalHours = 0;

        for(Case c : closedCases){

            Long milliseconds =
                c.ClosedDate.getTime() -
                c.CreatedDate.getTime();

            Decimal hours =
                milliseconds /
                (1000 * 60 * 60);
            totalHours += hours;
        }
        Decimal avgResolution = 0;

        if(closedCases.size() > 0){

            avgResolution =
                totalHours /
                closedCases.size();
        }
        Decimal compliance = 100;

        if(totalCases > 0){
            compliance =
                ((Decimal)(totalCases-breachedCases)
                / totalCases) * 100;
        }

        data.totalCases = totalCases;
        data.breachedCases = breachedCases;
        data.averageRating = averageRating.setScale(2);
        data.averageResolutionHours = avgResolution.setScale(2);
        data.compliancePercentage = compliance.setScale(2);
        return data;
    }

    public class DashboardData{
        @AuraEnabled
        public Integer totalCases;

        @AuraEnabled
        public Integer breachedCases;

        @AuraEnabled
        public Decimal averageResolutionHours;

        @AuraEnabled
        public Decimal averageRating;

        @AuraEnabled
        public Decimal compliancePercentage;
    }
}