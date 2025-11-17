#!/bin/sh

# Copy program files to /config
if [ -z "$(ls -A /config)" ]; then
    echo "/config directory is empty, copying files"
    cp -v /addon/*.py /addon/apps.yaml /config/
else
    #Check for missing python files
    if [ ! -f /config/hass.py ] || [ ! -f /config/startup.py ] || [ ! -f /config/download.py ] || [ ! -f /config/predbat.py ]; then
    echo "files are missing, copying program files"
    cp -vn /addon/*.py /addon/apps.yaml /config/
    else    
        echo "All files OK"
    fi
fi

# Search for "template: True" in apps.yaml
while true
do
    if grep -q "^[^#]*template: True" /config/apps.yaml; then
        echo "#################################################"
        echo "Please Update apps.yaml"
        echo "Once updated please delete line 13 'template: True'"
        echo "#################################################"
        sleep 30
    else
        echo "modified apps.yaml present"
        break
    fi
done

# Start Predbat

while true
do
    echo "Starting Predbat standalone..."
    echo "starting startup.py..........."
    python3 startup.py
    echo "Predbat crashed. Restarting in 5 seconds..."
    sleep 5
done
