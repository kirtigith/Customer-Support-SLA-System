global class CaseEscalationBatch implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {

        return Database.getQueryLocator(
            [
                SELECT Id,
                       Status,
                       Priority,
                       SLA_Deadline__c
                FROM Case
                WHERE Status = 'Open'
            ]
        );
    }

    global void execute(Database.BatchableContext bc, List<Case> scope) {

        CaseEscalationService.checkSLA(scope);

    }

    global void finish(Database.BatchableContext bc) {

        System.debug('Daily Case Escalation Batch Completed.');

    }
}