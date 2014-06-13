#
# Author:: Jacques Marneweck (<jacques@powertrip.co.za>)
# Cookbook Name:: mailman
# Recipe:: cronjobs
#
# Copyright 2012-2014, Jacques Marneweck
#
# All rights reserved - Do Not Redistribute
#

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
