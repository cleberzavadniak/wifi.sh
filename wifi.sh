#!/bin/bash

cmd_basename=$(basename $0)

if [[ $1 == "" || $1 == "-h" || $1 == "--help" || $1 == "help" ]];then
    interface=NONE
    command="help"
elif [[ $2 == "" ]];then
    echo "Usage: $cmd_basename interface-name command [args]"
    exit 1
else
    interface=$1
    command=$2
    shift 2
fi


function list {
    iw $interface scan | egrep '(SSID|)' --color
}

function enter_password {
    ssid=$1
    ssid_path="/tmp/wpa.$(echo $ssid | sed 's:[^a-zA-Z0-9]:-:g')"

    if [[ -f $ssid_path ]];then
        echo "$ssid_path exists. Using it" >&2
        echo "To re-enter this AP passphrase, remove this file" >&2
    else
        echo -n "Enter passphrase: " >&2
        read passphrase
        echo $passphrase | wpa_passphrase $ssid > $ssid_path
    fi
    chmod og-rwx $ssid_path
    echo $ssid_path
}

function connect {
    ssid=$1
    ssid_path=$(enter_password $ssid)
    echo "dhcpcd"
    dhcpcd $interface --timeout 120 &
    echo "wpa_supplicant"
    wpa_supplicant -i $interface -c $ssid_path
    echo "connect.exit"
}

function help {
    echo "Usage:"
    echo "    $cmd_basename <interface> list"
    echo "    $cmd_basename <interface> connect <ap_ssid>"
    echo
    echo "Use ctrl+c to kill the connection"
    echo
    echo "Examples:"
    echo "    $cmd_basename wlan0 list | less  # You can then search for 'SSID'"
    echo "    $cmd_basename wlan0 connect homewifi_XYZ"
}

$command $*
