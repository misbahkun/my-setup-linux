#!/bin/bash

# =============================
# Setup Proxy untuk Arch Linux
# =============================

# Proxy Configuration
HTTP_PROXY="http://127.0.0.1:10809"
HTTPS_PROXY="http://127.0.0.1:10809"
SOCKS_PROXY="socks5://127.0.0.1:10808"
NO_PROXY="localhost,127.0.0.1,::1"

# 1️⃣ Konfigurasi Proxy untuk Shell (Bash/Zsh)
echo "Menambahkan proxy ke shell (Bash/Zsh)..."
echo "export http_proxy=\"$HTTP_PROXY\"" >> ~/.bashrc
echo "export https_proxy=\"$HTTPS_PROXY\"" >> ~/.bashrc
echo "export all_proxy=\"$SOCKS_PROXY\"" >> ~/.bashrc
echo "export no_proxy=\"$NO_PROXY\"" >> ~/.bashrc

# Jika menggunakan Zsh
# if [ -f ~/.zshrc ]; then
#     echo "export http_proxy=\"$HTTP_PROXY\"" >> ~/.zshrc
#     echo "export https_proxy=\"$HTTPS_PROXY\"" >> ~/.zshrc
#     echo "export all_proxy=\"$SOCKS_PROXY\"" >> ~/.zshrc
#     echo "export no_proxy=\"$NO_PROXY\"" >> ~/.zshrc
# fi

# Terapkan perubahan
source ~/.bashrc
# [ -f ~/.zshrc ] && source ~/.zshrc

# 2️⃣ Konfigurasi Proxy untuk Pacman (Manajer Paket Arch)
echo "Setting proxy untuk pacman..."
echo "XferCommand = /usr/bin/curl --proxy \"$HTTP_PROXY\" -L -C - -f -o %o %u" | sudo tee -a /etc/pacman.conf > /dev/null

# 3️⃣ Konfigurasi Proxy untuk Yay (AUR Helper)
echo "Setting proxy untuk Yay..."
echo "proxy=\"$HTTP_PROXY\"" | tee -a ~/.config/yay/config.json > /dev/null

# 4️⃣ Konfigurasi Proxy untuk Git
echo "Setting proxy untuk Git..."
git config --global http.proxy $HTTP_PROXY
git config --global https.proxy $HTTPS_PROXY

echo "✅ Proxy berhasil dikonfigurasi! Coba jalankan 'curl ifconfig.me' untuk cek IP."
