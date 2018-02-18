#!/bin/bash 

apt-get -y install vim git ctags 
mkdir -p /home/$USER/.vim/.swp_files 
git clone https://github.com/SonJuHyung/etc.git 
cp etc/vimrc.txt ~/.vimrc
cp etc/hybrid.vim /usr/share/vim/vim74/colors 
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim ~/.vimrc

apt-get -y install linux-tools-common linux-tools-generic linux-tools-`uname -r`
mkdir workspace 
git clone https://github.com/SonJuHyung/Simple-Experiments.git workspace 
mkdir workspace/docker 
git clone https://github.com/docker/docker-install.git workspace/docker 
source workspace/docker/install.sh 
rm -rf workspace/cloudsuite/_check.sh
rm -rf workspace/cloudsuite/run/
source workspace/cloudsuite/mkdir.sh run
source workspace/cloudsuite/mkdir.sh sys
source workspace/cloudsuite/mkdir.sh perf 
cp workspace/sys_script/_check.sh workspace/cloudsuite/_check.sh

apt-get -y install redis-server maven default-jdk default-jre
mkdir workspace/ycsb/db/redis/run 
mkdir workspace/ycsb/db/redis/run/thp
mkdir workspace/ycsb/db/redis/run/nhp
mkdir workspace/ycsb/db/redis/sys
mkdir workspace/ycsb/db/redis/sys/thp
mkdir workspace/ycsb/db/redis/sys/nhp
mkdir workspace/ycsb/db/redis/perf
mkdir workspace/ycsb/db/redis/perf/thp
mkdir workspace/ycsb/db/redis/perf/nhp
git clone https://github.com/brianfrankcooper/YCSB.git workspace/ycsb/YCSB/ 
cp workspace/sys_script/_check.sh workspace/ycsb/YCSB/_check.sh
cp workspace/ycsb/exp_ycsb.sh workspace/ycsb/YCSB 
cd workspace/ycsb/YCSB/
#mvn clean package 
mvn -pl com.yahoo.ycsb:redis-binding -am clean package 
echo redis-cli config set stop-writes-on-bgsave-error no >> pre.sh 
echo redis-cli config set save "" >> pre.sh
