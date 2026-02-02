#!/bin/sh
set -e

echo "[predbat] Docker startup"

echo "Running Predbat inside Add-on"
echo "Your API key is: $SUPERVISOR_TOKEN"
exec python3 /addon/startup.py $SUPERVISOR_TOKEN
