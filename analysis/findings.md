# Analysis Findings

> **Data note:** The analysis uses the repository's reproducible synthetic dataset generator (`data/generate_dataset.py`, seed 42, 20,000 records). It is not real company data.

## Executive KPI snapshot

| KPI | Result |
|---|---:|
| Requests analyzed | 20,000 |
| SLA attainment | 95.96% |
| SLA breach rate | 4.04% |
| Median TAT | 5.85 hrs |
| P70 TAT | 7.31 hrs |
| P90 TAT | 10.01 hrs |
| Average queue time | 3.22 hrs |
| Average processing time | 2.91 hrs |

## Finding 1 — Queue delay is the largest breach reason

Of the 807 SLA-breached requests, **464 (57.5%)** were classified as Queue Delay. High Processing Time accounted for 222 breaches, Rework for 96, and Combined Factors for 25.

**Business implication:** the first improvement lever should be queue visibility, workload balancing and SLA-risk routing rather than simply increasing individual processing speed.

## Finding 2 — Omega has the weakest SLA performance

Omega records the lowest SLA attainment at **94.64%** and the highest average queue time at **3.73 hrs**. Delta has the strongest SLA attainment at **96.71%**.

The spread is not enormous, so the appropriate BA action is to investigate the operational differences before recommending structural changes.

## Finding 3 — Rework is associated with higher breach risk

Requests with rework have a **7.54% breach rate**, versus **3.59%** for requests without rework.

This is an association in the synthetic data, not proof of causality. The next diagnostic should identify the upstream reasons for rework by request type, team and priority.

## Finding 4 — Business Verification has the highest breach rate

Business Verification has a **4.78% breach rate**, followed by Document Review at 4.40% and Risk Review at 4.39%.

This suggests that complex request types deserve targeted process mapping and first-time-right controls.

## Finding 5 — SLA performance deteriorates later in the six-month period

Monthly breach rate rises from **3.63% in January to 4.29% in June**, while average queue time rises from **2.93 hrs to 3.47 hrs**.

The pattern supports monitoring workload/capacity and queue ageing over time.

## Team comparison

| Team | Cases | SLA attainment | Avg queue | Median TAT |
|---|---:|---:|---:|---:|
| Omega | 3,190 | 94.64% | 3.73 | 6.27 |
| Gamma | 3,594 | 95.60% | 3.49 | 6.12 |
| Beta | 4,801 | 96.04% | 3.08 | 5.74 |
| Alpha | 4,402 | 96.46% | 2.92 | 5.57 |
| Delta | 4,013 | 96.71% | 3.06 | 5.74 |

## Breach reason distribution

| Reason | Breached cases |
|---|---:|
| Queue Delay | 464 |
| High Processing Time | 222 |
| Rework | 96 |
| Combined Factors | 25 |

## Request-type comparison

| Request type | Cases | Breach rate | Median TAT |
|---|---:|---:|---:|
| Business Verification | 3,975 | 4.78% | 6.18 |
| Document Review | 4,390 | 4.40% | 6.00 |
| Risk Review | 1,981 | 4.39% | 6.73 |
| Address Verification | 3,723 | 3.55% | 5.39 |
| Identity Verification | 5,931 | 3.46% | 5.50 |

## Monthly trend

| Month | Cases | Breach rate | Avg queue |
|---|---:|---:|---:|
| 2026-01 | 3,473 | 3.63% | 2.93 |
| 2026-02 | 3,118 | 3.75% | 3.00 |
| 2026-03 | 3,432 | 3.99% | 3.17 |
| 2026-04 | 3,366 | 4.04% | 3.40 |
| 2026-05 | 3,374 | 4.51% | 3.35 |
| 2026-06 | 3,237 | 4.29% | 3.47 |

## BA conclusion

The evidence points to three priority areas: **queue management and workload balancing, rework/first-time-right improvement, and targeted review of higher-risk request types and teams**.

The project deliberately avoids claiming an exact improvement percentage. Any target should be validated through a before/after measurement or controlled pilot.
