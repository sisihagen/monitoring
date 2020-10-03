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
echo "<ul class=\"row\">"
	for i in "${myclients[@]}"; do
		if [[ $(grep -q "$i DOWN" $log) ]]; then
			echo "<li class=\"alert alert-danger col-6 col-md-4\">"$i"</li>"
		else
			echo "<li class=\"alert alert-success col-6 col-md-4\">"$i"</li>"
		fi
	done
echo "</ul>"
}>> $webdir/$output

# 3. Footer
{
echo "</main>"


echo "<footer class=\"navbar fixed-bottom navbar-light bg-light\">"
	echo "<section class=\"container\">"
		echo "<p class=\"lead\"> Page is gernerated last: "$(LC_ALL=de_DE.utf8 date) "by" $(hostname) "</p>"
	echo "</section>"
echo "</footer>"

echo "</body>"
echo "</html>"
}>> $webdir/$output