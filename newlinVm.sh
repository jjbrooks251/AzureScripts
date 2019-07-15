echo "Do you want to make a new resouce group? [y/n]"
read optg

echo $optg

if [ $optg = y ]
then
	sh ./azure/makeGroup.sh
else
	echo "enter existing group name"
	read groupName
	export groupName=$groupName
fi

sh ./azure/linuxVm.sh

echo "Do you wish to expose ports on the vm? [y/n]"
read optp

if [ $optp = y ]
then
	sh ./azure/ports.sh
fi

sh ./azure/ip.sh

echo "Do you want resources to be installed onto your vm? [y/n]"
read opti

if [$opti = y ]
then
	sh ./azure/filecopy.sh
else
	ssh ${whoami}@${ip}
fi


