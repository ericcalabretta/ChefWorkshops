#
# Cookbook:: chef_workshop
# Recipe:: install
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# test for Ubuntu platform (debian)
if node['platform_family'] == 'debian'

	# update daily
	apt_update 'Update the apt cache daily' do
		frequency 86_400
		action :periodic
	end

	# create list file
	file '/etc/apt/sources.list.d/mongodb-org-3.6.list' do
		content 'deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse '
		mode '0644'
		owner 'root'
		group 'root'
	end
end

# install mongodb package
package 'mongodb-org'

# enable and start service
service 'mongod' do
	supports status: true
	action [:enable, :start]
end

