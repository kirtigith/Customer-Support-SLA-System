public class CaseTriggerHandler {

    public static void handleAfter(
        List<Case> newCases,
        Map<Id, Case> oldMap
    ) 
    {
        CaseEscalationService.checkSLA(newCases);
    }

}