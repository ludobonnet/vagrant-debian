# -*- mode: ruby -*-
# vi: set ft=ruby :

dir = Dir.pwd

Vagrant.configure("2") do |config|

  config.vm.provider :virtualbox do |v|
	v.customize ["modifyvm", :id, "--memory", 1024]
  end
  
  config.vm.box = "modele-debian7-64"
  config.vm.box_url = "https://dl.dropboxusercontent.com/u/107568/debian-7-server-64-fr.box"

 # config.vm.hostname = "debian-dev"
  config.vm.network :private_network, ip: "192.168.50.5"
 
  config.vm.synced_folder "database/", "/srv/database"
  config.vm.synced_folder "database/data/", "/var/lib/mysql", :extra => 'dmode=777,fmode=777'

  config.vm.synced_folder "log/", "/srv/log"
  config.vm.synced_folder "log/apache2/", "/var/log/apache2", :extra => 'dmode=777,fmode=777'

  config.vm.synced_folder "config/", "/srv/config"
  
  config.vm.synced_folder "config/apache-config/sites-enabled/", "/etc/apache2/sites-enabled"
  
  config.vm.synced_folder "www/", "/srv/www/", :owner => "www-data", :extra => 'dmode=777,fmode=777'

  config.vm.provision :shell, :path => File.join( "provision", "provision.sh" )
end