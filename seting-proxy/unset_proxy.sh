# Hapus baris proxy dari ~/.zshrc
sed -i '/export no_proxy=/d' ~/.zshrc
sed -i '/export https_proxy=/d' ~/.zshrc
sed -i '/export http_proxy=/d' ~/.zshrc
sed -i '/export all_proxy=/d' ~/.zshrc
source ~/.zshrc

# Unset environment variable di shell aktif
unset no_proxy
unset https_proxy
unset http_proxy
unset all_proxy

# APT
sudo rm -f /etc/apt/apt.conf.d/01proxy

# Snap
sudo snap unset system proxy.http
sudo snap unset system proxy.https
sudo systemctl restart snapd

# Git
git config --global --unset http.proxy
git config --global --unset https.proxy

echo "Proxy settings removed successfully!"
