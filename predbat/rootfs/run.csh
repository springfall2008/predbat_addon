#!/bin/csh -f

while (1)
    echo "Starting Predbat standalone..."
    python3 startup.py
    echo "Predbat crashed. Restarting in 5 seconds..."
    sleep 5
end
