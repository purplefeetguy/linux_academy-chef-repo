#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
if node["platform"] == "ubuntu"
  execute "apt-get update -y"
end

package "apache2" do
  package_name node["apache"]["package"]
end

# on each node, for each attribute that has apache and sites listed, populate the sitename and data
node["apache"]["sites"].each do |sitename, data|
  # create document root for each sitename variable
  document_root = "/content/sites/#{sitename}"
  # if directory does not exist create it, recursively if necessary; set mode for all document root
  directory document_root do
    mode "0755"
    recursive true
  end

  if node["platform"] == "ubuntu"
    template_location = "/etc/apache2/sites-enabled/#{sitename}.conf"
  elsif node["platform"] == "centos"
    template_location = "/etc/httpd/conf.d/#{sitename}.conf"
  end

  # create template to define configuration file for each sitename vhost
  template template_location do
    # use vhost.erb as the configuration source for this template
    source "vhost.erb"
    # set creation mode for this file
    mode "0644"
    # grab variables from ruby each loop to pass to and populate the vhost.erb above
    variables(
      :document_root => document_root,
      :port => data["port"],
      :domain => data["domain"]
    )
    # notify apache service to restart on modifications
    notifies :restart, "service[httpd]"
  end

  # create template to define index.html file for each sitename
  template "/content/sites/#{sitename}/index.html" do
    source "index.html.erb"
    mode "0644"
    variables(
             :site_title => data["site_title"],
             :comingsoon => "Coming Soon!"
    )
  end

end

execute "rm /etc/httpd/conf.d/welcome.conf" do
  only_if do
    File.exist?("/etc/httpd/conf.d/welcome.conf")
  end
  notifies :restart, "service[httpd]"
end

execute "rm /etc/httpd/conf.d/README" do
  only_if do
    File.exist?("/etc/httpd/conf.d/README")
  end
  notifies :restart, "service[httpd]"
end

service "httpd" do
  service_name node["apache"]["package"]
  action [:enable, :start]
end

#include_recipe "php::default"
