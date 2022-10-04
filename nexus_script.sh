#!/bin/bash
sudo yum update -y
sudo yum install git wget unzip maven -y
sudo useradd nexus
sudo echo "nexus ALL=(ALL) NOPASSWD:ALL"|sudo tee /etc/sudoers.d/nexus
cd /tmp/
sudo wget https://download.sonatype.com/nexus/3/nexus-3.42.0-01-unix.tar.gz -O nexus3.tar.gz
sudo tar xzvf nexus3.tar.gz
sudo mv nexus-*/ nexus3
sudo cp -r /tmp/nexus3/ /opt/nexus3/
sudo cp -r /tmp/sonatype-work/ /opt/sonatype-work/
sudo chown -R nexus:nexus /opt/nexus3
sudo chmod 777 -R /opt/nexus3
sudo chown -R nexus:nexus /opt/sonatype-work
sudo chmod 777 -R /opt/sonatype-work
sudo echo "run_as_user='nexus'" > /usr/local/nexus3/bin/nexus.rc

sudo rm -rf /etc/systemd/system/nexus.service
sudo cat << EOT >> /etc/systemd/system/nexus.service
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus

WorkingDirectory=/opt/nexus3
ExecStart=/opt/nexus3/bin/nexus start
ExecStop=/opt/nexus3/bin/nexus stop


RestartSec=10
TimeoutSec=600
Restart=on-abort


[Install]
WantedBy=multi-user.target

EOT

sudo systemctl daemon-reload
sudo systemctl start nexus
sudo systemctl enable nexus
sudo systemctl status nexus