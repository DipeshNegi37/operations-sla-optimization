# Business Requirements Document (BRD)

## Project
**Operations SLA & Turnaround Time Optimization**

## Company
**NexaVerify** — fictional B2B operations company created for this portfolio case study.

## 1. Business Context
NexaVerify processes business verification and service requests for its clients. The operations function is responsible for completing requests within defined Service Level Agreements (SLAs).

Management has observed increasing turnaround time (TAT) and declining SLA compliance. Existing reporting shows what is happening, but does not clearly explain the operational drivers behind delays.

The Business Analyst is tasked with analyzing operational performance, identifying root causes, and recommending measurable process improvements.

## 2. Problem Statement
Operational performance is declining, with requests taking longer to complete and a growing proportion of requests missing their SLA. Management lacks a consolidated view of the factors contributing to delays, including workload, queue time, processing time, rework, request type, and team performance.

## 3. Business Objective
Identify the primary drivers of high TAT and SLA breaches and provide data-driven recommendations that can improve SLA compliance, reduce avoidable delays, and improve operational capacity.

## 4. Key Business Questions
1. What is the overall SLA compliance rate?
2. How has SLA performance changed over time?
3. What are average, P70, and P90 TAT values?
4. Which request types have the highest TAT and breach rates?
5. Which teams have the strongest and weakest SLA performance?
6. How does workload affect queue time and SLA compliance?
7. How much additional time is associated with rework?
8. Which operational factors are most strongly associated with SLA breaches?
9. Where are the primary process bottlenecks?
10. What actions should management prioritize?

## 5. Scope
### In Scope
- Request volume and trends
- SLA compliance and breaches
- Turnaround time
- Queue and processing time
- Request categories and priorities
- Team and agent workload
- Rework and escalations
- Root-cause analysis
- KPI framework
- Dashboard requirements
- Process improvement recommendations

### Out of Scope
- Revenue forecasting
- Marketing performance
- HR performance evaluation
- Customer acquisition
- Product pricing
- Financial accounting

## 6. Stakeholders
| Stakeholder | Interest / Requirement |
|---|---|
| Operations Head | Overall performance and improvement priorities |
| Operations Managers | Team performance, workload and bottlenecks |
| Team Leads | Operational-level issues and intervention areas |
| Business Head | Business impact and decision support |
| Business Analyst | Requirements, analysis, insights and recommendations |

## 7. Success Criteria
The project will be considered successful when it enables management to:
- Monitor core SLA and TAT KPIs.
- Identify high-risk request categories and operational areas.
- Understand the contribution of queue time, processing time and rework to TAT.
- Compare workload and performance across teams.
- Identify evidence-based root causes of SLA breaches.
- Prioritize actionable process improvements.
- Define measurable targets for post-improvement monitoring.

## 8. Key KPIs
| KPI | Definition |
|---|---|
| SLA Compliance % | Requests completed within defined SLA / total completed requests |
| SLA Breach % | Requests completed after SLA / total completed requests |
| Average TAT | Average elapsed time from request receipt to completion |
| P70 TAT | TAT value below which 70% of requests are completed |
| P90 TAT | TAT value below which 90% of requests are completed |
| Queue Time | Time between request receipt and processing start |
| Processing Time | Time spent actively processing a request |
| Rework Rate | % of requests requiring additional/repeated work |
| Escalation Rate | % of requests escalated |
| Requests per Agent | Number of requests handled per agent |

## 9. Initial Hypotheses
These are hypotheses to be tested, not predetermined conclusions.

- H1: Higher workload is associated with longer queue time and lower SLA compliance.
- H2: Requests requiring rework have higher TAT than requests completed without rework.
- H3: Certain request types contribute disproportionately to SLA breaches.
- H4: SLA performance varies materially across teams.
- H5: Queue time is a major contributor to overall TAT.

## 10. Assumptions
- The dataset is synthetic and created solely for portfolio demonstration.
- SLA thresholds are defined consistently for comparable request categories/priorities.
- Timestamps are recorded consistently.
- Team and agent identifiers are available for operational analysis.

## 11. Constraints
- No real customer or company data will be used.
- Findings will depend on the quality and structure of the synthetic dataset.
- Recommendations will be evaluated using operational metrics rather than real financial statements.

## 12. Deliverables
1. BRD and requirements documentation
2. Stakeholder analysis
3. As-Is and To-Be process maps
4. Synthetic operational dataset
5. Data dictionary
6. SQL analysis
7. Python analysis
8. KPI framework
9. Management dashboard
10. Root-cause analysis
11. Recommendations
12. Business impact assessment
13. Final portfolio case study

## 13. Expected Business Outcome
The final analysis should allow NexaVerify management to move from simply monitoring SLA performance to understanding **why** performance changes and **where** operational intervention can create the greatest improvement.
