# Mengatur proxy untuk terminal
echo "Menambahkan proxy ke ~/.zshrc..."
echo 'export no_proxy="localhost,127.0.0.0/8,::1"' >> ~/.zshrc
echo 'export https_proxy="http://127.0.0.1:10809"' >> ~/.zshrc
echo 'export http_proxy="http://127.0.0.1:10809"' >> ~/.zshrc
# echo 'export all_proxy="socks5://127.0.0.1:10808"' >> ~/.zshrc
echo 'alias cursor="http_proxy=http://127.0.0.1:10809 https_proxy=http://127.0.0.1:10809 all_proxy=socks5://127.0.0.1:10808 ~/.local/bin/cursor.appimage ->"' >> ~/.zshrc
. ~/.zshrc

# Menetapkan proxy untuk Snap
echo "Setting proxy for Snap..."
sudo snap set system proxy.http="http://127.0.0.1:10809"
sudo snap set system proxy.https="http://127.0.0.1:10809"

# Konfigurasi proxy untuk APT
echo "Configuring APT proxy..."
echo 'Acquire::http::Proxy "http://127.0.0.1:10809/";' | sudo tee /etc/apt/apt.conf.d/01proxy > /dev/null
echo 'Acquire::https::Proxy "http://127.0.0.1:10809/";' | sudo tee -a /etc/apt/apt.conf.d/01proxy > /dev/null

# Konfigurasi proxy untuk Git
echo "Configuring Git proxy..."
git config --global http.proxy http://127.0.0.1:10809
git config --global https.proxy http://127.0.0.1:10809

echo "Proxy settings applied successfully!"
