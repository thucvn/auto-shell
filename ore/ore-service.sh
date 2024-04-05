#!/bin/bash
clear

echo "===========Ore Service======= " && sleep 1

sudo tee /etc/systemd/system/ored.service > /dev/null <<EOF
[Unit]
Description=Ore service
After=network-online.target
[Service]
User=root
WorkingDirectory=/root
ExecStart=/bin/bash -c 'ore --rpc https://api.mainnet-beta.solana.com --keypair ~/.config/solana/id.json --priority-fee 1 mine --threads 4'
Restart=always
StandardOutput=append:/root/ore.log
StandardError=append:/root/ore.log
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable ored
sudo systemctl restart ored


echo "Completed"