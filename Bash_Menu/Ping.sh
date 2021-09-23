#!/bin/bash
#IP Ping Menu

#title banner
figlet -f 3d.flf "IP Ping" | lolcat -S 60 -p 5

#define array for menu options
PS3=$'\e[01;37mPlease enter your choice for IP Ping: \e[0m'
options=("Single Target (IP)" "Single Target (Hostname)" "Ping Subnet" "Ping Subnet (Fast)" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Single Target (IP)")
            echo "Enter IP (e.g. 8.8.8.8)"
            read ip
            ping -c 5 $ip | tee $dirname/Single_Target_IP_Ping.txt
            ;;
        "Single Target (Hostname)")
            echo "Enter Hostname (e.g. google.com)"
            read host
            ping -c 5 $host | tee $dirname/Single_Target_Host_Ping.txt
            ;;
        "Ping Subnet")
            echo "Enter Subnet Range (first 3 octects ONLY e.g. 192.168.0)"
            read subnet
            for i in $(seq 1 254); do ping -c 1 $subnet.$i | tee $dirname/Subnet_Ping.txt | grep --color=always "bytes from" ;done | pv
            ;;
            #PV needs installing sudo apt-get pv
	"Ping Subnet (Fast)")
	    echo "Enter Subnet Range (first 3 octects ONLY eg. 192.168.0)"
	    read subnet
	    for ip in $(seq 1 255); do
		    ping -c 1 $subnet.$ip | grep --color=always "bytes from" | tee $dirname/Subnet_Ping_Fast.txt | cut -d":" -f1 &
	    done
	    ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
clear
#display main menu options
figlet -f 3d.flf "BurgerPing" | lolcat -S 60 -p 5
echo "1) Nmap
2) Alternative API Options
3) IP Ping
4) Reports
5) Funny Quote
6) Quit"
