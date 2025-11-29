echo "Running Predbat inside Add-on"
echo "Your API key is: $SUPERVISOR_TOKEN"
if [ -f /config/hass.py ]; then
    echo "Hass already installed not copying it"
else
    cp /hass.py /config/hass.py
fi
python3 /startup.py $SUPERVISOR_TOKEN
