# Operations SLA Optimization

**Business Analyst portfolio project | SQL + Python + Requirements Analysis**

## Business problem

Operational teams need to meet SLA commitments while controlling queue time, turnaround time, rework and escalations. This project demonstrates an end-to-end BA approach for diagnosing SLA performance and translating data into operational recommendations.

## Objective

Identify the main drivers of SLA breaches and operational delay, compare team/process performance, and recommend practical interventions supported by data.

## Dataset

The project uses a **reproducible synthetic dataset of 20,000 operational requests** covering January–June 2026. The generator is seeded (`42`) so the analysis can be reproduced.

This is **synthetic portfolio data**, not confidential or employer data.

## Workflow

**Business problem → stakeholder analysis → requirements → 25 SQL questions → Python analysis → findings → recommendations**

## Repository structure

```text
operations-sla-optimization/
├── README.md
├── business-analysis/
│   ├── stakeholder-analysis.md
│   └── requirements.md
├── data/
│   ├── generate_dataset.py
│   ├── operations_requests_sample.csv
│   ├── data_dictionary.md
│   └── schema.md
├── sql/
│   ├── 01_baseline_kpis.sql
│   ├── 02_diagnostic_analysis.sql
│   ├── 03_improvement_analysis.sql
│   └── README.md
├── python/
│   ├── sla_analysis.py
│   └── README.md
├── analysis/
│   ├── findings.md
│   └── recommendations.md
└── visualizations/
```

## Key findings

- **95.96% SLA attainment** across 20,000 requests.
- **4.04% breach rate**; 807 requests breached SLA.
- **Queue Delay** is the largest breach reason, accounting for 464 breaches.
- **Omega** has the lowest team SLA attainment at 94.64% and highest average queue time at 3.73 hours.
- Requests with rework show a **7.54% breach rate** versus 3.59% without rework.
- **Business Verification** has the highest request-type breach rate at 4.78%.
- Monthly breach rate rises from 3.63% in January to 4.29% in June.

## Core KPIs

| KPI | Result |
|---|---:|
| Requests | 20,000 |
| SLA attainment | 95.96% |
| SLA breach rate | 4.04% |
| Median TAT | 5.85 hrs |
| P70 TAT | 7.31 hrs |
| P90 TAT | 10.01 hrs |
| Avg. queue time | 3.22 hrs |
| Avg. processing time | 2.91 hrs |

## Recommendations

1. Introduce SLA-risk queue ageing and routing.
2. Monitor capacity versus demand by team.
3. Reduce rework with first-time-right controls.
4. Target complex request types for process mapping.
5. Manage the P70/P90 long tail rather than relying only on averages.

## BA skills demonstrated

Business Analysis · Stakeholder Analysis · Requirements Gathering · SQL · Python · KPI Analysis · Root-Cause Analysis · Process Improvement · Data Visualization · Operational Reporting · Business Recommendations

## Portfolio positioning

### LinkedIn project description

**Operations SLA Optimization | SQL + Python + Business Analysis**

Built an end-to-end Business Analyst portfolio project to diagnose SLA performance across 20,000 synthetic operational requests. Defined stakeholder requirements, converted business problems into 25 SQL questions, analyzed SLA breaches and turnaround time using Python, and translated the findings into prioritized operational recommendations.

The analysis covers SLA attainment, median/P70/P90 TAT, queue time, team performance, rework, breach reasons, request types and monthly trends.

The project demonstrates the full BA workflow: **business problem → requirements → analytical questions → data analysis → root cause → recommendation**.

### Resume bullet

Built an end-to-end Operations SLA analysis using SQL and Python across 20,000 synthetic requests, diagnosing SLA breaches through TAT, queue-time, team, rework and request-type analysis and translating findings into prioritized process-improvement recommendations.

## Important methodology note

The findings above are generated from the project's deterministic synthetic dataset. They should be presented as **portfolio analysis**, not as claims about a real employer's operational performance.
