#!/bin/bash

isSuccess(){
    if [ $? -eq 0 ]; then
        echo "[Scripts] Success!"
    else
        echo "[Scripts] Failed!"
        exit 999
    fi
}

echo "[Scripts] Start setup wezterm...."
echo "[Scripts] Install wezterm...."
sudo pacman -S wezterm unzip --noconfirm
isSuccess

echo "[Scripts] mkdir ~/.config/wezterm...."
mkdir -p /home/$USER/.config/wezterm
isSuccess

echo "[Scripts] Copy $(pwd)/wezterm/wezterm.lua...."
cp $(pwd)/wezterm/wezterm.lua /home/$USER/.config/wezterm/wezterm.lua
isSuccess

echo "[Scripts] Install oh-my-posh...."
sudo wget -e "https_proxy=http://127.0.0.1:7890" https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
isSuccess

echo "[Scripts] Download oh-my-posh themes...."
mkdir /home/$USER/.config/poshthemes
isSuccess
wget -e "https_proxy=http://127.0.0.1:7890" https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O /home/$USER/.config/poshthemes/themes.zip
isSuccess
unzip /home/$USER/.config/poshthemes/themes.zip -d /home/$USER/.config/poshthemes
isSuccess
chmod u+rw /home/$USER/.config/poshthemes/*.omp.*
isSuccess
rm /home/$USER/.config/poshthemes/themes.zip
isSuccess

echo "[Scripts] Setup Fish shell...."
sed -i "s/\/home\/hgy/\/home\/$USER/g" $(pwd)/fish/config.fish
isSuccess
cp $(pwd)/fish/config.fish /home/$USER/.config/fish/config.fish
isSuccess