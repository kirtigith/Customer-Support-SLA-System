@isTest
private class CaseEscalationBatchTest {

    @isTest
    static void testBatch() {

        Case c = new Case(
            Subject = 'Payment Failed',
            Status = 'Open',
            Priority = 'Medium',
            Origin = 'Email',
            SLA_Deadline__c = System.now().addDays(-1)
        );

        insert c;

        Test.startTest();

        Database.executeBatch(
            new CaseEscalationBatch(),
            200
        );

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

    }
}