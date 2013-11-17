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

License and Authors
-------------------

```
Copyright (c) 2012-2013 Jacques Marneweck. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

Authors:

 * Jacques Marneweck (jacques@powertrip.co.za)
