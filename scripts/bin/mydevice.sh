#!/bin/sh

sudo arp-scan --localnet 2>/dev/null | \
    grep -oP '^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | \
    parallel -j 20 'for port in 22 8022; do if nc -z -w 1 {} "$port" 2>/dev/null; then echo {}:"$port"; fi; done'
