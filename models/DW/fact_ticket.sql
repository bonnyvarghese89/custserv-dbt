{{ config(
    materialized='incremental',
    schema='DW',
    unique_key='ticket_id'
) }}

WITH source_data AS (

    SELECT *
    FROM {{ ref('int_ticket_enriched') }}

),

max_loaded AS (

    {% if is_incremental() %}
        SELECT MAX(created_at) AS max_created_at
        FROM {{ this }}
    {% else %}
        SELECT NULL AS max_created_at
    {% endif %}

)

SELECT
    s.ticket_id,
    s.user_sk,
    s.organization_sk,
    s.status,
    s.priority,
    s.created_at,
    s.resolved_at,
    s.resolution_hours,
    CURRENT_TIMESTAMP AS dw_created_at

FROM source_data s
LEFT JOIN max_loaded m ON 1=1

{% if is_incremental() %}

    {% if var('load_date', none) is not none %}
        AND s.created_at > '{{ var("load_date") }}'
    {% else %}
        AND (
            m.max_created_at IS NULL
            OR s.created_at > m.max_created_at
        )
    {% endif %}

{% endif %}