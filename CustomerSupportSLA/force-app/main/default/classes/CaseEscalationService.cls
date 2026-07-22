public class CaseEscalationService {
    public static void checkSLA(List<Case> caseList) {
        List<Case> casesToUpdate = new List<Case>();
        List<Escalation_History__c> escalationList = new List<Escalation_History__c>();
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for (Case c : caseList) {
            if (
                c.Status == 'Open' &&
                c.SLA_Deadline__c != null &&
                System.now() > c.SLA_Deadline__c
            ) {

                Escalation_History__c escalation = new Escalation_History__c();

                escalation.Related_Case__c = c.Id;
                escalation.Escalation_Date__c = System.now();
                escalation.Escalation_Reason__c = 'SLA Breached';

                escalation.Previous_Priority__c = c.Priority;
                escalation.New_Priority__c = 'Critical';
                escalation.Manager_Notified__c = true;

                escalationList.add(escalation);

                c.Priority = 'Critical';
                casesToUpdate.add(c);

                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

                mail.setToAddresses(
                    new String[]{'manager@example.com'}
                );

                mail.setSubject(
                    'Case Escalated - ' + c.CaseNumber
                );

                mail.setPlainTextBody(
                    'Hello Manager,\n\n' +
                    'Case Number: ' + c.CaseNumber + '\n' +
                    'Subject: ' + c.Subject + '\n' +
                    'Priority: Critical\n\n' +
                    'Please review immediately.'
                );

                emails.add(mail);

            }
        }

        if (!escalationList.isEmpty()) {
            insert escalationList;
        }

        if (!casesToUpdate.isEmpty()) {
            update casesToUpdate;
        }

        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }

    }

}