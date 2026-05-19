#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${SCRIPT_DIR}/.env

DEVICES=("2972:0077" "046d:c539")

for dev in "${DEVICES[@]}" ; do
    echo "=== Running replug-usb.sh at $(date) ===" >> /tmp/replug-usb-user.log

    VENDOR_ID="${dev%%:*}"
    PRODUCT_ID="${dev##*:}"

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
        echo "Device not found: Vendor $VENDOR_ID, Product $PRODUCT_ID"
        exit 1
    fi

    echo "Found device at: $DEVICE_PATH"

    # Unbind and bind
    echo $password | sudo -S bash -c "echo '$DEVICE_PATH' > /sys/bus/usb/drivers/usb/unbind"
    sleep 2
    echo $password | sudo -S bash -c "echo '$DEVICE_PATH' > /sys/bus/usb/drivers/usb/bind"

    DEVICE_NAME=$(lsusb | grep "${VENDOR_ID}:${PRODUCT_ID}" | cut -d ' ' -f 7-)
    echo "$DEVICE_NAME replugged at $(date)"
done
