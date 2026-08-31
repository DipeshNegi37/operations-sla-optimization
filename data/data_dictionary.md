# Data Dictionary

Each row represents one completed operational service request. The dataset is synthetic and created specifically for this portfolio case study.

| Field | Type | Description |
|---|---|---|
| request_id | String | Unique request identifier |
| request_date | Date | Date the request was received |
| request_type | Category | Type of service request |
| priority | Category | Low, Medium, High or Critical |
| customer_segment | Category | Client segment |
| channel | Category | Source channel |
| region | Category | Operating region |
| team | Category | Operations team handling request |
| agent_id | String | Synthetic assigned agent |
| received_at | Timestamp | Request receipt timestamp |
| assigned_at | Timestamp | Assignment timestamp |
| processing_started_at | Timestamp | Active processing start timestamp |
| completed_at | Timestamp | Completion timestamp |
| sla_hours | Numeric | SLA threshold in hours |
| tat_hours | Numeric | Receipt-to-completion duration |
| queue_hours | Numeric | Receipt-to-processing-start duration |
| processing_hours | Numeric | Active processing duration |
| rework_flag | Boolean | Whether additional work was required |
| rework_hours | Numeric | Additional handling time |
| escalation_flag | Boolean | Whether the request was escalated |
| escalation_reason | Category | Escalation reason, if applicable |
| sla_status | Category | Met or Breached |
| breach_reason | Category | Primary modeled reason for breach |

## Derived KPIs

- SLA compliance percentage
- SLA breach percentage
- Average TAT
- P70 TAT
- P90 TAT
- Average queue time
- Average processing time
- Rework rate
- Escalation rate
- Requests per agent
- Workload by team and time period

## Data Design Principle

The data will contain realistic operational relationships suitable for analysis. Hypotheses in the BRD will be tested against the data rather than presented as predetermined conclusions.
