#!/bin/bash

ROOT_DIR="/config"
[[ -d ${ROOT_DIR} ]] || ROOT_DIR="./"

if [[ -n ${SUPERVISOR_TOKEN} ]]; then
  echo "Running Predbat inside Add-on"
  echo "Your API key is: ${SUPERVISOR_TOKEN}"
fi

if [ -f /config/dev ]; then
    echo "Dev mode enabled, not copying hass.py"
else
    [[ ! -f ${ROOT_DIR}/hass.py ]] && cp /hass.py ${ROOT_DIR}/hass.py
fi

## Bootstrap predbat
python3 /bootstrap.py 

## Run
if [[ $? -eq 0 ]]; then
  echo "Starting Predbat..."
  ## Loop if running in HA otherwise let container properties deal with restart
  if [[ -n ${SUPERVISOR_TOKEN} ]]; then
    while true; do
      cd ${ROOT_DIR} && python3 hass.py
      echo "Predbat crashed. Restarting in 5 seconds..."
      sleep 5
    done
  else
    cd ${ROOT_DIR} && python3 hass.py
  fi
else
  echo "Bootstrap failed"
fi
