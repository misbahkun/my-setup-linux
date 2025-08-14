#!/bin/zsh

sed -i '/export no_proxy=/d' ~/.zshrc
sed -i '/export https_proxy=/d' ~/.zshrc
sed -i '/export http_proxy=/d' ~/.zshrc
sed -i '/export all_proxy=/d' ~/.zshrc

unset no_proxy
unset https_proxy
unset http_proxy
unset all_proxy

echo "Memerlukan password untuk konfigurasi sistem (APT, Snap)..."
sudo rm -f /etc/apt/apt.conf.d/01proxy
sudo snap unset system proxy.http
sudo snap unset system proxy.https

git config --global --unset http.proxy
git config --global --unset https.proxy

echo "Proxy settings removed successfully!"