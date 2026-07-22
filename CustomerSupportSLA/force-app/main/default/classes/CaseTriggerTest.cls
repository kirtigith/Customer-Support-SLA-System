@isTest
private class CaseTriggerTest {

    @isTest
    static void testSLABreach() {

        Case c = new Case(
            Subject = 'Internet Down',
            Status = 'Open',
            Priority = 'High',
            Origin = 'Phone',
            SLA_Deadline__c = System.now().addHours(-2)
        );

        insert c;

        Test.startTest();

        c.Subject = 'Updated Subject';
        update c;

        Test.stopTest();

        Case updatedCase = [

            SELECT Priority

            FROM Case

            WHERE Id = :c.Id

        ];

        System.assertEquals(
            'Critical',
            updatedCase.Priority
        );

        List<Escalation_History__c> history = [

            SELECT Id

            FROM Escalation_History__c

            WHERE Related_Case__c = :c.Id

        ];

        System.assertEquals(
            1,
            history.size()
        );

    }
}