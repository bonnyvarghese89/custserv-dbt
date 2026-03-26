{% snapshot snp_dim_user %}

{{
    config(
        target_schema='snapshots',
        unique_key='user_id',
        strategy='check',
        check_cols=['name','email','role']
    )
}}

SELECT
    user_id,
    name,
    email,
    role,
    created_at
FROM {{ source('stage','users') }}

{% endsnapshot %}