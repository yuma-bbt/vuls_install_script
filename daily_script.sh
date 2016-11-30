echo "####################"
echo "vuls update & scan start!"
echo "####################"
cd /home/hoge
go get -u github.com/kotakanbe/go-cve-dictionary
go get -u github.com/future-architect/vuls
go-cve-dictionary fetchnvd -last2y
cd /home/hoge/vuls
vuls scan --cve-dictionary-dbpath /home/ec2-user/vuls/cve.sqlite3 -report-slack
 
