mailman Cookbook [![Build Status](https://travis-ci.org/siberia-cookbooks/mailman.svg?branch=master)](https://travis-ci.org/siberia-cookbooks/mailman)
======================================================================================================================================================

[![Code Climate](https://codeclimate.com/github/siberia-cookbooks/mailman.png)](https://codeclimate.com/github/siberia-cookbooks/mailman)

Installs and configures mailman.  When using Postfix as the MTA, it installs
a postfix-to-mailman.py wrapper script and requires that the user still
manually adds some lines to their main.cf and master.cf

Requirements
------------

 * Chef
 * Git
 * Internet Access
 * An MTA (presently exim/postfix) - more integration work to update
   configuration files still needs to be done.

Attributes
----------

e.g.
#### mailman::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['mailman']['uid']</tt></td>
    <td>Integer</td>
    <td>user identifier for the mailman user</td>
    <td>110</td>
  </tr>
  <tr>
    <td><tt>['mailman']['gid']</tt></td>
    <td>Integer</td>
    <td>group identifier for the mailman group</td>
    <td>false</td>
  </tr>
  <tr>
    <td><tt>['mailman']['mailman_home']</tt></td>
    <td>String</td>
    <td>mailmans home dir</td>
    <td>/var/db/mailman</td>
  </tr>
  <tr>
    <td><tt>['mailman']['mailman_owner']</tt></td>
    <td>String</td>
    <td>mailmans home dir</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>['mailman']['mailman_list_owner']</tt></td>
    <td>String</td>
    <td>mailmans home dir</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>['mailman']['mailman_list_password']</tt></td>
    <td>String</td>
    <td>mailmans home dir</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>['mailman']['mailman_site_password']</tt></td>
    <td>String</td>
    <td>mailmans home dir</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>['mailman']['mta']</tt></td>
    <td>String</td>
    <td>mta being used</td>
    <td>postfix</td>
  </tr>
  <tr>
    <td><tt>['mailman']['python_version']</tt></td>
    <td>String</td>
    <td>used to fix which python binary to use when using pkg_alternatives</td>
    <td>2.7</td>
  </tr>
</table>

Example JSON:

```json
{
  "mailman": {
    "uid": "110",
    "gid": "110",
    "mailman_home": "/var/db/mailman",
    "mailman_owner": "mailman@lists.example.com",
    "mailman_list_owner": "example@example.com",
    "mailman_list_password": "changeme",
    "mailman_site_password": "changeme",
    "mta": "postfix",
    "python_version": "2.7"
  }
}
```

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
