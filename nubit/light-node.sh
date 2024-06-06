#!/bin/bash
clear

echo "===========Nubit light node Install Easy======= " && sleep 1

sudo tee /etc/systemd/system/nubit-light.service > /dev/null <<EOF
[Unit]
Description=Nubit light node Daemon
After=network-online.target
[Service]
User=root
WorkingDirectory=/root
ExecStart=/bin/bash -c 'curl -sL1 https://nubit.sh | bash'
Restart=always
StandardOutput=append:/root/nubit-ln.log
StandardError=append:/root/nubit-ln.log
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable nubit-light
sudo systemctl restart nubit-light
sudo tail -f /root/nubit-ln.log | grep -A 4 NAME
