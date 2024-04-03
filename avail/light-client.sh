#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl
sudo tee /etc/systemd/system/avl-light.service > /dev/null <<EOF
[Unit]
Description=Avail light client Daemon
After=network-online.target
[Service]
User=root
WorkingDirectory=/root
ExecStart=curl -sL1 avail.sh | bash
Restart=always
StandardOutput=append:/root/avl-lc.log
StandardError=append:/root/avl-lc.log
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable avl-light
sudo systemctl restart avl-light
sudo tail -f /root/avl-lc.log | grep "public key"