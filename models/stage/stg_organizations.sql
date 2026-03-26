{{ config(materialized='view', schema='ODS') }}

SELECT
    org_id,
    org_name,
    country,
    created_at
FROM {{ source('stage','organizations') }}