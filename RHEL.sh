yum update -y


# install epel repo and htop package
sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm || true
sudo yum install -y htop || true
htop -v

# get and build libevent as a tmux dependency 
sudo yum install -y gcc kernel-devel make ncurses-devel wget || true
wget https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz -O /tmp/libevent || true
tar -xvf /tmp/libevent -C /tmp
cd /tmp/libevent-2.1.12-stable
./configure --prefix=/usr/local --disable-openssl && make  || true
sudo make install || true
test -f /usr/local/lib/libevent.so

# get and build tmux
wget https://github.com/tmux/tmux/releases/download/3.2a/tmux-3.2a.tar.gz -O /tmp/tmux || true
tar -xvf /tmp/tmux -C /tmp || true
cd /tmp/tmux-3.2a || true
LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local && make || true
sudo make install || true
tmux -V

# get jq binary
sudo wget -O /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 || true
sudo chmod +x /usr/bin/jq || true
jq -V

# change sshd_config
sudo sed -i "/PermitRootLogin/s/^/#Defined at EOF. /; /PubkeyAuthentication/s/^/#Defined at EOF. /; /PasswordAuthentication/s/^/#Defined at EOF. /" /etc/ssh/sshd_config
sudo echo -e "\nPermitRootLogin no\nPubkeyAuthentication yes\nPasswordAuthentication no" >> /etc/ssh/sshd_config

# restart sshd
sudo service sshd restart








# Копировать файл по ssh
#cat ~/.ssh/id_rsa.pub | ssh username@remote_host "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"