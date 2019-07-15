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
