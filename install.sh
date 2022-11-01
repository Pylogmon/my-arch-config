#!/bin/bash

isSuccess(){
    if [ $? -eq 0 ]; then
        echo "[Scripts] Success!"
    else
        echo "[Scripts] Failed!"
        exit 999
    fi
}

echo "[Scripts] Update...."
sudo pacman -Syyu --noconfirm
isSuccess

echo "[Scripts] Install paru...."
sudo pacman -U $(pwd)/paru/paru-bin-1.11.1-1-x86_64.pkg.tar.zst --noconfirm
isSuccess

# aria2
bash $(pwd)/setup_aria2.sh
isSuccess

# wezterm
bash $(pwd)/setup_wezterm.sh
isSuccess

# cargo
bash $(pwd)/setup_cargo.sh
isSuccess

# bitwarden
bash $(pwd)/setup_bitwarden.sh
isSuccess