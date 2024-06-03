{{
    config(
        enabled=true,
        severity='warn',
        tags = ['finance']
    )
}}


{{ test_has_source_freshness() }}