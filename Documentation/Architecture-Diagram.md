Architecture Layer Explanation

1. User :
The user interacts with the system through the Salesforce Lightning interface. Different users, such as Support Agents, Support Managers, and Salesforce Administrators, perform tasks based on their assigned roles and permissions.

2. Salesforce Service Cloud :
Salesforce Service Cloud acts as the core platform for managing customer support operations. It stores customer data, cases, feedback, and provides standard Service Cloud features for efficient case management.

3. Flows :
Salesforce Flows automate business processes without writing code. In this project, Flows handle case assignment, SLA due date calculation, reminder emails, and case escalation to reduce manual effort.

4. Apex :
Apex is used to implement custom business logic that cannot be achieved through declarative tools alone. It powers dashboard calculations, Customer 360 data retrieval, AI case classification, and scheduled case escalation processes.

5. Lightning Web Components (LWC) :
Lightning Web Components provide a modern, responsive user interface. Custom LWCs developed in this project include the Support Agent Dashboard, Customer 360 View, SLA Monitoring Dashboard, and AI Case Assistant.

6. Reports & Dashboards :
Salesforce Reports and Dashboards provide real-time insights into support operations. Managers can monitor case volume, SLA compliance, escalated cases, and customer satisfaction to support data-driven decision making.