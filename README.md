This is a script to monitor server with ping checks. 

#### Installation
Before the setup will start you need to filled up the hosts.txt file in etc folder. After this run the installation. 

```bash
git clone https://github.com/sisihagen/monitoring
cd monitoring
bash install.sh
```

There are some question, if you want have overview with html file give the script the path to web directory and if you want mail give the mail address. To use mail you need to install the mail utils. 

The script run with systemd and this hourly. If you need other settings be free to change it. 
