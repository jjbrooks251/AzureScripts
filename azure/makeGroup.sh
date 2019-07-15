echo "choose a name of the resource group"
read groupName

az group create --name ${groupName} --location uksouth
export groupName=$groupName

