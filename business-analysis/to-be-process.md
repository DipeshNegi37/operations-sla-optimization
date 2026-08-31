# To-Be Process Design

## Objective
Design a future-state process that reduces avoidable queue time and rework while enabling earlier intervention on requests at risk of breaching SLA.

## Proposed Future-State Flow

**Request Received → Automated Information Validation → Priority & SLA Classification → Capacity-Based Assignment → Processing → Real-Time SLA Risk Check → Rework Prevention / Controlled Rework → Quality Check → Completion → KPI Monitoring**

## Proposed Improvements

| Improvement | Current-State Issue | Future-State Change | Expected KPI Effect |
|---|---|---|---|
| Automated information validation | Missing information creates rework | Validate required fields before assignment | Lower rework rate, lower TAT |
| SLA-aware prioritization | Risk may not be visible early | Classify requests by SLA urgency | Higher SLA compliance |
| Capacity-based assignment | Uneven workload | Route work using team capacity | Lower queue time |
| SLA risk monitoring | Intervention can happen late | Flag requests approaching SLA threshold | Lower breach rate |
| Root-cause monitoring | Repeated issues are hard to identify | Track breach and rework reasons | Continuous improvement |

## Proposed SLA Risk Logic

- **Green:** Less than 60% of SLA consumed
- **Amber:** 60%–80% consumed
- **Red:** More than 80% consumed and still incomplete

These thresholds are proposed for the case study and would require stakeholder validation before production use.

## Expected Future-State Outcome

The future-state design aims to shift operations from **reactive SLA management** to **proactive workload and SLA-risk management**.

The actual improvement percentage will not be assumed. It will be estimated after baseline analysis and scenario modelling.
