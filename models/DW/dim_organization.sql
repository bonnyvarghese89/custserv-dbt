{{ config(
    materialized='table',
    schema='DW'
) }}

SELECT
    hash(org_id) AS organization_sk,
    org_id,
    org_name,
    country,
    created_at,
    CURRENT_TIMESTAMP AS dw_created_at

FROM {{ ref('stg_organizations') }}