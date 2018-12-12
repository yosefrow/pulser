#!/bin/bash -xe

################
# Name: Pulser
# Author: yosefrow
# Date: 12.12.2018
################

# Check the pulse of services

function resolve-host() {
    local host=$1
    getent ahosts $host | head -n 1 | cut -d ' ' -f 1
}

function resolve-dns-host() {
    local host=$1
    # something with dns
}

function resolve-etc-host() {
    local host=$1
    # something with etchost lookup
}

function icmp-ping-check() {
    local packets=3
    local ip=$1

    ping $ip -c $packets
}

function nmap-check() {
    local host=$1
    ping $host
}

function detect-incapsula() {
    echo detect incapsula
}

function detect-cloudflare() {
    echo detect CloudFlare
}

# other stuff to detect
# Other CDNs
# Firewalls stuff maybe?
# Telnet
# Nmap
# SSH Ping
# isup.me
# curl check with host ip override
# curl check with string

function is-hidden() {
    detect-incapsula
}

function main() {
    local service_host=$1
    local service_port=$2
    local service_ip_override=$3

    # warn about lack of internet bro.

    # info about http_proxy,https_proxy,no_proxy env settings
    # ie. This host is in the no_proxy list
    # because of proxy settings we should really be careful and use the hostname provided to us 

    # info about nameserver who is responding to nslookup and/or /etc/resolv.conf
    # figure out how this relates to using NetworkManager, as that's another storry to get true ns ip

    local resolved_ip="$(resolve-host $service_host)"
    # eventually be smart and warn about using /etc/hosts

    local service_ip=$service_ip_override
     
    if [[ ! "$service_ip_override" ]]; then
        service_ip="$(resolve-host $service_host)"
        if [[ ! "$service_ip" ]]; then
            echo "Your host '"$service_host"' cannot be detected. Thanks for playing.";
            exit
        fi
    fi
    

    local pretty_service="$service_host"
    "$service_port" && $pretty_service+=":$service_port"

    echo attempting to check the pulse of $pretty_service

    icmp-ping-check $service_ip
}

main "${@}"
