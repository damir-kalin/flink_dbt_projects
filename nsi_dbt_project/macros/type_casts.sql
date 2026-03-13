{% macro bool_to_tinyint(field_name) %}
  {{ return("CASE WHEN LOWER(TRIM(CAST(" ~ field_name ~ " AS STRING))) IN ('true','1') THEN 1 WHEN LOWER(TRIM(CAST(" ~ field_name ~ " AS STRING))) IN ('false','0') THEN 0 ELSE NULL END") }}
{% endmacro %}

{% macro bool_to_boolean(field_name) %}
  {{ return("CASE WHEN LOWER(TRIM(CAST(" ~ field_name ~ " AS STRING))) IN ('true','1') THEN TRUE WHEN LOWER(TRIM(CAST(" ~ field_name ~ " AS STRING))) IN ('false','0') THEN FALSE ELSE NULL END") }}
{% endmacro %}

{% macro safe_timestamp3(field_name) %}
  {{ return("CASE WHEN " ~ field_name ~ " IS NULL OR TRIM(CAST(" ~ field_name ~ " AS STRING)) = '' THEN NULL ELSE TRY_CAST(REPLACE(CAST(" ~ field_name ~ " AS STRING), 'T', ' ') AS TIMESTAMP(3)) END") }}
{% endmacro %}

{% macro empty_to_null(field_name) %}
  {{ return("NULLIF(TRIM(CAST(" ~ field_name ~ " AS STRING)), '')") }}
{% endmacro %}
