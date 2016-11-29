###############################
###Install script for ubuntu###
###############################
sudo apt update
sudo apt install git gcc sudo sqlite3 make apache2 -y
wget https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.7.3.linux-amd64.tar.gz

echo "export GOROOT=/usr/local/go/" >>/home/yuma/.bashrc
echo "export GOPATH=$HOME/go" >> /home/yuma/.bashrc
echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" >> /home/yuma/.bashrc
#install vuls
sudo mkdir /var/log/vuls
sudo chown -R yuma  /var/log/vuls
sudo chmod 700 /var/log/vuls
mkdir -p /usr/local/go/src/github.com/cve-dict
cd /usr/local/go/src/github.com/cve-dict
git clone https://github.com/kotakanbe/go-cve-dictionary.git
cd go-cve-dictionary
make install
#download cve-dict.
sudo mkdir /opt/vuls
cd /opt/vuls
sudo chown -R yuma /opt/vuls
chmod 777 /opt/vuls
for i in {2002..2016}; do go-cve-dictionary fetchnvd -years $i; done
ls -alh cve.sqlite3
mkdir -p $GOPATH/src/github.com/future-architect
cd $GOPATH/src/github.com/future-architect
git clone https://github.com/future-architect/vuls.git
cd vuls
make install
go get -u github.com/future-architect/vuls

cd /var/www/html
sudo git clone https://github.com/usiusi360/vulsrepo.git
echo "User yuma" >> /etc/apache2/apache2.conf
echo "Group yuma" >> /etc/apache2/apache2.conf
#awk
sudo service apache2 restart