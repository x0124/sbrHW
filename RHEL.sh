yum update -y

# Устанавливаем реп epel и пакет htop
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y htop
htop -v

# Собираем libevent, от которого зависит tmux
yum install -y gcc kernel-devel make ncurses-devel wget
cd /tmp
wget https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz
tar -xvf libevent-2.1.12-stable.tar.gz
cd libevent-2.1.12-stable
./configure --prefix=/usr/local --disable-openssl
make
make install
cd ..
rm -rf libevent*

# Собираем tmux
wget https://github.com/tmux/tmux/releases/download/3.2a/tmux-3.2a.tar.gz
tar -xvf tmux-3.2a.tar.gz
cd tmux-3.2a
LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
make
make install
cd ..
rm -rf tmux*
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