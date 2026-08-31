# As-Is Process Analysis

**Current flow:** Request Received → Queue → Assignment → Information Check → Processing → Rework (if required) → Quality Check → Completion → Escalation (if SLA risk/breach)

| Step | Activity | Potential Issue |
|---|---|---|
| 1 | Request received | Volume fluctuates |
| 2 | Request enters queue | Waiting time may increase TAT |
| 3 | Request assigned | Workload may be uneven |
| 4 | Information checked | Missing information may create rework |
| 5 | Request processed | Complexity varies by request type |
| 6 | Rework if required | Additional handling increases TAT |
| 7 | Quality check | Additional delay possible |
| 8 | Completion | Determines SLA outcome |
| 9 | Escalation | Intervention may occur late |

## Pain Points to Test
- Queue delay
- Uneven workload
- Rework
- Request complexity
- Late SLA intervention

These are **investigation areas, not confirmed root causes**. The dataset and analysis will determine which factors materially affect performance.
