{{ config(
    materialized='ephemeral'
) }}

WITH tickets AS (

    SELECT *
    FROM {{ ref('stg_tickets') }}

),

users AS (

    SELECT user_sk, user_id
    FROM {{ ref('dim_user') }}

),

orgs AS (

    SELECT organization_sk, org_id
    FROM {{ ref('dim_organization') }}

)

SELECT

    t.ticket_id,
    u.user_sk,
    o.organization_sk,
    t.status,
    t.priority,
    t.created_at,
    t.resolved_at,

    date_diff('hour', t.created_at, t.resolved_at) AS resolution_hours

FROM tickets t

LEFT JOIN users u
    ON t.requester_id = u.user_id

LEFT JOIN orgs o
    ON t.org_id = o.org_id