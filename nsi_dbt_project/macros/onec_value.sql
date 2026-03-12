{% macro onec_value(field_name) %}
  {{ return('(' ~ field_name ~ ').`Значение`') }}
{% endmacro %}
