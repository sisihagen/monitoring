#!/usr/bin/env bash
### create file 26.09.2020 ###
### Silvio Siefke <siefke@mail.ru> ###
### Simple Public License (SimPL) ###

source /usr/local/etc/monitor/include/variables.sh
source /usr/local/etc/monitor/include/function.sh

readarray -t myclients < $etc/$clients

# cleaning
if [[ -f $log ]]; then
	truncate -s 0 $log
fi

if [[ -f $etc/$down_log ]]; then
    truncate -s 0 $etc/$down_log
fi

if [[ -f $etc/$up_log ]]; then
    truncate -s 0 $etc/$up_log
fi

# all hosts up
for i in "${myclients[@]}"; do
	echo "$i UP" > $log
done

# check they really up
while true; do
    for i in "${myclients[@]}"; do
	    ping -c1 -4 $i > /dev/null
	        if [[ $? -ne 0 ]]; then
                STATUS=$(grep -q "$i DOWN" $log)
                        if [[ $STATUS != "$i DOWN!" ]]; then
                                echo "$(date): ping failed, $i host is down!"

                                # when mail should be send
                                if [[ ! -z $mailadress ]]; then
                                    mailx -s $i is down $mailadress
                                fi
                        fi
                echo "$i DOWN" >> $log

                # create log file for website generation
                echo "$i" > $etc/$down_log
	        else
                STATUS=$(grep -q "$i UP" $log)
                        if [[ $STATUS != "$i UP!" ]]; then
                                echo "$(date): ping OK, $i host is up!"
                        fi
                echo "$i UP" >> $log

                # create log file for website generation
                echo "$i" >> $etc/$up_log
	        fi
    done
    exit 0
done