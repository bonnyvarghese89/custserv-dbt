{{ config(materialized='view', schema='ODS'
 ) }}
SELECT
    ticket_id,
    requester_id,
    org_id,
    status,
    priority,
    created_at,
    resolved_at
FROM {{ source('stage','tickets') }}