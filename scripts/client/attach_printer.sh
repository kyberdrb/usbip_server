#!/bin/sh

set -x

SCRIPT_DIR="$(dirname "$(readlink --canonicalize "$0")")"

# Reset any local changes to make the updating seamless
cd "${SCRIPT_DIR}"
git reset --hard HEAD
# Try passing the script dir to 'git' to ommit the 'cd' command
# git -C "${SCRIPT_DIR}" reset --hard HEAD

# Sources:
# - https://duckduckgo.com/?q=how+reset+changes+to+repo+git+head&ia=web
# - https://devconnected.com/how-to-git-reset-to-head/

# Update the project/repo
git pull
# Try passing the script dir to 'git' to ommit the 'cd' command
git pull
# git -C "${SCRIPT_DIR}" pull

# Source: 'man git-pull'

# detach printer gracefully to prevent duplicate attachment of the same device to another port which makes the device unresponsive

"${SCRIPT_DIR}/detach_printer.sh"

# attach printer gracefully
usbip list --remote=192.168.31.204
usbip port
echo ""
usbip attach --remote=192.168.31.204 --busid=1-1.3

sleep 1
usbip list --remote=192.168.31.204
usbip port

# attach printer violently
# TODO when the attaching of the printer fails, try to force-attach it remotely
#echo The password is ...? :)
#ssh rpi@192.168.31.204 'systemctl reload usbip-printer.service'
# Sources:
#    - https://duckduckgo.com/?q=execute+one+command+ssh&ia=web
#    - https://duckduckgo.com/?q=ssh+automatically+enter+password&ia=web
#    - https://duckduckgo.com/?q=windows+ssh+login+without+password&ia=web
#    - https://duckduckgo.com/?q=remotely+reload+systemd+service&ia=web
#    - https://sleeplessbeastie.eu/2021/03/03/how-to-manage-systemd-services-remotely/

#usbip list --remote=192.168.31.204
#usbip attach --remote=192.168.31.204 --busid=1-1.3

# TODO when even the force-attaching failed, print to terminal 
#  that the device is physically disconnected from the USB/IP server 
#  or connected to different port
