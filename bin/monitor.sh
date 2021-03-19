#!/usr/bin/env bash
### create file 26.09.2020 ###
### Silvio Siefke <siefke@mail.ru> ###
### Simple Public License (SimPL) ###

source /usr/local/etc/monitor/include/variables.sh
source /usr/local/etc/monitor/include/function.sh

###
###	1. check ping
###
if [[ -s $etc/$clients ]]; then
	$bin/ping.sh
else
	echo "You have filled up the clients file?"
fi


###
###	2. create html files
###
if [[ "$web" = yes ]]; then
	$bin/html.sh
fi

