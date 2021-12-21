yum update -y

#yum install java-latest-openjdk.x86_64 -y --skip-broken

# Устанавливаем реп epel и пакет htop
sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm || true
sudo yum install -y htop || true
htop -v

# Собираем libevent, от которого зависит tmux
sudo yum install -y gcc kernel-devel make ncurses-devel wget || true
wget https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz -O /tmp/libevent
tar -xvf /tmp/libevent -C /tmp
cd /tmp/libevent-2.1.12-stable
./configure --prefix=/usr/local --disable-openssl && make  || true
sudo make install || true
test -f /usr/local/lib/libevent.so

# Собираем tmux
wget https://github.com/tmux/tmux/releases/download/3.2a/tmux-3.2a.tar.gz -O /tmp/tmux
tar -xvf /tmp/tmux -C /tmp
cd /tmp/tmux-3.2a
LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local && make
sudo make install
/usr/local/bin/tmux -V

# Скачиваем и устанавливаем бинарник jq
wget -O /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x /usr/bin/jq
jq -V

# Перезапуск sshd
service sshd restart



# Изменяем sshd_config
sed -i "/PermitRootLogin/s/^/#Defined at EOF. /; /PubkeyAuthentication/s/^/#Defined at EOF. /; /PasswordAuthentication/s/^/#Defined at EOF. /" /etc/ssh/sshd_config
echo -e "\nPermitRootLogin no\nPubkeyAuthentication yes\nPasswordAuthentication no" >> /etc/ssh/sshd_config






# Копировать файл по ssh
#cat ~/.ssh/id_rsa.pub | ssh username@remote_host "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"