#
# Cookbook:: chef_workshop
# Recipe:: install_tomcat
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# test for Ubuntu platform (debian)
if node['platform_family'] == 'debian'

	# update daily
	apt_update 'Update the apt cache daily' do
		frequency 86_400
		action :periodic
	end

end

# Install OpenJDK 8 JDK package (Ubuntu)
# $ sudo apt-get install openjdk-8-jdk
package 'openjdk-8-jdk'

# Create a user for tomcat
# $ sudo groupadd tomcat
# $ sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat
group 'tomcat'
user 'tomcat' do
  group 'tomcat'
  system true
  shell '/bin/nologin'
  home '/opt/tomcat'
  password 'tomcat'
end


