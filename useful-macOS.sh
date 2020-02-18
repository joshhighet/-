#speedtest over schelle
yes | pv | ssh user@dest "cat >/dev/null"
#view all USB interfaces
osqueryi --json 'SELECT * FROM usb_devices WHERE removable' | jq
#view tha listening ports
sudo lsof -iTCP -sTCP:LISTEN -n -P
