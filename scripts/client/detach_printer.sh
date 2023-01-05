#!/bin/sh

set -x

# detach printer gracefully to prevent duplicate attachment of the same device to another port which makes the device unresponsive
usbip port

usbip list --remote=192.168.31.204

PORT=$( usbip port | grep  '1-1.3' -B2 | head --lines=1 | tr --delete ':' | cut --delimiter=' ' --fields=2)

if [ -d "/c/Windows" ]
then
   PORT="$(usbip port | grep  '04b8:114a' -B1 | head --lines=1 | tr --delete ':' | cut --delimiter=' ' --fields=2)"
fi

usbip detach --port="${PORT}"

sleep 1
usbip port
