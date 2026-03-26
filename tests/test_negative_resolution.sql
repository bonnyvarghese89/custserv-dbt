SELECT *
FROM {{ ref('fact_ticket') }}
WHERE resolution_hours < 0