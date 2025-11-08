#!/bin/sh

hascmd() {
	if command -v "$1" 2>&1 >/dev/null; then
		return 0
	fi
	return 1
}

hascmderr() {
	if command -v "$1" 2>&1 >/dev/null; then
		return 0
	fi
	echo "[ERR] No '$1' command"
	return 1
}
