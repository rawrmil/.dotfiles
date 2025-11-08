if [ -z $1 ]; then
	echo "./newrepo [REMOTEIP] [PORT] [NAME]"
	exit 1
fi

ssh -p 11911 root@$1 "mkdir /root/repos/$3; cd /root/repos/$3 && git init --bare && exit"

#git clone ssh://root@$1:$2/~/repos/$3
echo "root@$1:$2/root/repos/$3"
