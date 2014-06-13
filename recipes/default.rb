#
# Author:: Jacques Marneweck (<jacques@powertrip.co.za>)
# Cookbook Name:: mailman
# Recipe:: default
#
# Copyright 2012-2014, Jacques Marneweck
#
# All rights reserved - Do Not Redistribute
#

#
# Create the group and user beforehand so we can have the same gid/uid in use
# on multiple zones.
#
group "mailman" do
  gid node['mailman']['gid']
  not_if "grep '^mailman::110:$' /etc/group"
end

user "mailman" do
  uid node['mailman']['uid']
  gid node['mailman']['gid']
  comment "Mailman user"
  home "/var/db/mailman"
  shell "/bin/bash"
  supports :manage_home=>false
  action :create
  notifies :run, "execute[set-no-password-for-mailman-user]", :immediately
  not_if "grep '^mailman:x:110:110:Mailman user:/var/db/mailman:/bin/bash$' /etc/passwd"
end

execute "set-no-password-for-mailman-user" do
  command "passwd -N mailman"
  action :nothing
end

#
# Install required packages
#
%w{
  python27
  mailman
}.each do |p|
  package p do
    action :install
  end
end

if node['mailman']['mta'] == 'exim'
  # FIXME: need to unwrangle the install-mailman.sh script still
elsif node['mailman']['mta'] == 'postfix'
  #
  # The postfix-to-mailman.py script expects the $prefix/lib/mailman/mail
  # directory to exist under /var/db/mailman (where mailman configs and logs, etc.
  # resides) else you get a not-very-useful to debug python exception.
  #
  link "/var/db/mailman/mail" do
    to "/opt/local/lib/mailman/mail"
    not_if "test -L /var/db/mailman/mail"
  end

  #
  # Install the postfix-to-mailman.py wrapper modified from
  # www.gurulabs.com/downloads/postfix-to-mailman-2.1.py
  #
  template "/var/db/mailman/postfix-to-mailman.py" do
    source "postfix-to-mailman.py.erb"
    owner "root"
    group "root"
    mode "0755"
  end
end

include_recipe mailman::cronjobs

template "/opt/local/lib/mailman/Mailman/mm_cfg.py" do
  source "mm_cfg.py.erb"
  owner "root"
  group "mailman"
  mode "0644"
end

execute "create-mailman-list" do
  command "/opt/local/lib/mailman/bin/newlist -q -u #{node['fqdn']} -e #{node['fqdn']} mailman '#{node['mailman']['mailman_list_owner']}' '#{node['mailman']['mailman_list_password']}'"
  not_if { ::File.exists?("/var/db/mailman/lists/mailman/config.pck") }
end

execute "set-mailman-create-password" do
  command "/opt/local/lib/mailman/bin/mmsitepass '#{node['mailman']['mailman_site_pasword']}'"
end

execute "set-mailman-site-password" do
  command "/opt/local/lib/mailman/bin/mmsitepass -c '#{node['mailman']['mailman_create_password']}'"
end

%w{
  adm.pw
  aliases
  aliases.db
  creator.pw
}.each do |f|
  file "/var/db/mailman/data/#{f}" do
    owner "mailman"
    group "mailman"
    only_if { ::File.exists?("/var/db/mailman/data/#{f}") }
  end
end

service "pkgsrc/mailman" do
  action [:enable, :restart]
end
