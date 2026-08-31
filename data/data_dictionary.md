# Data Dictionary

## Operations Request Dataset

The dataset will contain synthetic operational records for portfolio analysis. Each row represents one completed service request.

| Field | Type | Description |
|---|---|---|
| request_id | String | Unique request identifier |
| request_date | Date | Date request was received |
| request_type | Category | Type of service request |
| priority | Category | Request priority: Low, Medium, High, Critical |
| customer_segment | Category | Client segment |
| channel | Category | Source channel of request |
| region | Category | Operating region |
| team | Category | Operations team handling request |
| agent_id | String | Assigned operations agent |
| received_at | Timestamp | Request receipt timestamp |
| assigned_at | Timestamp | Timestamp when request was assigned |
| processing_started_at | Timestamp | Timestamp when active processing began |
| completed_at | Timestamp | Timestamp when request was completed |
| sla_hours | Numeric | SLA threshold in hours |
| tat_hours | Numeric | Total elapsed time from receipt to completion |
| queue_hours | Numeric | Time from receipt/assignment to processing start |
| processing_hours | Numeric | Active processing duration |
| rework_flag | Boolean | Whether the request required rework |
| rework_hours | Numeric | Additional time attributed to rework |
| escalation_flag | Boolean | Whether the request was escalated |
| escalation_reason | Category | Reason for escalation, where applicable |
| sla_status | Category | Met or Breached |
| breach_reason | Category | Primary reason for SLA breach, where applicable |

## Derived Metrics

The analysis will derive:

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

The synthetic data will be generated only after the business requirements and process design are defined. Relationships between volume, workload, queue time, rework and SLA outcomes will be realistic but will not be used to predetermine final findings.
