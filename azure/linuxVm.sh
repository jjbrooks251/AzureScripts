echo "Enter the name of the vm(s) you wish to add to the group, seperate names by a space"
read vmName

for name in $vmName
do
az vm create -g ${groupName} -n $name --image UbuntuLTS --generate-ssh-keys 
done

export vmName=$vmName
