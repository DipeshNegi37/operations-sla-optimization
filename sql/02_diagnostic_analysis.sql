-- Diagnostic / root-cause analysis

-- Q11: Request types contributing most to total breaches
SELECT
    request_type,
    COUNT(*) AS total_requests,
    SUM(CASE WHEN sla_status = 'Breached' THEN 1 ELSE 0 END) AS breaches,
    ROUND(100.0 * SUM(CASE WHEN sla_status = 'Breached' THEN 1 ELSE 0 END) / COUNT(*), 2) AS breach_rate_pct,
    ROUND(100.0 * SUM(CASE WHEN sla_status = 'Breached' THEN 1 ELSE 0 END)
          / SUM(SUM(CASE WHEN sla_status = 'Breached' THEN 1 ELSE 0 END)) OVER (), 2) AS share_of_all_breaches_pct
FROM operations_requests
GROUP BY request_type
ORDER BY breaches DESC;

-- Q12: Rework by request type
SELECT
    request_type,
    COUNT(*) AS requests,
    ROUND(100.0 * AVG(CASE WHEN rework_flag = 1 THEN 1.0 ELSE 0.0 END), 2) AS rework_rate_pct,
    ROUND(AVG(CASE WHEN rework_flag = 1 THEN tat_hours END), 2) AS avg_tat_rework,
    ROUND(AVG(CASE WHEN rework_flag = 0 THEN tat_hours END), 2) AS avg_tat_no_rework
FROM operations_requests
GROUP BY request_type
ORDER BY rework_rate_pct DESC;

-- Q13: High-volume team/request-type combinations
SELECT
    team,
    request_type,
    COUNT(*) AS requests,
    ROUND(100.0 * AVG(CASE WHEN sla_status = 'Within SLA' THEN 1.0 ELSE 0.0 END), 2) AS sla_compliance_pct,
    ROUND(AVG(queue_hours), 2) AS avg_queue_hours,
    ROUND(AVG(tat_hours), 2) AS avg_tat_hours
FROM operations_requests
GROUP BY team, request_type
HAVING COUNT(*) >= 5
ORDER BY sla_compliance_pct ASC, requests DESC;

-- Q14: Agents with meaningful volume and weak performance
SELECT
    agent_id,
    team,
    COUNT(*) AS requests,
    ROUND(100.0 * AVG(CASE WHEN sla_status = 'Within SLA' THEN 1.0 ELSE 0.0 END), 2) AS sla_compliance_pct,
    ROUND(AVG(tat_hours), 2) AS avg_tat_hours
FROM operations_requests
GROUP BY agent_id, team
HAVING COUNT(*) >= 5
ORDER BY sla_compliance_pct ASC;

-- Q15: Priority x request type risk matrix
SELECT
    priority,
    request_type,
    COUNT(*) AS requests,
    ROUND(100.0 * AVG(CASE WHEN sla_status = 'Breached' THEN 1.0 ELSE 0.0 END), 2) AS breach_rate_pct,
    ROUND(AVG(tat_hours), 2) AS avg_tat_hours
FROM operations_requests
GROUP BY priority, request_type
ORDER BY breach_rate_pct DESC;

-- Q16: Queue-time bands and SLA outcomes
SELECT
    CASE
        WHEN queue_hours < 2 THEN '<2 hrs'
        WHEN queue_hours < 5 THEN '2–5 hrs'
        WHEN queue_hours < 10 THEN '5–10 hrs'
        ELSE '10+ hrs'
    END AS queue_band,
    COUNT(*) AS requests,
    ROUND(100.0 * AVG(CASE WHEN sla_status = 'Breached' THEN 1.0 ELSE 0.0 END), 2) AS breach_rate_pct,
    ROUND(AVG(tat_hours), 2) AS avg_tat_hours
FROM operations_requests
GROUP BY 1
ORDER BY MIN(queue_hours);

-- Q17: Rework + escalation combination
SELECT
    rework_flag,
    escalation_flag,
    COUNT(*) AS requests,
    ROUND(100.0 * AVG(CASE WHEN sla_status = 'Breached' THEN 1.0 ELSE 0.0 END), 2) AS breach_rate_pct,
    ROUND(AVG(tat_hours), 2) AS avg_tat_hours
FROM operations_requests
GROUP BY rework_flag, escalation_flag
ORDER BY breach_rate_pct DESC;

-- Q18: Identify breach reason concentration
SELECT
    breach_reason,
    COUNT(*) AS breaches,
    ROUND(AVG(queue_hours), 2) AS avg_queue_hours,
    ROUND(AVG(processing_hours), 2) AS avg_processing_hours,
    ROUND(AVG(tat_hours), 2) AS avg_tat_hours
FROM operations_requests
WHERE sla_status = 'Breached'
GROUP BY breach_reason
ORDER BY breaches DESC;

-- Q19: Monthly volume vs SLA performance
SELECT
    DATE_TRUNC('month', request_date) AS month,
    COUNT(*) AS requests,
    ROUND(AVG(queue_hours), 2) AS avg_queue_hours,
    ROUND(AVG(processing_hours), 2) AS avg_processing_hours,
    ROUND(AVG(tat_hours), 2) AS avg_tat_hours,
    ROUND(100.0 * AVG(CASE WHEN sla_status = 'Breached' THEN 1.0 ELSE 0.0 END), 2) AS breach_rate_pct
FROM operations_requests
GROUP BY 1
ORDER BY 1;

-- Q20: Capacity-risk view by team
SELECT
    team,
    COUNT(*) AS requests,
    COUNT(DISTINCT agent_id) AS active_agents,
    ROUND(COUNT(*) * 1.0 / COUNT(DISTINCT agent_id), 2) AS requests_per_agent,
    ROUND(AVG(queue_hours), 2) AS avg_queue_hours,
    ROUND(100.0 * AVG(CASE WHEN sla_status = 'Within SLA' THEN 1.0 ELSE 0.0 END), 2) AS sla_compliance_pct
FROM operations_requests
GROUP BY team
ORDER BY requests_per_agent DESC;
