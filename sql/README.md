# SQL Analysis

The SQL layer answers the project's business questions in three stages:

1. **Baseline KPIs** — establishes SLA, TAT, workload and operational performance.
2. **Diagnostic analysis** — investigates request types, teams, workload, queue time, rework, escalation and breach drivers.
3. **Improvement analysis** — creates a baseline for monitoring and models potential operational improvements.

## Business Questions Covered

- Overall SLA compliance and breach rate
- Average, P70 and P90 TAT
- Monthly performance trends
- Request-type and priority performance
- Team performance
- Queue vs processing time
- Rework and escalation impact
- Breach reason concentration
- Workload and capacity risk
- High-impact segments
- Improvement scenarios

## SQL Dialect
The queries use PostgreSQL-style syntax, including `DATE_TRUNC` and `PERCENTILE_CONT`.

## Important Note
Improvement scenarios are **modeled scenarios**, not actual realized savings or guaranteed results. Final recommendations will be based on the observed analysis and clearly labeled assumptions.
