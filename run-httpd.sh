#!/bin/bash

rm -rf /run/httpd/* /tmp/httpd*

exec /usr/local/apache2/bin/apachectl -DFOREGROUND
