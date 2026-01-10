#!/bin/sh
set -e

echo "[predbat] Docker startup"

# Prepare config
if [ -z "$(ls -A /config)" ]; then
    echo "/config directory is empty, copying files"
    cp -v /addon/apps.yaml /config/
else
    if [ ! -f /config/apps.yaml ]; then
        cp -v /addon/apps.yaml /config/
    fi
fi

# Block until config is valid
while grep -q "^[^#]*template: True" /config/apps.yaml; do
    echo "#################################################"
    echo "Please update apps.yaml"
    echo "Remove 'template: True'"
    echo "#################################################"
    sleep 30
done

echo "[predbat] Starting Predbat"

# Startup
exec python3 /addon/startup.py
