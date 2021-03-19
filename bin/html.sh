#!/usr/bin/env bash
### create file 26.09.2020 ###
### Silvio Siefke <siefke@mail.ru> ###
### Simple Public License (SimPL) ###

source /usr/local/etc/monitor/include/variables.sh
source /usr/local/etc/monitor/include/function.sh


### clean file
if [[ -f "$webdir/$output" ]]; then
	rm $webdir/$output
fi

# 1. Header
create_header

# 2. Body
{
	echo "<ul class=\"row\">"
		# read out the down hosts
		if [[ -f $etc/$down_log ]]; then
			while read line; do
				echo "<li class=\"alert alert-danger col-sm-3 mr-1\">"$line"</li>"
			done < $etc/$down_log
		fi

		# read out the hosts which being up
		if [[ -f $etc/$up_log ]]; then
			while read line; do
				echo "<li class=\"alert alert-success col-sm-3 mr-1\">"$line"</li>"
			done < $etc/$up_log
		fi
	echo "</ul>"
	echo "</section>"
}>> $webdir/$output

# 3. Footer
create_footer