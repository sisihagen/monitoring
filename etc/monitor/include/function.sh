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
		echo "<link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css\" integrity=\"sha386-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z\" crossorigin=\"anonymous\">"
		echo "<style>ul {list-style:none;}</style>"
		echo "</head>"
		echo "<body>"
		echo "<main>"
		echo "<section class=\"container p-5\">"
	}>> $webdir/$output
}

function create_footer()
{
	{
		echo "</main>"
		echo "<footer class=\"navbar fixed-bottom navbar-light bg-light\">"
		echo "<section class=\"container\">"
		echo "<p><small> Page is gernerated last: "$(LC_ALL=de_DE.utf8 date) "by" $(hostname) "</small></p>"
		echo "</section>"
		echo "</footer>"
		echo "</body>"
		echo "</html>"
	}>> $webdir/$output
}
