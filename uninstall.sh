#!/usr/bin/env bash

source ./etc/monitor/include/variables.sh

echo "You want really remove the script? yes|no"
read -r uninstall

if [[ "$uninstall" = yes ]]; then
	rm -v $bin/{monitor.sh,ping.sh,html.sh}
	rm -v $log
	rm -rv $etc
	systemctl disable --now monitor-sh.timer
	rm -v /etc/systemd/system/monitor-sh.{service,timer}
	systemctl daemon-reload

	echo "All files removed should now remove the folder where you be? yes|no"
	read -p folder

	if [[ "$folder" = yes ]]; then
		rm -r $PWD ; cd
	fi

	exit 1
fi