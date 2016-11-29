###############################
###Install script for ubuntu###
###############################
sudo apt update
sudo apt install git gcc sudo sqlite3 make apache2 -y
#install golang
wget https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.7.3.linux-amd64.tar.gz
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

echo "export GOROOT=/usr/local/go">>~/.bashrc
echo "export GOPATH=$HOME/go">>~/.bashrc
echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin">>~/.bashrc
source ~/.bashrc
#install vuls
sudo mkdir /var/log/vuls
sudo chown yuma  /var/log/vuls
sudo chmod 777 /var/log/vuls
mkdir -p $GOPATH/src/github.com/kotakanbe
cd $GOPATH/src/github.com/kotakanbe
git clone https://github.com/kotakanbe/go-cve-dictionary.git
cd go-cve-dictionary
make install

#download cve-dict.
sudo mkdir /opt/vuls
cd /opt/vuls
sudo chown -R yuma /opt/vuls
sudo chmod 777 /opt/vuls
for i in {2002..2016}; do go-cve-dictionary fetchnvd -years $i; done
ls -alh cve.sqlite3

#vuls
sudo mkdir -p ~/go/src/github.com/future-architect
cd ~/go/src/github.com/future-architect
sudo chmod 777 ~/go/src/github.com/future-architect
sudo chown yuma ~/go/src/github.com/future-architect
git clone https://github.com/future-architect/vuls.git
cd ~/go/src/github.com/future-architect/vuls
make install

cd /var/www/html
sudo git clone https://github.com/usiusi360/vulsrepo.git
sudo sed -i 's/User root/User yuma/g' /etc/apache2/apache2.conf
sudo sed -i 's/Group root/Group yuma/g' /etc/apache2/apache2.conf
#awk
sudo service apache2 restart
~
