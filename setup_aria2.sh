#!/bin/bash

isSuccess(){
    if [ $? -eq 0 ]; then
        echo "[Scripts] Success!"
    else
        echo "[Scripts] Failed!"
        exit 999
    fi
}

echo "[Scripts] Start setup aria2...."
echo "[Scripts] Install aria2...."
sudo pacman -S aria2 --noconfirm
isSuccess

echo "[Scripts] Edit config file...."
sed -i "s/\/home\/hgy/\/home\/$USER/g" $(pwd)/aria2/config/aria2.conf
isSuccess
sed -i "s/\/home\/hgy/\/home\/$USER/g" $(pwd)/aria2/service/aria2.service
isSuccess

echo "[Scripts] mkdir ~/.config/aria2...."
mkdir -p /home/$USER/.config/aria2
isSuccess
echo "[Scripts] Copy config files...."
{
    cp $(pwd)/aria2/config/aria2.conf /home/$USER/.config/aria2/aria2.conf
    cp $(pwd)/aria2/config/aria2.session /home/$USER/.config/aria2/aria2.session
    cp $(pwd)/aria2/paru/aria2-paru.conf /home/$USER/.config/aria2/aria2-paru.conf
    sudo cp $(pwd)/aria2/service/aria2.service /etc/systemd/system/aria2.service
}
isSuccess

echo "[Scripts] Start service...."
sudo systemctl enable aria2 --now
isSuccess

echo "[Scripts] Edit makepkg.conf"
{
    sudo sed -i "s/file::.*/file::\/usr\/bin\/aria2c --conf-path=\/home\/$USER\/.config\/aria2\/aria2-paru.conf -UWget -s4 %u -o %o'/g" /etc/makepkg.conf
    sudo sed -i "s/ftp::.*/ftp::\/usr\/bin\/aria2c --conf-path=\/home\/$USER\/.config\/aria2\/aria2-paru.conf -UWget -s4 %u -o %o'/g" /etc/makepkg.conf
    sudo sed -i "s/http::.*/http::\/usr\/bin\/aria2c --conf-path=\/home\/$USER\/.config\/aria2\/aria2-paru.conf -UWget -s4 %u -o %o'/g" /etc/makepkg.conf
    sudo sed -i "s/https::.*/https::\/usr\/bin\/aria2c --conf-path=\/home\/$USER\/.config\/aria2\/aria2-paru.conf -UWget -s4 %u -o %o'/g" /etc/makepkg.conf
    sudo sed -i "s/file::.*/file::\/usr\/bin\/aria2c --conf-path=\/home\/$USER\/.config\/aria2\/aria2-paru.conf -UWget -s4 %u -o %o'/g" /etc/makepkg.conf
}
isSuccess