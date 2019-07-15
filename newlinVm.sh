echo "Do you want to make a new resouce group? [y/n]"
read optg

echo $optg

if [ $optg = y ]
then
	echo "choose a name of the resource group"
	read groupName

	az group create --name ${groupName} --location uksouth
	export groupName=$groupName
else
	echo "enter existing group name"
	read groupName
	export groupName=$groupName
fi

echo "Do you wish to add new vm's to the specified group? [y/n]"
read optv

if [ $optv = y ]
then
	echo "Enter the name of the vm(s) you wish to add to the group, seperate names by a space"
	read vmName

	for name in $vmName
	do
		az vm create -g ${groupName} -n $name --image UbuntuLTS --generate-ssh-keys 
	done

	export vmName=$vmName
else
	echo "Enter the name of an existing vm to edit"
	read vm
	export vm=$vm
fi

echo "Do you wish to expose ports on the vm? [y/n]"
read optp

if [ $optp = y && $optv = y]
then
	echo $vmName
	echo "Choose a vm from the list above to open ports on"
	read vm

	echo "insert the ports you wish to open, seperate ports by spaces"
	read ports

	for port in $ports
	do
		az vm open-port -g ${groupName} -n ${vm} --port $port
	done

	echo ports opened
	export vm=$vm
	
elif [ $optp = y ]
	echo "insert the ports you wish to open, seperate ports by spaces"
	read ports

	for port in $ports
	do
		az vm open-port -g ${groupName} -n ${vm} --port $port
	done

	echo ports opened
fi

ip=$(az vm list-ip-addresses -g ${groupName} -n ${vm} | grep ipAddress | cut -d '"' -f4)
export ip=$ip

echo "Do you want resources to be installed onto your vm? [y/n]"
read opti

if [$opti = y ]
then
	echo "do you want docker on your vm? [y/n]"
	read optd

	echo "do you want jenkins on your vm? [y/n]"
	read optj

	echo "do you want maven on your vm? [y/n]"
	read optm

	touch runme.sh
	chmod +x ./runme.sh

	if [ $optd = y ]
	then
		chmod +x /home/${whoami}/scripts/install/docker.sh
		scp /home/${whoami}/scripts/install/docker.sh ${whoami}@${ip}:/home/${whoami}
		chmod -x /home/${whoami}/scripts/install/docker.sh
	fi

	if [ $optj = y ]
	then
		chmod +x /home/${whoami}/scripts/install/jenkins.sh
		scp /home/${whoami}/scripts/install/jenkins.sh ${whoami}@${ip}:/home/${whoami}
		chmod -x /home/${whoami}/scripts/install/jenkins.sh
	fi

	if [ $optm = y ]
	then
		chmod +x /home/${whoami}/scripts/install/maven.sh
		scp /home/${whoami}/scripts/install/maven.sh ${whoami}@${ip}:/home/${whoami}
		chmod -x /home/${whoami}/scripts/install/maven.sh
	fi

	scp ./runme.sh ${whoami}@${ip}:/home/${whoami}
	chmod -x ./runme.sh

	ssh ${whoami}@${ip}
else
	ssh ${whoami}@${ip}
fi


