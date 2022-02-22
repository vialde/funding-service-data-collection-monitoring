#!/bin/sh

INFLUXDB_CREDENTIALS=$(echo "${VCAP_SERVICES}" | jq '.influxdb[0].credentials.prometheus')

INFLUXDB_READ_URL=$(echo "${INFLUXDB_CREDENTIALS}" | jq '.remote_read[0].url')
INFLUXDB_READ_USERNAME=$(echo "${INFLUXDB_CREDENTIALS}" | jq '.remote_read[0].basic_auth.username')
INFLUXDB_READ_PASSWORD=$(echo "${INFLUXDB_CREDENTIALS}" | jq '.remote_read[0].basic_auth.password')

INFLUXDB_WRITE_URL=$(echo "${INFLUXDB_CREDENTIALS}" | jq '.remote_write[0].url')
INFLUXDB_WRITE_USERNAME=$(echo "${INFLUXDB_CREDENTIALS}" | jq '.remote_write[0].basic_auth.username')
INFLUXDB_WRITE_PASSWORD=$(echo "${INFLUXDB_CREDENTIALS}" | jq '.remote_write[0].basic_auth.password')

envsubst < /etc/prometheus/prometheus_template.yml > /etc/prometheus/prometheus.yml

/bin/prometheus "$@"