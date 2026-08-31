# To-Be Process Design

**Proposed flow:** Request Received → Automated Information Validation → Priority & SLA Classification → Capacity-Based Assignment → Processing → Real-Time SLA Risk Check → Controlled Rework → Quality Check → Completion → KPI Monitoring

| Improvement | Current Issue | Future-State Change | Expected KPI Effect |
|---|---|---|---|
| Information validation | Missing information creates rework | Validate required information earlier | Lower rework/TAT |
| SLA-aware prioritization | Risk may not be visible early | Classify by SLA urgency | Higher SLA compliance |
| Capacity-based assignment | Uneven workload | Route using team capacity | Lower queue time |
| SLA risk monitoring | Intervention may happen late | Flag requests approaching threshold | Lower breach rate |
| Root-cause monitoring | Repeated issues hard to identify | Track breach/rework reasons | Continuous improvement |

## Proposed Risk Logic
- **Green:** <60% of SLA consumed
- **Amber:** 60%–80%
- **Red:** >80% while incomplete

These thresholds are proposed for the case study and require stakeholder validation before production use.

## Expected Outcome
Shift from reactive SLA management to proactive workload and SLA-risk management. Actual improvement will be estimated only after baseline analysis and scenario modelling.
