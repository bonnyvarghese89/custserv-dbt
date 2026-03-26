{% test sla_breach(model, column_name) %}

SELECT *
FROM {{ model }}
WHERE {{ column_name }} > 1000

{% endtest %}