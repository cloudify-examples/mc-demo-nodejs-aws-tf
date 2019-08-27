#!/bin/bash -e
curl -sL https://rpm.nodesource.com/setup_10.x | sudo -E bash -
sudo yum -y install gcc-c++ make perl
sudo setenforce 0
cat << EOF | sudo tee /etc/selinux/config
SELINUX=permissive
SELINUXTYPE=targeted
EOF
ftp_password=$(dd bs=12 count=1 if=/dev/urandom | base64 | tr +/ _.)
encrypted_password=$(perl -e 'print crypt($ARGV[0], "password")' ${ftp_password})
sudo useradd -m -p ${encrypted_password} ${ftp_username}

sudo mkdir -p ${content_dir}
sudo chown -R ${ftp_username}:${ftp_username} ${content_dir}

ctx instance runtime-properties ftp_password ${ftp_password}
