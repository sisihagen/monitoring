#!/usr/bin/env bash
### create file 26.09.2020 ###
### Silvio Siefke <siefke@mail.ru> ###
### Public Domain ###

###
### Setup
###
etc='/usr/local/etc/monitor'
bin='/usr/local/bin'
log='/var/log/monitor.log'

###
### files
###
clients='hosts.txt'
header='header.html'
output='index.html'


###
### folders
###
tmpl='html'
systemd='/etc/systemd/system'