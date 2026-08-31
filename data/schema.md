# Data Model & Analysis Schema

## Grain
One row = one completed operational request.

## Core Dimensions
- Date
- Request type
- Priority
- Customer segment
- Channel
- Region
- Team
- Agent

## Operational Measures
- SLA hours
- TAT hours
- Queue hours
- Processing hours
- Rework hours
- Rework flag
- Escalation flag

## Outcome Measures
- SLA status
- Breach reason
- Escalation reason

## Logical Relationships

**Request → Assignment → Queue → Processing → Rework (optional) → Quality Check → Completion**

The timestamps allow TAT to be decomposed into operational stages. The dataset will support analysis at request, agent, team, request-type and time-period levels.

## Planned Analysis Layers

### Executive
SLA compliance, TAT, P90 TAT, volume and trend.

### Operational
Queue time, processing time, workload, rework and escalations.

### Diagnostic
Request type, priority, team, workload bands and breach reasons.

### Improvement
Root causes, recommendations, target KPIs and impact scenario.
