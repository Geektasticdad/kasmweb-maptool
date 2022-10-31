#!/usr/bin/env bash
set -ex
wget https://github.com/RPTools/maptool/releases/download/1.12.2/maptool_1.12.2-amd64.deb
apt-get install -y ./maptool_1.12.2-amd64.deb
chmod +x /opt/maptool/maptool-Maptool.desktop 
