#!/bin/bash
sudo yum update -y
sudo yum install git-all maven wget -y
sudo yum install fontconfig java-11-openjdk -y
cd /tmp/
sudo wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.26/bin/apache-tomcat-10.0.26.tar.gz -O tomcat10.tar.gz
sudo tar xzvf tomcat10.tar.gz 
sudo mv /tmp/apache* /tmp/tomcat10
sudo useradd --home-dir /usr/local/tomcat10 --shell /sbin/nologin tomcat
sudo cp -r /tmp/tomcat10/* /usr/local/tomcat10/
sudo chown -R tomcat:tomcat /usr/local/tomcat10
sudo chmod 777 -R /usr/local/tomcat10
sudo rm -rf /etc/systemd/system/tomcat.service
cat << EOT >> /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat
After=network.target

[Service]

User=tomcat
Group=tomcat

WorkingDirectory=/usr/local/tomcat10

#Environment=JRE_HOME=/usr/lib/jvm/jre
Environment=JAVA_HOME=/usr/lib/jvm/jre

Environment=CATALINA_PID=/var/tomcat/%i/run/tomcat.pid
Environment=CATALINA_HOME=/usr/local/tomcat10
Environment=CATALINE_BASE=/usr/local/tomcat10

ExecStart=/usr/local/tomcat10/bin/catalina.sh run
ExecStop=/usr/local/tomcat10/bin/shutdown.sh

RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target

EOT

sudo systemctl daemon-reload
sleep 10
sudo echo 'configuring context.xml for Manager...'

sudo cp /usr/local/tomcat10/webapps/manager/META-INF/context.xml /usr/local/tomcat10/webapps/manager/META-INF/context-backup.xml
sudo rm -rf /usr/local/tomcat10/webapps/manager/META-INF/context.xml
cat << EOT >> /usr/local/tomcat10/webapps/manager/META-INF/context.xml
<?xml version="1.0" encoding="UTF-8"?>
<!--
  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
-->
<Context antiResourceLocking="false" privileged="true" >
  <CookieProcessor className="org.apache.tomcat.util.http.Rfc6265CookieProcessor"
                   sameSiteCookies="strict" />
  <Manager sessionAttributeValueClassNameFilter="java\.lang\.(?:Boolean|Integer|Long|Number|String)|org\.apache\.catalina\.filters\.CsrfPreventionFilter\$LruCache(?:\$1)?|$
</Context>
EOT

sleep 20
sudo echo 'configuration of Manager successful!'
sleep 5
sudo echo 'configuring context.xml for Host-Manager...'

sudo cp /usr/local/tomcat10/webapps/host-manager/META-INF/context.xml /usr/local/tomcat10/webapps/host-manager/META-INF/context-backup.xml
sudo rm -rf /usr/local/tomcat10/webapps/host-manager/META-INF/context.xml
cat << EOT >> /usr/local/tomcat10/webapps/manager/META-INF/context.xml
<?xml version="1.0" encoding="UTF-8"?>
<!--
  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
-->
<Context antiResourceLocking="false" privileged="true" >
  <CookieProcessor className="org.apache.tomcat.util.http.Rfc6265CookieProcessor"
                   sameSiteCookies="strict" />
  <Manager sessionAttributeValueClassNameFilter="java\.lang\.(?:Boolean|Integer|Long|Number|String)|org\.apache\.catalina\.filters\.CsrfPreventionFilter\$LruCache(?:\$1)?|$
</Context>

EOT

sleep 20

sudo echo 'configuration of Host-Manager successful!'

sleep 5

sudo echo 'Updating tomcat users credentials...'

sudo cp /usr/local/tomcat10/conf/tomcat-users.xml /usr/local/tomcat10/conf/tomcat-users-backup.xml
sudo rm -rf /usr/local/tomcat10/conf/tomcat-users.xml
cat << EOT >> /usr/local/tomcat10/conf/tomcat-users.xml
<?xml version="1.0" encoding="UTF-8"?>

<tomcat-users xmlns="http://tomcat.apache.org/xml"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
              version="1.0">

  <user username="admin" password="admin" roles="manager-gui,manager-script,manager-jmx,manager-status"/>
  <user username="admin" password="admin" roles="admin-gui,admin-script"/>
  <user username="nelson" password="nelson" roles="manager-gui,manager-script,manager-jmx,manager-status"/>
  <user username="nelson" password="nelson" roles="admin-gui,admin-script"/>

</tomcat-users>

EOT

sleep 20

sudo echo 'tomcat users credentials updated!'
sleep 10
echo 'Tomcat Installation Complete!'
sleep 5
echo 'Starting tomcat...'
sudo systemctl start tomcat
sleep 5
echo 'tomcat started successfully...'
sudo systemctl enable tomcat
sleep5
sudo systemctl status tomcat