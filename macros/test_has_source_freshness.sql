{% macro test_has_source_freshness(model = none) %}

  {%- set nodes_list = graph.sources.values() -%}
  {%- set all_fresh = "select 1 where 1=0 "-%}

  {{log("Hola desde adentro")}}

  {%- for node in nodes_list -%}
    {% set node_full_name = node.database ~ '.' ~ node.schema ~ '.' ~ node.name %}

    {{ log("Checking for node" ~ node_full_name ) }}

    {%- if model is none or node_full_name | trim  == model | trim  %}  # Check for all sources or specific source

      {%- if (node.freshness.warn_after.count is none and node.freshness.error_after.count is none) %}
        {{ log("There's some freshness missing for node: " ~ node_full_name ) }}
        {%- set all_fresh = "select 1 where 1=1" -%}

        {{ return(all_fresh) }}

        {%- break %}

      {%- endif -%}
    {%- endif %}
  {%- endfor -%}

  {{ return(all_fresh) }}

{% endmacro %}


