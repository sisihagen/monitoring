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

		### user ask for using systemd
		echo "your system using systemd yes|no"
		read -r systeminit

		if [[ "$systeminit" = yes ]]; then
			install -D -m 644 -o root etc/systemd/system/monitor-sh.service $systemd
			install -D -m 644 -o root etc/systemd/system/monitor-sh.timer $systemd
		fi

		mkdir -p $etc/tmp

		if [[ -d $etc ]]; then
			cp -rv ./etc/monitor/include $etc
		fi

		# write the clients file
		echo "files are copied, you have filled up the hosts.txt? yes|no"
		read -r hostswrite

		if [[ "$hostswrite" = yes ]]; then
			cp -v ./etc/monitor/hosts.txt $etc
		fi

		# html page generation
		echo "you want generate a html page? yes|no"
		read -r htmlpage

		if [[ "$htmlpage" = yes ]]; then
			echo "please give me the webpath? "
			read -r webdir

			if [[ -d "$webdir" ]]; then
				echo "www='$webdir'" >> $etc/include/variables.sh
				echo "web='yes'" >> $etc/include/variables.sh
				cp ./monitoring.css $webdir
			else
				mkdir $webdir
				echo "www='$webdir'" >> $etc/include/variables.sh
				echo "web='yes'" >> $etc/include/variables.sh
				cp ./monitoring.css $webdir
			fi
		else
			echo "www=''" >> $etc/include/variables.sh
			echo "web='no'" >> $etc/include/variables.sh
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
				echo "mail='yes'" >> $etc/include/variables.sh
			fi
		else
			echo "mail='no'" >> $etc/include/variables.sh
		fi

		# activate it
		echo "all is written now we should the script activate? yes|no"
		read -r activate

		if [[ "$activate" = yes ]]; then
			# systemd
			if [[ $(command -v systemctl &> /dev/null) ]]; then
				systemctl daemon-reload
				systemctl enable --now monitor-sh.timer
			else
				if [[ -d "/etc/cron.d" ]]; then
					echo "mailto=$mailadress" >> /etc/cron.d/monitor.sh
					echo "@hourly $bin/monitor.sh" >> /etc/cron.d/monitor.sh
					echo "@hourly $bin/html.sh" >> /etc/cron.d/monitor.sh
					chmod 755 /etc/cron.d/monitor.sh
				fi
			fi
		fi
	fi

	exit 1
fi