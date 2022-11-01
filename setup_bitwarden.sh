#!/bin/bash

isSuccess(){
    if [ $? -eq 0 ]; then
        echo "[Scripts] Success!"
    else
        echo "[Scripts] Failed!"
        exit 999
    fi
}

echo "[Scripts] Start setup bitwarden...."
echo "[Scripts] Install vaultwarden...."
sudo pacman -S vaultwarden vaultwarden-web bitwarden --noconfirm
isSuccess

echo "[Scripts] Clone database...."
git clone git@jihulab.com:ambition-echo/bitwarden.git /home/$USER/.config/vaultwarden
isSuccess
sudo mkdir /var/lib/vaultwarden
sudo chown vaultwarden /var/lib/vaultwarden
sudo chgrp vaultwarden /var/lib/vaultwarden
sudo chmod 777 /var/lib/vaultwarden/
isSuccess
sudo usermod -a -G vaultwarden $USER
isSuccess

echo "[Scripts] Edit service file...."
sudo sed -i "s/AmbientCapabilities=/#AmbientCapabilities=/g" /usr/lib/systemd/system/vaultwarden.service
sudo sed -i "s/CapabilityBoundingSet=/#CapabilityBoundingSet=/g" /usr/lib/systemd/system/vaultwarden.service
isSuccess

echo "[Scripts] Edit .env file...."
sudo sed -i "s/# WEB_VAULT_FOLDER=.*/WEB_VAULT_FOLDER=\/usr\/share\/webapps\/vaultwarden-web/g" /etc/vaultwarden.env
sudo sed -i "s/WEB_VAULT_ENABLED=.*/WEB_VAULT_ENABLED=true/g" /etc/vaultwarden.env
sudo sed -i "s/# ROCKET_PORT=.*/ROCKET_PORT=3349/g" /etc/vaultwarden.env
sudo sed -i "s/# ROCKET_ADDRESS=.*/ROCKET_ADDRESS=0.0.0.0/g" /etc/vaultwarden.env
sudo sed -i "s/# WEBSOCKET_ENABLED=.*/WEBSOCKET_ENABLED=true/g" /etc/vaultwarden.env
sudo sed -i "s/# WEBSOCKET_ADDRESS=.*/WEBSOCKET_ADDRESS=0.0.0.0/g" /etc/vaultwarden.env
sudo sed -i "s/# WEBSOCKET_PORT=.*/WEBSOCKET_PORT=3012/g" /etc/vaultwarden.env
isSuccess

echo "[Scripts] Start service...."
sudo systemctl enable vaultwarden --now
isSuccess

echo "[Scripts] Copy db file"
sudo cp /home/$USER/.config/vaultwarden/db* /var/lib/vaultwarden/
sudo chown vaultwarden /var/lib/vaultwarden/*
sudo chgrp vaultwarden /var/lib/vaultwarden/*
sudo chmod 777 /var/lib/vaultwarden/*
isSuccess

echo "[Scripts] Set Cron backup"
mkdir /home/$USER/.config/bitwarden
isSuccess
sudo pacman -S cronie --noconfirm
isSuccess
cp $(pwd)/bitwarden/backup.sh /home/$USER/.config/bitwarden/backup.sh
isSuccess
crontab -l > ~/conf && echo "0 * * * * bash /home/$USER/.config/bitwarden/backup.sh" >> ~/conf && crontab ~/conf && rm -f ~/conf
isSuccess
sudo systemctl enable cronie --now
isSuccess