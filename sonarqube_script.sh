
#!/bin/bash
sudo yum update -y
sudo yum install git-all maven wget unzip nano -y
sudo yum install fontconfig java-11-openjdk -y
cd /tmp/
sudo wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.8.zip
sudo unzip sonarqube-7.8.zip
sudo mv /tmp/sonarqube-7.8 /tmp/sonarqube 
sudo rm -rf sonarqube-7.8.zip
sudo useradd --home-dir /usr/local/sonar --shell /sbin/nologin sonar
sudo echo "sonar ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/sonar
sudo cp -r /tmp/sonarqube/ /usr/local/sonarqube/
sudo chown -R sonar:sonar /usr/local/sonarqube
sudo chmod 777 -R /usr/local/sonarqube
sudo rm -rf /etc/systemd/system/sonar.service
sudo cat << EOT >> /etc/systemd/system/sonar.service
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=sonar
Group=sonar

WorkingDirectory=/usr/local/sonarqube
ExecStart=/usr/local/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/usr/local/sonarqube/bin/linux-x86-64/sonar.sh stop

RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target

EOT

sudo systemctl daemon-reload
sudo systemctl enable sonar
sudo systemctl start sonar
sudo systemctl status sonar


