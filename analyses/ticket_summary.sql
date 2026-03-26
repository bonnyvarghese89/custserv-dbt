SELECT 
    status,
    COUNT(*) AS total_tickets,
    AVG(priority) AS avg_priority
FROM {{ ref('fact_ticket') }}
GROUP BY status