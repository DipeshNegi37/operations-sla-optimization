-- Operations SLA & TAT Optimization
-- Baseline KPI analysis

-- Q1: Overall SLA compliance and breach rate
SELECT
    COUNT(*) AS total_requests,
    SUM(CASE WHEN sla_status = 'Within SLA' THEN 1 ELSE 0 END) AS within_sla,
    SUM(CASE WHEN sla_status = 'Breached' THEN 1 ELSE 0 END) AS breached,
    ROUND(100.0 * SUM(CASE WHEN sla_status = 'Within SLA' THEN 1 ELSE 0 END) / COUNT(*), 2) AS sla_compliance_pct,
    ROUND(100.0 * SUM(CASE WHEN sla_status = 'Breached' THEN 1 ELSE 0 END) / COUNT(*), 2) AS sla_breach_pct,
    ROUND(AVG(tat_hours), 2) AS avg_tat_hours
FROM operations_requests;

-- Q2: Monthly SLA and TAT trend
SELECT
    DATE_TRUNC('month', request_date) AS month,
    COUNT(*) AS requests,
    ROUND(100.0 * AVG(CASE WHEN sla_status = 'Within SLA' THEN 1.0 ELSE 0.0 END), 2) AS sla_compliance_pct,
    ROUND(AVG(tat_hours), 2) AS avg_tat_hours,
    ROUND(PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY tat_hours), 2) AS p90_tat_hours
FROM operations_requests
GROUP BY 1
ORDER BY 1;

-- Q3: Performance by request type
SELECT
    request_type,
    COUNT(*) AS requests,
    ROUND(100.0 * AVG(CASE WHEN sla_status = 'Within SLA' THEN 1.0 ELSE 0.0 END), 2) AS sla_compliance_pct,
    ROUND(AVG(tat_hours), 2) AS avg_tat_hours,
    ROUND(PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY tat_hours), 2) AS p90_tat_hours
FROM operations_requests
GROUP BY request_type
ORDER BY sla_compliance_pct ASC;

-- Q4: Performance by priority
SELECT
    priority,
    COUNT(*) AS requests,
    ROUND(100.0 * AVG(CASE WHEN sla_status = 'Within SLA' THEN 1.0 ELSE 0.0 END), 2) AS sla_compliance_pct,
    ROUND(AVG(tat_hours), 2) AS avg_tat_hours
FROM operations_requests
GROUP BY priority
ORDER BY sla_compliance_pct ASC;

-- Q5: Team performance
SELECT
    team,
    COUNT(*) AS requests,
    ROUND(100.0 * AVG(CASE WHEN sla_status = 'Within SLA' THEN 1.0 ELSE 0.0 END), 2) AS sla_compliance_pct,
    ROUND(AVG(tat_hours), 2) AS avg_tat_hours,
    ROUND(AVG(queue_hours), 2) AS avg_queue_hours,
    ROUND(AVG(processing_hours), 2) AS avg_processing_hours
FROM operations_requests
GROUP BY team
ORDER BY sla_compliance_pct ASC;

-- Q6: Queue time vs processing time contribution
SELECT
    ROUND(AVG(queue_hours), 2) AS avg_queue_hours,
    ROUND(AVG(processing_hours), 2) AS avg_processing_hours,
    ROUND(100.0 * AVG(queue_hours) / AVG(tat_hours), 2) AS queue_share_of_tat_pct,
    ROUND(100.0 * AVG(processing_hours) / AVG(tat_hours), 2) AS processing_share_of_tat_pct
FROM operations_requests;

-- Q7: Rework impact
SELECT
    rework_flag,
    COUNT(*) AS requests,
    ROUND(100.0 * AVG(CASE WHEN sla_status = 'Within SLA' THEN 1.0 ELSE 0.0 END), 2) AS sla_compliance_pct,
    ROUND(AVG(tat_hours), 2) AS avg_tat_hours,
    ROUND(AVG(queue_hours), 2) AS avg_queue_hours,
    ROUND(AVG(processing_hours), 2) AS avg_processing_hours
FROM operations_requests
GROUP BY rework_flag
ORDER BY rework_flag;

-- Q8: Escalation impact
SELECT
    escalation_flag,
    COUNT(*) AS requests,
    ROUND(100.0 * AVG(CASE WHEN sla_status = 'Within SLA' THEN 1.0 ELSE 0.0 END), 2) AS sla_compliance_pct,
    ROUND(AVG(tat_hours), 2) AS avg_tat_hours
FROM operations_requests
GROUP BY escalation_flag;

-- Q9: Breach reasons
SELECT
    breach_reason,
    COUNT(*) AS breached_requests,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS share_of_breaches_pct
FROM operations_requests
WHERE sla_status = 'Breached'
GROUP BY breach_reason
ORDER BY breached_requests DESC;

-- Q10: Workload bands and SLA performance
WITH daily_team_load AS (
    SELECT
        request_date,
        team,
        COUNT(*) AS daily_team_requests
    FROM operations_requests
    GROUP BY request_date, team
)
SELECT
    CASE
        WHEN daily_team_requests < 10 THEN 'Low'
        WHEN daily_team_requests < 20 THEN 'Medium'
        ELSE 'High'
    END AS workload_band,
    COUNT(*) AS team_days,
    ROUND(AVG(daily_team_requests), 2) AS avg_requests,
    ROUND(100.0 * AVG(CASE WHEN o.sla_status = 'Within SLA' THEN 1.0 ELSE 0.0 END), 2) AS sla_compliance_pct,
    ROUND(AVG(o.queue_hours), 2) AS avg_queue_hours
FROM daily_team_load d
JOIN operations_requests o
  ON o.request_date = d.request_date
 AND o.team = d.team
GROUP BY 1
ORDER BY 1;
