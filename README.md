Description
===========

Installs and configures mailman.  When using Postfix as the MTA, it installs
a postfix-to-mailman.py wrapper script and requires that the user still
manually adds some lines to their main.cf and master.cf

Requirements
============

 * An MTA (presently exim/postfix) - more integration work to update
   configuration files still needs to be done.

Attributes
==========

 * mailman.uid - user identifier for the mailman user - defaults to 110
 * mailman.gid - group identifier for the mailman group - defaults to 110
 * mailman.mailman_home - mailmans home dir - defaults to /var/db/mailman
 * mailman.mailman_owner
 * mailman.mailman_list_owner
 * mailman.mailman_list_password
 * mailman.mailman_site_password
 * mailman.mta - mta being used (defaults to postfix)
 * mailman.python_version - used to fix which python binary to use when using pkg_alternatives

Example JSON:

  {
    'uid' => '110',
    'gid' => '110',
    'mailman_home' => '/var/db/mailman',
    'mailman_owner' => 'mailman@lists.example.com',
    'mailman_list_owner' => 'example@example.com',
    'mailman_list_password' => 'changeme',
    'mailman_site_password' => 'changeme',
    'mta' => 'postfix',
    'python_version' => '2.7'
  }

Usage
=====

