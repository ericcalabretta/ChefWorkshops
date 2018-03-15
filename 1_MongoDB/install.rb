#
# Cookbook:: chef_workshop
# Recipe:: install
#
# Copyright:: 2018, The Authors, All Rights Reserved.


apt_update 'Update the apt cache daily' do
  frequency 86_400
  action :periodic
end

package 'mongodb'

service 'mongodb' do
	supports status: true
	action [:enable, :start]
end

