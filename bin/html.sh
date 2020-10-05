#!/usr/bin/env bash
### create file 26.09.2020 ###
### Silvio Siefke <siefke@mail.ru> ###
### Simple Public License (SimPL) ###

source /usr/local/etc/monitor/include/variables.sh
source /usr/local/etc/monitor/include/function.sh

readarray -t myclients < $etc/$clients

### clean file
if [[ -f "$webdir/$output" ]]; then
	rm $webdir/$output
fi

# 1. Header
create_header

# 2. Body
{
	echo "<ul class=\"row\">"
		for i in "${myclients[@]}"; do
			if [[ $(grep -q "$i DOWN" $log) ]]; then
				echo "<li class=\"alert alert-danger col-md-4 m-1\">"$i"</li>"
			else
				echo "<li class=\"alert alert-success col-md-4 m-1\">"$i"</li>"
			fi
		done
	echo "</ul>"
}>> $webdir/$output

# 3. Footer
create_footer