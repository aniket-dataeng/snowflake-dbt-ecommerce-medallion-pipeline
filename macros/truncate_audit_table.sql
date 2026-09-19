{% macro truncate_audit_table(table_name="pipeline_audit_log") %}
  
  {% set truncate_sql %}
    truncate table {{ table_name }}
  {% endset %}

  {{ log("Initiating truncation for audit table: " ~ table_name, info=True) }}
  
  {% do run_query(truncate_sql) %}
  
  {{ log("Successfully cleared all rows from " ~ table_name, info=True) }}

{% endmacro %}