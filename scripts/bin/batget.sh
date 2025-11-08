#!/bin/sh

find /sys/devices -name capacity -exec cat {} \;
