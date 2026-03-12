#!/usr/bin/env bash
set -euo pipefail

# Source this file: `source ./flink/scripts/dbt_env.sh`
# Optional: create .dbt_env next to this script to override values.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/.dbt_env"
if [[ -f "${ENV_FILE}" ]]; then
  # shellcheck disable=SC1090
  source "${ENV_FILE}"
fi

export KAFKA_BOOTSTRAP="${KAFKA_BOOTSTRAP:-kafka:9092}"
export KAFKA_SECURITY_PROTOCOL="${KAFKA_SECURITY_PROTOCOL:-SASL_PLAINTEXT}"
export KAFKA_SASL_MECHANISM="${KAFKA_SASL_MECHANISM:-PLAIN}"
export KAFKA_USERNAME="${KAFKA_USERNAME:-admin}"
export KAFKA_PASSWORD="${KAFKA_PASSWORD:-}"

export ICEBERG_CATALOG_NAME="${ICEBERG_CATALOG_NAME:-iceberg}"
export ICEBERG_CATALOG_IMPL="${ICEBERG_CATALOG_IMPL:-org.apache.iceberg.rest.RESTCatalog}"
export ICEBERG_URI="${ICEBERG_URI:-http://iceberg-rest:8181}"
export ICEBERG_WAREHOUSE="${ICEBERG_WAREHOUSE:-s3://iceberg/}"
export ICEBERG_IO_IMPL="${ICEBERG_IO_IMPL:-org.apache.iceberg.aws.s3.S3FileIO}"

export S3_ENDPOINT="${S3_ENDPOINT:-http://minio-svc:9000}"
export S3_PATH_STYLE_ACCESS="${S3_PATH_STYLE_ACCESS:-true}"
export S3_ACCESS_KEY="${S3_ACCESS_KEY:-minioadmin}"
export S3_SECRET_KEY="${S3_SECRET_KEY:-}"
export S3_REGION="${S3_REGION:-ru-central1}"

export ICEBERG_PARQUET_CODEC="${ICEBERG_PARQUET_CODEC:-zstd}"

if [[ -z "${KAFKA_PASSWORD}" || -z "${S3_SECRET_KEY}" ]]; then
  echo "[WARN] KAFKA_PASSWORD or S3_SECRET_KEY is empty. Set them before dbt run."
fi

echo "[OK] dbt env loaded: KAFKA_BOOTSTRAP=${KAFKA_BOOTSTRAP}, ICEBERG_URI=${ICEBERG_URI}, S3_ENDPOINT=${S3_ENDPOINT}"
