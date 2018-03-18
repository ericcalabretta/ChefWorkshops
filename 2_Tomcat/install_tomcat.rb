#
# Cookbook:: chef_workshop
# Recipe:: install_tomcat
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# test for Ubuntu platform (debian)
#
if node['platform_family'] == 'debian'

	# update daily
	apt_update 'Update the apt cache daily' do
		frequency 86_400
		action :periodic
	end

end

# Install OpenJDK 8 JDK package (Ubuntu)
# $ sudo apt-get install openjdk-8-jdk
#
package 'openjdk-8-jdk'

# Create group and user for tomcat
# $ sudo groupadd tomcat
# $ sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat
#
group 'tomcat'
user 'tomcat' do
  group 'tomcat'
  system true
  shell '/bin/nologin'
  home '/opt/tomcat'
  password 'tomcat'
end

# Download tomcat binary - apache-tomcat-8.5.9.tar.gz will be used
# https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz
#
# $ cd /tmp
#$ wget http://apache.cs.utah.edu/tomcat/tomcat-8/v8.5.20/bin/apache-tomcat-8.5.20.tar.gz
#
src_url = 'https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.9/bin'
src_filename = 'apache-tomcat-8.5.9.tar.gz'
src_filepath = "/tmp/#{src_filename}"
remote_file "#{src_filepath}" do
	source "#{src_url}/#{src_filename}"
	owner 'root'
	group 'root'
	mode '0755'
end

# Extract tomcat binary
#
# $ sudo mkdir /opt/tomcat
# $ sudo tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1
#
puts "Extract tomcat binary code here..."

# Update file and directory permissions
#
# $ sudo chgrp -R tomcat /opt/tomcat
# $ sudo chmod -R g+r conf
# $ sudo chmod g+x conf
# $ sudo chown -R tomcat webapps/ work/ temp/ logs/
#
puts "Update file and directory permissions code here..."

# Install the Systemd Unit File
#
# $ sudo vi /etc/systemd/system/tomcat.service
#
puts "Install the Systemd Unit File (using git) code here..."

# Reload Systemd to load the Tomcat Unit file
#
# $ sudo systemctl daemon-reload
#
puts "Reload Systemd to load the Tomcat Unit file code here..."

# Ensure `tomcat` is started and enabled
#
# $ sudo systemctl start tomcat
# $ sudo systemctl enable tomcat
#
puts "Ensure `tomcat` is started and enabled code here..."

