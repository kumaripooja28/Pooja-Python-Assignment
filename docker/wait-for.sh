#!/usr/bin/env bash
# wait-for.sh host:port -- command
set -e

HOSTPORT=$1
shift

host="${HOSTPORT%%:*}"
port="${HOSTPORT##*:}"

>&2 echo "Waiting for $host:$port"
while ! nc -z $host $port; do
  sleep 0.5
  printf '.'
done
>&2 echo "\n$host:$port is available"
exec "$@"
