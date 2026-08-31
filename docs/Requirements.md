# Requirements

## Functional Requirements

| ID | Requirement | Priority |
|---|---|---|
| FR-01 | Calculate SLA compliance and breach rates. | Must Have |
| FR-02 | Calculate average, P70 and P90 TAT. | Must Have |
| FR-03 | Analyze performance by request type and priority. | Must Have |
| FR-04 | Compare performance across teams. | Must Have |
| FR-05 | Analyze workload by team and agent. | Should Have |
| FR-06 | Separate queue time from processing time. | Must Have |
| FR-07 | Quantify rework impact on TAT and SLA. | Must Have |
| FR-08 | Identify major contributors to SLA breaches. | Must Have |
| FR-09 | Provide time-based performance trends. | Should Have |
| FR-10 | Produce evidence-based recommendations. | Must Have |
| FR-11 | Define post-improvement monitoring KPIs. | Should Have |

## Acceptance Principles
- KPI calculations must reconcile to source records.
- TAT must use consistent timestamp logic.
- Comparisons must include sufficient volume context.
- Root causes must be supported by quantitative evidence.
- Every recommendation must link to a finding and measurable KPI.

## Non-Functional Requirements
- **Usability:** Dashboard should be understandable to non-technical management.
- **Consistency:** KPI definitions must be documented and used consistently.
- **Traceability:** Findings should be traceable to data and analysis.
- **Reproducibility:** SQL/Python analysis should be repeatable from the documented dataset.
- **Privacy:** No real customer or confidential company data will be used.
