#!/usr/bin/env bash
### create file 26.09.2020 ###
### Silvio Siefke <siefke@mail.ru> ###
### Simple Public License (SimPL) ###
source /usr/local/etc/monitor/include/variables.sh

function create_header()
{
	{
		echo "<!DOCTYPE html>"
		echo "<html lang=\"en\">"
		echo "<head>"
		echo "<meta charset=\"utf-8\">"
		echo "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
		echo "<title>Monitoring</title>"
		echo "<link href=\"monitoring.css\" rel=\"stylesheet\">"
		echo "<style>ul {list-style:none;}</style>"
		echo "</head>"
		echo "<body>"
		echo "<main>"
		echo "<section>"
	}>> $webdir/$output
}

function create_footer()
{
	{
		echo "</main>"
		echo "<footer>"
		echo "<p><small> Update: "$(LC_ALL=de_DE.utf8 date) "by" $(hostname) "</small></p>"
		echo "</footer>"
		echo "</body>"
		echo "</html>"
	}>> $webdir/$output
}
