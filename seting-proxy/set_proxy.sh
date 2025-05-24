#!/bin/bash

# Konfigurasi proxy
HTTP_PROXY="http://127.0.0.1:10809"
HTTPS_PROXY="http://127.0.0.1:10809"
ALL_PROXY="socks5://127.0.0.1:10808"
NO_PROXY="localhost,127.0.0.0/8,::1"

# Fungsi untuk mengatur proxy di shell
configure_shell() {
  local shell_file=$1
  if [ -f "$shell_file" ]; then
    echo "Mengatur proxy di $shell_file..."
    # Hapus pengaturan proxy sebelumnya
    sed -i '/# Proxy settings start/,/# Proxy settings end/d' "$shell_file"
    # Tambahkan pengaturan baru
    cat << EOF >> "$shell_file"
# Proxy settings start
export no_proxy="$NO_PROXY"
export http_proxy="$HTTP_PROXY"
export https_proxy="$HTTPS_PROXY"
export all_proxy="$ALL_PROXY"
# Proxy settings end
EOF
  fi
}

# Mengatur variabel lingkungan di sesi saat ini
export no_proxy="$NO_PROXY"
export http_proxy="$HTTP_PROXY"
export https_proxy="$HTTPS_PROXY"
export all_proxy="$ALL_PROXY"

# Mengatur proxy untuk bash dan zsh
configure_shell ~/.bashrc
configure_shell ~/.zshrc

# Mengatur proxy untuk Snap (menggunakan HTTP, bukan SOCKS5)
echo "Mengatur proxy untuk Snap..."
sudo snap set system proxy.http="$HTTP_PROXY"
sudo snap set system proxy.https="$HTTPS_PROXY"

# Mengatur proxy untuk APT
echo "Mengatur proxy untuk APT..."
sudo mkdir -p /etc/apt/apt.conf.d
echo "Acquire::http::Proxy \"$HTTP_PROXY\";" | sudo tee /etc/apt/apt.conf.d/01proxy > /dev/null
echo "Acquire::https::Proxy \"$HTTPS_PROXY\";" | sudo tee -a /etc/apt/apt.conf.d/01proxy > /dev/null

# Mengatur proxy untuk Git (hanya HTTP untuk HTTPS remote)
echo "Mengatur proxy untuk Git..."
git config --global http.proxy "$HTTP_PROXY"
git config --global https.proxy "$HTTPS_PROXY"

# Mengatur proxy untuk npm
echo "Mengatur proxy untuk npm..."
npm config set proxy "$HTTP_PROXY"
npm config set https-proxy "$HTTPS_PROXY"

# Mengatur SSH proxy untuk GitHub
echo "Mengatur SSH proxy untuk GitHub..."
mkdir -p ~/.ssh && chmod 700 ~/.ssh
cat << EOF > ~/.ssh/config
Host github.com
    User git
    ProxyCommand nc -X 5 -x 127.0.0.1:10808 %h %p
EOF
chmod 600 ~/.ssh/config

echo "Pengaturan proxy berhasil diterapkan!"
