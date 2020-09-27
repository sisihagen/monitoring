#!/usr/bin/env bash
### create file 26.09.2020 ###
### Silvio Siefke <siefke@mail.ru> ###
### Public Domain ###

source /usr/local/etc/monitor/include/variables.sh
source /usr/local/etc/monitor/include/function.sh

###
###	1. check ping
###
if [[ -s $etc/$clients ]]; then
	source $bin/ping.sh
else
	echo "You have filled up the clients file?"
fi


###
###	2. create html files
###
if [[ -d "$webdir" ]]; then
	source $bin/html.sh
fi

