#!/bin/bash

isSuccess(){
    if [ $? -eq 0 ]; then
        echo "[Scripts] Success!"
    else
        echo "[Scripts] Failed!"
        exit 999
    fi
}

echo "[Scripts] Start setup cargo...."
echo "[Scripts] Install rust...."
sudo pacman -S rust rust-analyzer rust-src --noconfirm
isSuccess

echo "[Scripts] Copy config file...."
mkdir /home/$USER/.cargo
cp $(pwd)/cargo/config /home/$USER/.cargo/config