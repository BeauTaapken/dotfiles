#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${SCRIPT_DIR}/.env

VENDOR_ID="2972"
PRODUCT_ID="0077"


echo "=== Running replug-fiio.sh at $(date) ===" >> /tmp/replug-fiio-user.log

env >> /tmp/replug-fiio-user-env.log

# Find the sysfs path for the USB device
DEVICE_PATH=$(for d in /sys/bus/usb/devices/*; do
    if [[ -f "$d/idVendor" && -f "$d/idProduct" ]]; then
        vid=$(cat "$d/idVendor")
        pid=$(cat "$d/idProduct")
        if [[ "$vid" == "$VENDOR_ID" && "$pid" == "$PRODUCT_ID" ]]; then
            echo $(basename "$d")
            break
        fi
    fi
done)

if [ -z "$DEVICE_PATH" ]; then
    echo "FiiO K11 not found (Vendor $VENDOR_ID, Product $PRODUCT_ID)."
    exit 1
fi

echo "Found device at: $DEVICE_PATH"

# Unbind and bind
echo $password | sudo -S bash -c "echo '$DEVICE_PATH' > /sys/bus/usb/drivers/usb/unbind"
sleep 2
echo $password | sudo -S bash -c "echo '$DEVICE_PATH' > /sys/bus/usb/drivers/usb/bind"
echo "Fiio K11 replugged at $(date)"
