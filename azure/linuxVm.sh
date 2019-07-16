echo "Enter the name of the vm(s) you wish to add to the group, seperate names by a space"
read vmName

echo "enter an existing group name you wish to add the vm(s) too"
read groupName

for name in $vmName
do
az vm create -g ${groupName} -n $name --image UbuntuLTS --generate-ssh-keys 
done
