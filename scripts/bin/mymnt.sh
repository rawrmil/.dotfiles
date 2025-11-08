#!/bin/bash
# automnt.sh root@192.168.0.122:8022//storage/emulated/0 ~/poco

IFS=@/: read -r ssh_user ssh_ip ssh_port src_dir <<EOF
${string:-$1}
EOF
dst_dir=$2

echo $ssh_user $ssh_ip $ssh_port $src_dir $dst_dir
mkdir -p $dst_dir
sshfs -p $ssh_port $ssh_user@$ssh_ip:$src_dir $dst_dir \
	-d -o uid=$(id -u $USER),gid=$(id -g $USER),allow_other \
	-o "UserKnownHostsFile=/dev/null" \
	-o StrictHostKeyChecking=no
