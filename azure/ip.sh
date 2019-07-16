echo "Enter the name of the vm you want the ip address for"
read vm

echo "Enter the group the vm belongs too"
read groupName

ip=$(az vm list-ip-addresses -g ${groupName} -n ${vm} | grep ipAddress | cut -d '"' -f4)
echo $ip
