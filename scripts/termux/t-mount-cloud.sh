#!/bin/bash
sudo nsenter -t 1 -m -- \
sudo rclone mount nextcloud: /storage/emulated/0/Cloud \
	--gid 9997 \
	--dir-perms 0771 \
	--file-perms 0660 \
	--umask=0 \
	--allow-other \
	--vfs-cache-mode full \
	--vfs-cache-max-size 10G \
	--vfs-cache-max-age 48h \
	--vfs-fast-fingerprint \
	--vfs-write-back 20s \
	--attr-timeout 20s \
	--dir-cache-time 1000h \
	--cache-chunk-size 8M \
	--buffer-size 1G \
    --no-checksum \
    --no-modtime
