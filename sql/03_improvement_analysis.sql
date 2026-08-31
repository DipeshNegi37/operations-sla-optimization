-- Improvement and decision-support analysis

-- Q21: Baseline KPI table for improvement tracking
SELECT
    COUNT(*) AS baseline_requests,
    ROUND(100.0 * AVG(CASE WHEN sla_status = 'Within SLA' THEN 1.0 ELSE 0.0 END), 2) AS baseline_sla_compliance_pct,
    ROUND(AVG(tat_hours), 2) AS baseline_avg_tat_hours,
    ROUND(PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY tat_hours), 2) AS baseline_p90_tat_hours,
    ROUND(100.0 * AVG(CASE WHEN rework_flag = 1 THEN 1.0 ELSE 0.0 END), 2) AS baseline_rework_rate_pct,
    ROUND(100.0 * AVG(CASE WHEN escalation_flag = 1 THEN 1.0 ELSE 0.0 END), 2) AS baseline_escalation_rate_pct
FROM operations_requests;

-- Q22: Identify high-impact segments for prioritization
SELECT
    request_type,
    priority,
    COUNT(*) AS requests,
    SUM(CASE WHEN sla_status = 'Breached' THEN 1 ELSE 0 END) AS breaches,
    ROUND(100.0 * AVG(CASE WHEN sla_status = 'Breached' THEN 1.0 ELSE 0.0 END), 2) AS breach_rate_pct,
    ROUND(AVG(queue_hours), 2) AS avg_queue_hours,
    ROUND(AVG(tat_hours), 2) AS avg_tat_hours
FROM operations_requests
GROUP BY request_type, priority
HAVING COUNT(*) >= 5
ORDER BY breaches DESC, breach_rate_pct DESC;

-- Q23: Estimate potential impact of reducing queue time by 20%
WITH baseline AS (
    SELECT
        AVG(tat_hours) AS avg_tat,
        AVG(queue_hours) AS avg_queue
    FROM operations_requests
)
SELECT
    ROUND(avg_tat, 2) AS baseline_avg_tat_hours,
    ROUND(avg_queue, 2) AS baseline_avg_queue_hours,
    ROUND(avg_queue * 0.20, 2) AS queue_hours_reduction,
    ROUND(avg_tat - (avg_queue * 0.20), 2) AS modeled_avg_tat_hours
FROM baseline;

-- Q24: Estimate impact of eliminating a portion of rework time
WITH baseline AS (
    SELECT
        AVG(tat_hours) AS avg_tat,
        AVG(CASE WHEN rework_flag = 1 THEN rework_hours ELSE 0 END) AS avg_rework_hours
    FROM operations_requests
)
SELECT
    ROUND(avg_tat, 2) AS baseline_avg_tat_hours,
    ROUND(avg_rework_hours, 2) AS avg_rework_hours_per_request,
    ROUND(avg_rework_hours * 0.30, 2) AS modeled_hours_saved_per_request,
    ROUND(avg_tat - avg_rework_hours * 0.30, 2) AS modeled_avg_tat_hours
FROM baseline;

-- Q25: Prioritize teams using volume, SLA and queue time
SELECT
    team,
    COUNT(*) AS requests,
    ROUND(100.0 * AVG(CASE WHEN sla_status = 'Breached' THEN 1.0 ELSE 0.0 END), 2) AS breach_rate_pct,
    ROUND(AVG(queue_hours), 2) AS avg_queue_hours,
    ROUND(AVG(tat_hours), 2) AS avg_tat_hours,
    CASE
        WHEN AVG(CASE WHEN sla_status = 'Breached' THEN 1.0 ELSE 0.0 END) >= 0.20
             AND AVG(queue_hours) >= 8 THEN 'High Priority'
        WHEN AVG(CASE WHEN sla_status = 'Breached' THEN 1.0 ELSE 0.0 END) >= 0.15
             OR AVG(queue_hours) >= 6 THEN 'Medium Priority'
        ELSE 'Monitor'
    END AS intervention_priority
FROM operations_requests
GROUP BY team
ORDER BY
    CASE intervention_priority
        WHEN 'High Priority' THEN 1
        WHEN 'Medium Priority' THEN 2
        ELSE 3
    END,
    breach_rate_pct DESC;
