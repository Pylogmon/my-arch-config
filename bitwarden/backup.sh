#!/bin/bash
date=$(date)
cd /home/$USER/.config/vaultwarden
cp /var/lib/vaultwarden/db.* .
git add .
git commit -m "$date"
git push