#!/usr/bin/env bash

source ./etc/monitor/include/variables.sh

echo "You want install the scipt and had read the Readme? yes|no"
read -r install

if [[ "$install" = yes ]]; then
	if [[ $EUID -ne 0 ]]; then
		echo "To install the Script we need root access!"
		exit 1
	else
		install -D -m 755 -o root bin/ping.sh $bin
		install -D -m 755 -o root bin/monitor.sh $bin
		install -D -m 755 -o root bin/html.sh $bin

		if [[ $(strings /sbin/init | grep -q "/lib/systemd") ]]; then
			install -D -m 644 -o root etc/systemd/system/monitor-sh.service $systemd
			install -D -m 644 -o root etc/systemd/system/monitor-sh.timer $systemd
		fi

		rm -r ./bin ./etc/systemd
		mkdir $etc

		if [[ -d $etc ]]; then
			cp -rv ./etc/monitor/html $etc
			cp -rv ./etc/monitor/include $etc
		fi

		# write the clients file
		echo "files are copied, you have filled up the hosts.txt? yes|no"
		read -r hostswrite

		if [[ "$hostswrite" = yes ]]; then
			cp ./etc/monitor/hosts.txt $etc
		fi

		# html page generation
		echo "you want generate a html page? yes|no"
		read -r htmlpage

		if [[ "$htmlpage" = yes ]]; then
			echo "please give me the webpath? "
			read -r webdir

			if [[ -d "$webdir" ]]; then
				echo "webdir='$webdir'" >> $etc/include/variables.sh
			else
				mkdir $webdir
				echo "webdir='$webdir'" >> $etc/include/variables.sh
			fi
		else
			echo "webdir=''" >> $etc/include/variables.sh
		fi

		# should send mail
		echo "you want become email when host is down? yes|no"
		read -r mail

		if [[ "$mail" = "yes" ]]; then
			echo "can I ask for your mail adress? "
			read -r mailadress

			if [[ -z "$mailadress" ]]; then
				echo "We need a mailadress"
			else
				echo "mailadress='$mailadress'" >> $etc/include/variables.sh
			fi
		else
			echo "$mailadress=''" >> $etc/include/variables.sh
		fi

		# activate it
		echo "all is written now we should the script activate? yes|no"
		read -r activate

		if [[ "$activate" = yes ]]; then
			# systemd
			if [[ $(strings /sbin/init | grep -q "/lib/systemd") ]]; then
				systemctl daemon-reload
				systemctl enable --now monitor-sh.timer
			fi
		fi		
	fi

	exit 1
fi

if [[ "$1" = uninstall ]]; then
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