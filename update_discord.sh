#!/bin/sh
wget -O discord.deb "https://discord.com/api/download/stable?platform=linux&format=deb"
sudo dpkg -i discord.deb
rm discord.deb
