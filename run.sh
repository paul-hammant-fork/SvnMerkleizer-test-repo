#!/bin/sh

if ! -d "/var/svn/dataset"; then
   svnadmin create /var/svn/dataset
   htpasswd -bc /etc/apache2/conf.d/davsvn.htpasswd harry harrypw
   htpasswd -b /etc/apache2/conf.d/davsvn.htpasswd sally sallypw
   svn import dataset file:///var/svn/dataset -m "dataset checked in"
   svn import secondCommit file:///var/svn/dataset/A/AK/ -m "Ha - take something else, Subversion"
   chgrp -R apache /var/svn/dataset
   chmod -R 775 /var/svn/dataset
fi

httpd -D FOREGROUND
