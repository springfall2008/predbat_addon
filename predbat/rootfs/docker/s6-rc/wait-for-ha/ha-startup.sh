#!/command/with-contenv /bin/sh
set -eu

# Ensure variables exist to prevent unbound-variable errors
: "${WAIT_FOR_HA_HOST:=}"
: "${WAIT_FOR_HA_PORT:=}"
: "${WAIT_FOR_HA_INTERVAL:=10}"
: "${WAIT_FOR_HA_MAX_FAILS:=3}"

# If either host or port is missing, disable monitoring
if [ -n "$WAIT_FOR_HA_HOST" ] && [ -n "$WAIT_FOR_HA_PORT" ]; then
    HA_HOST="$WAIT_FOR_HA_HOST"
    HA_PORT="$WAIT_FOR_HA_PORT"
    INTERVAL="$WAIT_FOR_HA_INTERVAL"
    MAX_FAILS="$WAIT_FOR_HA_MAX_FAILS"

    echo "[wait-for-ha] monitoring HA at $HA_HOST:$HA_PORT"

    # Wait until HA exists before entering monitor loop
    until nc -z -w2 "$HA_HOST" "$HA_PORT" >/dev/null 2>&1; do
        echo "[wait-for-ha] HA not ready, retrying in ${INTERVAL}s"
        sleep "$INTERVAL"
    done

    echo "[wait-for-ha] HA available — entering monitor mode"

    FAILS=0
    while :; do
        if nc -z -w2 "$HA_HOST" "$HA_PORT" >/dev/null 2>&1; then
            FAILS=0
        else
            FAILS=$((FAILS + 1))
            echo "[wait-for-ha] HA check failed ($FAILS/$MAX_FAILS)"
            if [ "$FAILS" -ge "$MAX_FAILS" ]; then
                echo "[wait-for-ha] HA disappeared — restarting container"
                /command/s6-linux-init-shutdown -r now
                exit 1
            fi
        fi
        sleep "$INTERVAL"
    done

else
    echo "[wait-for-ha] HA monitoring disabled (env vars not set)"
    s6-svc -wD -d /run/service/wait-for-ha
    #while :; do sleep 3600; done
    #exit 0
fi
