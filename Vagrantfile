
Vagrant.configure("2") do |config|
  ##download vagrant host manager plug in first##
  config.hostmanager.enabled = true 
  config.hostmanager.manage_host = true
  
###  Sonaqube VM ###
  config.vm.define "s01" do |s01|
    s01.vm.box = "geerlingguy/centos7"
    s01.vm.box_download_insecure=true
    s01.vm.hostname = "s01"
	  s01.vm.network "private_network", ip: "192.168.56.11"
    s01.vm.provision "shell", path: "sonarqube_script.sh"
	  s01.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
     end
    
  end
  
### tomcat1 vm ###
   config.vm.define "app01" do |app01|
    app01.vm.box = "geerlingguy/centos7"
    app01.vm.box_download_insecure=true
    app01.vm.hostname = "app01"
    app01.vm.provision "shell", path: "tomcat_script.sh"
    app01.vm.network "private_network", ip: "192.168.56.12"
  end

  ### tomcat2 vm ###
     config.vm.define "app02" do |app02|
      app02.vm.box = "geerlingguy/centos7"
      app02.vm.box_download_insecure=true
      app02.vm.hostname = "app02"
      app02.vm.provision "shell", path: "tomcat_script.sh"
      app02.vm.network "private_network", ip: "192.168.56.17"
    end

    ### tomcat3 vm ###
       config.vm.define "app03" do |app03|
        app03.vm.box = "geerlingguy/centos7"
        app03.vm.box_download_insecure=true
        app03.vm.hostname = "app03"
        app03.vm.provision "shell", path: "tomcat_script.sh"
        app03.vm.network "private_network", ip: "192.168.56.18"
      end
   
### Nexus vm  ####
  config.vm.define "nx03" do |nx03|
    nx03.vm.box = "geerlingguy/centos7"
    nx03.vm.box_download_insecure=true
	  nx03.vm.hostname = "nx03"
    nx01.vm.provision "shell", path: "nexus_script.sh"
    nx03.vm.network "private_network", ip: "192.168.56.21"
    nx03.vm.provider "virtualbox" do |vb|
     vb.memory = "5000"
     end
  end

  ### Nexus2 vm  ####
  config.vm.define "nx02" do |nx02|
    nx02.vm.box = "geerlingguy/centos7"
    nx02.vm.box_download_insecure=true
	  nx02.vm.hostname = "nx02"
    nx02.vm.provision "shell", path: "nexus_script.sh"
    nx02.vm.network "private_network", ip: "192.168.56.16"
    nx02.vm.provider "virtualbox" do |vb|
     vb.memory = "5000"
     end
  end

   ### Jenkins Agent1 vm  ####
   config.vm.define "ag01" do |ag01|
    ag01.vm.box = "geerlingguy/centos7"
    ag01.vm.box_download_insecure=true
    ag01.vm.hostname = "ag01"
    ag01.vm.provision "shell", path: "agent_script.sh"
    ag01.vm.network "private_network", ip: "192.168.56.19"
    ag01.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    end
  end
  

  ### Jenkins Agent2 vm  ####
  config.vm.define "ag02" do |ag02|
    ag02.vm.box = "geerlingguy/centos7"
    ag02.vm.box_download_insecure=true
    ag02.vm.hostname = "ag02"
    ag02.vm.provision "shell", path: "agent_script.sh"
    ag02.vm.network "private_network", ip: "192.168.56.20"
    ag02.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    end
  end
  
### Jenkins vm  ####
  config.vm.define "j01" do |j01|
    j01.vm.box = "geerlingguy/centos7"
    j01.vm.box_download_insecure=true
	  j01.vm.hostname = "j01"
    j01.vm.network "private_network", ip: "192.168.56.14"
	j01.vm.provision "shell", path: "Jenkins_script.sh"  
   j01.vm.provider "virtualbox" do |vb|
    vb.memory = "5000"
  end
end

end 

