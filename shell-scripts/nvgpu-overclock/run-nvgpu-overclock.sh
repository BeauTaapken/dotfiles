#!/usr/bin/bash


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${SCRIPT_DIR}/bin/activate

source ${SCRIPT_DIR}/../.env

echo $password | sudo -S ${SCRIPT_DIR}/bin/python3 ${SCRIPT_DIR}/overclock.py
