# Chapter 4 – Process Flow Diagram

## Overview

The Customer Support SLA Management System follows an automated workflow that streamlines customer support operations from case creation to resolution. The process integrates Salesforce Flows, Apex, Lightning Web Components (LWC), and Reports & Dashboards to ensure efficient case management, SLA compliance, and customer satisfaction.

---

# Process Flow Diagram

> **Insert your Process Flow Diagram here**

```text
Customer Creates Case
        │
        ▼
AI Case Classification
        │
        ▼
Automatic Case Assignment
        │
        ▼
SLA Due Date Calculation
        │
        ▼
Support Agent Works on Case
        │
   ┌────┴─────┐
   │          │
Resolved   SLA Missed
   │          │
   ▼          ▼
Customer    Case Escalated
Feedback    to Manager
   │          │
   └────┬─────┘
        ▼
Reports & Dashboards
```

**GitHub Image (after uploading):**

```markdown
![Process Flow Diagram](../Diagrams/ProcessFlow.png)
```

---

# Process Flow Explanation

## Step 1 – Customer Creates a Case

The support process begins when a customer submits a support request. Cases can be created through Web-to-Case, Email-to-Case, or manually by a support agent.

**Purpose**
- Capture customer issues.
- Create a centralized support record.

---

## Step 2 – AI Case Classification

The AI Case Assistant analyzes the customer's message using keyword-based logic and recommends the appropriate Category, Priority, and Support Team.

**Purpose**
- Reduce manual effort.
- Improve classification accuracy.
- Speed up case routing.

**Example**

**Input**
```
My payment failed while placing my order.
```

**Output**
- Category: Payment Issue
- Priority: High
- Team: Finance

---

## Step 3 – Automatic Case Assignment

Based on the case category and priority, Salesforce Flow automatically assigns the case to the appropriate support queue or support agent.

**Purpose**
- Eliminate manual assignment.
- Ensure cases reach the correct team quickly.

---

## Step 4 – SLA Due Date Calculation

The system automatically calculates the SLA Due Date according to the case priority.

Example:

- High Priority → 4 Hours
- Medium Priority → 8 Hours
- Low Priority → 24 Hours

**Purpose**
- Track response deadlines.
- Ensure SLA compliance.

---

## Step 5 – Support Agent Works on the Case

The assigned support agent investigates the issue, communicates with the customer, updates the case status, and records the resolution.

**Purpose**
- Resolve customer issues efficiently.
- Maintain accurate case information.

---

## Step 6A – Case Resolved

If the issue is successfully resolved before the SLA deadline:

- Case Status is updated to Closed.
- Resolution details are saved.
- Customer receives a resolution notification.
- Customer is invited to provide feedback.

**Purpose**
- Complete the support process.
- Collect customer satisfaction data.

---

## Step 6B – SLA Missed

If the SLA deadline passes before the case is resolved:

- The system identifies the SLA violation.
- Reminder emails may be sent.
- The case is automatically escalated.

**Purpose**
- Ensure overdue cases receive immediate attention.

---

## Step 7 – Case Escalation

Escalated cases are assigned to the Support Manager. Apex Batch and Scheduled Apex continuously monitor overdue cases and perform automatic escalations.

**Purpose**
- Prevent unresolved high-priority cases.
- Improve SLA compliance.

---

## Step 8 – Customer Feedback

After case closure, customers can submit:

- Rating
- Comments

This feedback is stored in the Customer Feedback custom object.

**Purpose**
- Measure customer satisfaction.
- Identify opportunities for service improvement.

---

## Step 9 – Reports & Dashboards

Salesforce Reports and Dashboards provide real-time visibility into support performance.

Managers can monitor:

- Case Volume
- SLA Compliance
- Escalated Cases
- Customer Satisfaction
- Average Resolution Time

**Purpose**
- Support data-driven decision-making.
- Monitor team performance.
- Track key performance indicators (KPIs).

---

# Summary

The Customer Support SLA Management System automates the complete support lifecycle using Salesforce Service Cloud. By combining Flows, Apex, Lightning Web Components, Reports, Dashboards, and AI-assisted case classification, the system minimizes manual work, improves SLA compliance, enhances customer satisfaction, and provides managers with real-time operational insights.