#!/bin/bash

# Fungsi untuk menghapus proxy di shell
remove_shell_proxy() {
  local shell_file=$1
  if [ -f "$shell_file" ]; then
    echo "Menghapus proxy dari $shell_file..."
    sed -i '/# Proxy settings start/,/# Proxy settings end/d' "$shell_file"
  fi
}

# Menghapus variabel lingkungan di sesi saat ini
unset no_proxy
unset http_proxy
unset https_proxy
unset all_proxy

# Menghapus proxy untuk bash dan zsh
remove_shell_proxy ~/.bashrc
remove_shell_proxy ~/.zshrc

# Menghapus proxy untuk Snap
echo "Menghapus proxy untuk Snap..."
sudo snap unset system proxy.http
sudo snap unset system proxy.https

# Menghapus proxy untuk APT
echo "Menghapus proxy untuk APT..."
sudo rm -f /etc/apt/apt.conf.d/01proxy

# Menghapus proxy untuk Git
echo "Menghapus proxy untuk Git..."
git config --global --unset http.proxy
git config --global --unset https.proxy

# Menghapus proxy untuk npm
echo "Menghapus proxy untuk npm..."
npm config rm proxy
npm config rm https-proxy

# Menghapus SSH proxy untuk GitHub
echo "Menghapus SSH proxy untuk GitHub..."
if [ -f ~/.ssh/config ]; then
  sed -i '/Host github.com/,/ProxyCommand/d' ~/.ssh/config
  # Hapus file jika kosong
  if [ ! -s ~/.ssh/config ]; then
    rm -f ~/.ssh/config
  fi
fi

echo "Pengaturan proxy berhasil dihapus!"
