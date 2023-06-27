#!/usr/bin/env bash
set -ex
apt update
apt-get install -y xdg-utils
wget https://github.com/RPTools/maptool/releases/download/1.13.1/maptool_1.13.1-amd64.deb
apt install -y ./maptool_1.13.1-amd64.deb
chmod +x /opt/maptool/lib/maptool-MapTool.desktop 
