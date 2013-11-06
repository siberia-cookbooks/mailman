#
# Cookbook Name:: mailman
# Attributes:: default
#
# Copyright 2012, Jacques Marneweck.
#
# All rights reserved - Do Not Redistribute
#

default['mailman'] = {
  'uid' => '110',
  'gid' => '110',
  'mailman_home' => '/var/db/mailman',
  'mailman_owner' => 'mailman@lists.example.com',
  'mailman_list_owner' => 'example@example.com',
  'mailman_list_password' => 'changeme',
  'mailman_site_password' => 'changeme',
  'mailman_create_password' => 'changeme',
  'mta' => 'postfix',
  'python_version' => '2.7'
}
