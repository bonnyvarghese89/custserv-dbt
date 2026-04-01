{{ config(materialized='view', schema='ODS') }}

SELECT
    user_id,
    name,
    email,
    role,
    created_at
FROM {{ source('stage','users') }}