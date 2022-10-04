
#!/bin/bash
sudo yum update -y
sudo yum install java-11-openjdk -y 
sudo yum install git wget unzip -y
cd /etc/yum.repos.d/
sudo wget https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
sleep 3
echo ' '
echo ' '
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo ''
echo ''
sleep 3
echo 'Jenkins installation complete!'