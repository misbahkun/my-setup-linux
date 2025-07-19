# Bersihkan baris proxy lama
sed -i '/export no_proxy=/d' ~/.zshrc
sed -i '/export https_proxy=/d' ~/.zshrc
sed -i '/export http_proxy=/d' ~/.zshrc
sed -i '/export all_proxy=/d' ~/.zshrc

# Tambahkan baris proxy baru
echo 'export no_proxy="localhost,127.0.0.1,::1"' >> ~/.zshrc
echo 'export https_proxy="http://127.0.0.1:10809"' >> ~/.zshrc
echo 'export http_proxy="http://127.0.0.1:10809"' >> ~/.zshrc
echo 'export all_proxy="socks5://127.0.0.1:10808"' >> ~/.zshrc
source ~/.zshrc

# Snap
sudo snap set system proxy.http="http://127.0.0.1:10809"
sudo snap set system proxy.https="http://127.0.0.1:10809"

# APT
echo 'Acquire::http::Proxy "http://127.0.0.1:10809/";' | sudo tee /etc/apt/apt.conf.d/01proxy > /dev/null
echo 'Acquire::https::Proxy "http://127.0.0.1:10809/";' | sudo tee -a /etc/apt/apt.conf.d/01proxy > /dev/null

# Git
git config --global http.proxy http://127.0.0.1:10809
git config --global https.proxy http://127.0.0.1:10809

echo "Proxy settings applied successfully!"
