# As-Is Process Analysis

## Current-State Process

NexaVerify's current request-processing flow is represented as:

**Request Received → Initial Queue → Assignment → Information Check → Processing → Rework (if required) → Quality Check → Completion → Escalation (if SLA risk/breach)**

## Process Steps

| Step | Activity | Primary Owner | Potential Issue |
|---|---|---|---|
| 1 | Request received | System / Operations | Volume may fluctuate significantly |
| 2 | Request enters queue | Operations | Requests may wait before assignment |
| 3 | Request assigned | Team Lead / System | Workload may not be balanced |
| 4 | Information checked | Operations Agent | Missing information can create rework |
| 5 | Request processed | Operations Agent | Processing time varies by request type |
| 6 | Rework performed if needed | Operations Agent | Additional handling increases TAT |
| 7 | Quality check | QC / Operations | Additional delay possible |
| 8 | Request completed | Operations | Completion determines SLA outcome |
| 9 | Escalation when required | Team Lead / Manager | Often occurs after risk becomes visible |

## Current-State Pain Points to Investigate

### 1. Queue Delay
Requests may spend significant time waiting before processing begins. This can increase TAT without increasing the actual work required.

### 2. Uneven Workload
Requests may not be distributed evenly across teams or agents, potentially creating avoidable bottlenecks.

### 3. Rework
Requests with incomplete or incorrect information may require repeated handling, increasing processing effort and TAT.

### 4. Request Complexity
Different request types may have materially different processing requirements but may currently be evaluated using broad performance metrics.

### 5. Late SLA Intervention
If SLA risk is identified only after a request is already delayed, managers have fewer opportunities to intervene proactively.

## Current-State Business Risks

- Increased SLA breaches
- Higher operational workload
- Reduced available capacity
- More escalations
- Longer customer/client wait times
- Difficulty identifying the true source of delays

## Analysis Required

The dataset will be used to test whether these suspected issues are material drivers of SLA performance. No pain point will be treated as a confirmed root cause until supported by analysis.
