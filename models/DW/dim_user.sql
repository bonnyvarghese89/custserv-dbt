{{ config(
    materialized='table',
    schema='DW',
    pre_hook="INSERT INTO main.audit_log VALUES ('dim_user','start', CURRENT_TIMESTAMP)",
    post_hook="INSERT INTO main.audit_log VALUES ('dim_user','end', CURRENT_TIMESTAMP)"
) }}

SELECT
hash(user_id) as user_sk,
*
FROM {{ ref('snp_dim_user') }}