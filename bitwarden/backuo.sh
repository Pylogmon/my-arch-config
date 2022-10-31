#!/bin/bash
date=$(date)
cd /var/lib/bitwarden
git add .
git commit -m "$date"
git push