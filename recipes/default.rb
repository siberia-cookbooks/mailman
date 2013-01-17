#
# Author:: Jacques Marneweck (<jacques@powertrip.co.za>)
# Cookbook Name:: mailman
# Recipe:: default
#
# Copyright 2012, Jacques Marneweck
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
  package "#{p}" do
    version "2.1.14.1"
    action :install
  end
end

if node[:mailman][:mta] == 'exim'
  # FIXME: need to unwrangle the install-mailman.sh script still
elsif node[:mailman][:mta] == 'postfix'
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

#
# Cronjobs for mailman
#
cron "mailman-checkdbs" do
  hour "8"
  minute "0"
  command "/opt/local/bin/python2.7 -S /opt/local/lib/mailman/cron/checkdbs"
  user "mailman"
end

cron "mailman-disabled" do
  hour "9"
  minute "0"
  command "/opt/local/bin/python2.7 -S /opt/local/lib/mailman/cron/disabled"
  user "mailman"
end

cron "mailman-senddigests" do
  hour "12"
  minute "0"
  command "/opt/local/bin/python2.7 -S /opt/local/lib/mailman/cron/senddigests"
  user "mailman"
end

cron "mailman-mailpasswds" do
  hour "5"
  minute "0"
  day "1"
  command "/opt/local/bin/python2.7 -S /opt/local/lib/mailman/cron/mailpasswds"
  user "mailman"
end

cron "mailman-nightly_gzip" do
  hour "3"
  minute "27"
  command "/opt/local/bin/python2.7 -S /opt/local/lib/mailman/cron/nightly_gzip"
  user "mailman"
end

cron "mailman-cull_bad_shunt" do
  hour "4"
  minute "30"
  command "/opt/local/bin/python2.7 -S /opt/local/lib/mailman/cron/cull_bad_shunt"
  user "mailman"
end

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

service "pkgsrc/mailman" do
  action [:enable, :restart]
end
