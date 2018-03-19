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
# $ wget http://apache.cs.utah.edu/tomcat/tomcat-8/v8.5.20/bin/apache-tomcat-8.5.20.tar.gz
#
src_url = 'https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.9/bin'
tomcat_version = 'apache-tomcat-8.5.9'
src_filename = "#{tomcat_version}.tar.gz"
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
tomcat_directory = '/opt/tomcat'
directory "#{tomcat_directory}" do
  owner 'root'
  group 'root'
  mode '0755'
end

execute 'extract_tomcat' do
  command <<-EOF
    tar xzf #{src_filepath} -C #{tomcat_directory}
    EOF
  not_if { Dir.exist?("#{tomcat_directory}/#{tomcat_version}") }
end

# Update file and directory permissions
#
# $ sudo chgrp -R tomcat /opt/tomcat
execute 'change_tomcat_group' do
  command "chgrp -R tomcat #{tomcat_directory}/#{tomcat_version}"
end

# $ sudo chmod -R g+r conf
execute 'change_conf_file_privileges' do
	cwd "#{tomcat_directory}/#{tomcat_version}"
  command "chmod -R g+r conf"
end

# $ sudo chmod g+x conf
execute 'change_conf_directory_privileges' do
	cwd "#{tomcat_directory}/#{tomcat_version}"
  command "chmod g+x conf"
end

# $ sudo chown -R tomcat webapps/ work/ temp/ logs/
#
execute 'change_tomcat_directory_privileges' do
	cwd "#{tomcat_directory}/#{tomcat_version}"
	command <<-EOF
		chown -R tomcat webapps/
		chown -R tomcat work/
		chown -R tomcat temp/
		chown -R tomcat logs/
		EOF
end

# Install the Systemd Unit File
#
# $ sudo vi /etc/systemd/system/tomcat.service
#
cookbook_file '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Reload Systemd to load the Tomcat Unit file
#
# $ sudo systemctl daemon-reload
#
service 'tomcat reload' do
	supports status: true
	action [:reload]
end

# Ensure `tomcat` is started and enabled
#
# $ sudo systemctl start tomcat
# $ sudo systemctl enable tomcat
#
service 'tomcat' do
	supports status: true
	action [:enable, :start]
end

