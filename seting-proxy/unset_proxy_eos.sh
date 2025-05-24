#!/bin/bash

# =============================
# Unset Proxy untuk Arch Linux
# =============================

echo "🔄 Menghapus konfigurasi proxy..."

# 1️⃣ Unset Proxy dari Shell (Bash/Zsh)
echo "Menghapus proxy dari Bash/Zsh..."
sed -i '/export http_proxy/d' ~/.bashrc
sed -i '/export https_proxy/d' ~/.bashrc
sed -i '/export all_proxy/d' ~/.bashrc
sed -i '/export no_proxy/d' ~/.bashrc

# Jika menggunakan Zsh
# if [ -f ~/.zshrc ]; then
#     sed -i '/export http_proxy/d' ~/.zshrc
#     sed -i '/export https_proxy/d' ~/.zshrc
#     sed -i '/export all_proxy/d' ~/.zshrc
#     sed -i '/export no_proxy/d' ~/.zshrc
# fi

# Terapkan perubahan
source ~/.bashrc
# [ -f ~/.zshrc ] && source ~/.zshrc

# 2️⃣ Unset Proxy untuk Pacman (Manajer Paket Arch)
echo "Menghapus proxy dari pacman..."
sudo sed -i '/XferCommand/d' /etc/pacman.conf

# 3️⃣ Unset Proxy untuk Yay (AUR Helper)
echo "Menghapus proxy dari Yay..."
sed -i '/proxy/d' ~/.config/yay/config.json 2>/dev/null

# 4️⃣ Unset Proxy untuk Git
echo "Menghapus proxy dari Git..."
git config --global --unset http.proxy
git config --global --unset https.proxy

echo "✅ Proxy berhasil dihapus!"
