#!/bin/bash
set -e
COL='\033[1;32m'
NC='\033[0m' # No Color
echo -e "${COL}Setting up klipper"

mkdir -p /root/extensions/klipper
cat << EOF > /root/extensions/klipper/manifest.json
{
        "title": "Klipper plugin",
        "description": "Requires OctoKlipper plugin"
}
EOF

cat << EOF > /root/extensions/klipper/start.sh
#!/bin/sh
python3 /klipper/klippy/klippy.py /root/printer.cfg -l /tmp/klippy.log -a /tmp/klippy_uds
EOF

cat << EOF > /root/extensions/klipper/kill.sh
#!/bin/sh
pkill -f 'klippy\.py'
EOF
chmod +x /root/extensions/klipper/start.sh
chmod +x /root/extensions/klipper/kill.sh
chmod 777 /root/extensions/klipper/start.sh
chmod 777 /root/extensions/klipper/kill.sh

cat << EOF
${COL}
Klipper installed!
Please place your own klipper config file at /root/printer.cfg
Please kill the app and restart it again to see it in extension settings${NC}
EOF
