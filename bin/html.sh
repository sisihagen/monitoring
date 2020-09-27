#!/usr/bin/env bash
### create file 26.09.2020 ###
### Silvio Siefke <siefke@mail.ru> ###
### Public Domain ###

source /usr/local/etc/monitor/include/variables.sh
source /usr/local/etc/monitor/include/function.sh
readarray -t myclients < $etc/$clients

# 1. Header
template="$(cat $etc/$tmpl/$header)"
eval "echo \"${template}\"" > $webdir/$output

# 2. Body
{
echo "<ul>"
	for i in "${myclients[@]}"; do
		if [[ $(grep -q "$i DOWN" $log) ]]; then
			echo "<li class=\"down\">"$i"</li>"
		else
			echo "<li class=\"up\">"$i"</li>"
		fi
	done
echo "</ul>"
}>> $webdir/$output

# 3. Footer
{
echo "</main>"


echo "<footer>"
	echo "<span> Page is gernerated last: "$(LC_ALL=de_DE.utf8 date) "by" $(hostname) "</span>"
echo "</footer>"

echo "<script src=\"/static/js/jquery-3.5.1.min.js\"></script>"
echo "</body>"
echo "</html>"
}>> $webdir/$output