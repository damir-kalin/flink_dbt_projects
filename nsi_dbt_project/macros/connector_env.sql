{% macro kafka_bootstrap_servers() %}
  {{ return(env_var('KAFKA_BOOTSTRAP', 'kafka:9092')) }}
{% endmacro %}

{% macro kafka_security_protocol() %}
  {{ return(env_var('KAFKA_SECURITY_PROTOCOL', 'SASL_PLAINTEXT')) }}
{% endmacro %}

{% macro kafka_sasl_mechanism() %}
  {{ return(env_var('KAFKA_SASL_MECHANISM', 'PLAIN')) }}
{% endmacro %}

{% macro kafka_sasl_jaas_config() %}
  {{ return('org.apache.flink.kafka.shaded.org.apache.kafka.common.security.plain.PlainLoginModule required username="' ~ env_var('KAFKA_USERNAME', 'admin') ~ '" password="' ~ env_var('KAFKA_PASSWORD') ~ '";') }}
{% endmacro %}

{% macro iceberg_connector_properties(catalog_database) %}
  {% set raw_s3_secret = env_var('S3_SECRET_KEY', 'Q1w2e3r+') %}
  {% set effective_s3_secret = 'Q1w2e3r+' if raw_s3_secret == 'minioadmin' else raw_s3_secret %}
  {{ return({
    'connector': 'iceberg',
    'format-version': env_var('ICEBERG_FORMAT_VERSION', '2'),
    'partitioning': env_var('ICEBERG_PARTITIONING', 'month(load_dttm)'),
    'catalog-name': env_var('ICEBERG_CATALOG_NAME', 'iceberg'),
    'catalog-impl': env_var('ICEBERG_CATALOG_IMPL', 'org.apache.iceberg.rest.RESTCatalog'),
    'uri': env_var('ICEBERG_URI', 'http://iceberg-rest:8181'),
    'warehouse': env_var('ICEBERG_WAREHOUSE', 's3://iceberg/'),
    'io-impl': env_var('ICEBERG_IO_IMPL', 'org.apache.iceberg.aws.s3.S3FileIO'),
    's3.endpoint': env_var('S3_ENDPOINT', 'http://minio-svc:9000'),
    's3.path-style-access': env_var('S3_PATH_STYLE_ACCESS', 'true'),
    's3.access-key-id': env_var('S3_ACCESS_KEY', 'minioadmin'),
    's3.secret-access-key': effective_s3_secret,
    'client.region': env_var('S3_REGION', 'ru-central1'),
    'catalog-database': catalog_database,
    'write.format.default': env_var('ICEBERG_WRITE_FORMAT_DEFAULT', 'parquet'),
    'write.parquet.compression-codec': env_var('ICEBERG_PARQUET_CODEC', 'zstd'),
    'write.target-file-size-bytes': env_var('ICEBERG_TARGET_FILE_SIZE_BYTES', '536870912'),
    'write.metadata.delete-after-commit.enabled': env_var('ICEBERG_DELETE_OLD_METADATA', 'true'),
    'write.metadata.previous-versions-max': env_var('ICEBERG_PREVIOUS_VERSIONS_MAX', '20')
  }) }}
{% endmacro %}
