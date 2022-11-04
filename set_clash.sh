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

echo "[Scripts] Install clash...."
sudo pacman -U $(pwd)/clash/clash-verge-bin-1.1.2-2-x86_64.pkg.tar.zst --noconfirm
isSuccess