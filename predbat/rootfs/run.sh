echo "Running Predbat inside Add-on"
echo "Your API key is: $SUPERVISOR_TOKEN"
cp /hass.py /config/hass.py
python3 /startup.py $SUPERVISOR_TOKEN
