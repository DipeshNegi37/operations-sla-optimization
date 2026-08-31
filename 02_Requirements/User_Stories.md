# User Stories & Acceptance Criteria

## Project: Operations SLA & Turnaround Time Optimization

### US-01 — Monitor SLA Performance
**As an Operations Head,** I want to monitor SLA compliance so that I can identify whether service performance is meeting expectations.

**Acceptance Criteria**
- Total requests are displayed.
- SLA-compliant requests are displayed.
- SLA breaches are displayed.
- SLA compliance percentage is calculated consistently.

### US-02 — Identify High-Risk Request Types
**As an Operations Manager,** I want to compare SLA performance by request type so that I can prioritize problematic categories.

**Acceptance Criteria**
- Request types can be compared by volume.
- SLA compliance is shown for each request type.
- Average and P90 TAT are shown for each request type.

### US-03 — Compare Team Performance
**As an Operations Manager,** I want to compare teams so that I can identify performance gaps and investigate operational causes.

**Acceptance Criteria**
- Teams can be ranked by SLA compliance.
- TAT is available for each team.
- Workload is shown alongside performance.

### US-04 — Investigate Delays
**As a Team Lead,** I want to distinguish queue time from processing time so that I can determine where delays occur.

**Acceptance Criteria**
- Queue time is calculated.
- Processing time is calculated.
- Both can be compared by team and request type.

### US-05 — Understand Rework Impact
**As a Team Lead,** I want to compare reworked and non-reworked requests so that I can understand whether rework is contributing to SLA breaches.

**Acceptance Criteria**
- Rework and non-rework populations are separately measurable.
- TAT and SLA compliance are compared between populations.

### US-06 — Identify Root Causes
**As a Business Head,** I want the analysis to identify the main contributors to SLA breaches so that I can make informed operational decisions.

**Acceptance Criteria**
- Major drivers are quantified.
- Findings are supported by data.
- Recommendations are linked to findings.

### US-07 — Track Improvement
**As an Operations Head,** I want to monitor KPIs after process changes so that I can determine whether interventions are working.

**Acceptance Criteria**
- Baseline KPIs are documented.
- Target KPIs can be defined.
- Post-change performance can be compared with baseline.
