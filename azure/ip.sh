ip=$(az vm list-ip-addresses -g ${groupName} -n ${vm} | grep ipAddress | cut -d '"' -f4)
echo $ip
export ip=$ip
