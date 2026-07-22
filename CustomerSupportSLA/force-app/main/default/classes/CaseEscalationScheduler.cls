global class CaseEscalationScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {

        Database.executeBatch(
            new CaseEscalationBatch(),
            200
        );

    }
}