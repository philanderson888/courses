echo "======================================================================="
echo "======================================================================="
echo "====           build ubuntu server using azure cli        ============="
echo "======================================================================="
echo "======================================================================="


echo "======================================================================="
echo "====                      homebrew on MAC                 ============="
echo "======================================================================="
#       echo "install from https://brew.sh/"
#       /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo check for homebrew updates
echo brew upgrade
brew upgrade
echo brew update
brew update
brew doctor




echo "======================================================================="
echo "====                      install azurecli                ============="
echo "======================================================================="
#       brew install azure-cli
#       sleep 1
aws_version=$(aws --version)
aws_version="${aws_version:0:16}"
echo aws cli installed of version $aws_version



echo "======================================================================="
echo "====                logging in to azure portal            ============="
echo "======================================================================="
echo
echo
echo
#  az login





echo "============================================================="
echo "====                  azure status                       ===="
echo "============================================================="
echo azure logged in account is ...
az account show --query "user.name" --output tsv
echo
echo
echo
echo "============================================================="
echo "====                 azure account list                  ===="
echo "============================================================="
az account list --query "[].{name:name, cloudName:cloudName, subscriptionId:subscriptionId, tenantId:tenantId}" --output table
echo
echo
echo






echo "============================================================="
echo "====                  create resource group              ===="
echo "============================================================="
resource_group_name=ResourceGroup02
resource_group_location=uksouth
echo creating resource group $resource_group_name in uk south region
az group create --name $resource_group_name --location $resource_group_location





echo "====================================================================="
echo "====                   view resource group details               ===="
echo "====================================================================="
echo az resource list
az resource list -g $resource_group_name -o table 



echo "====================================================================="
echo "====                        create  keys                         ===="
echo "====================================================================="
ssh_key_public=~/.ssh/azureCliPublicKey.pub


echo "====================================================================="
echo "====                       create vm                             ===="
echo "====================================================================="
vm_os_type_debian=debian
vm_os_ubuntu=ubuntu
vm_image_ubuntu=Ubuntu2204
vm_image=$vm_image_ubuntu
vm_name=vm01
admin_username=azureuser
admin_password=TestPassword123!!
az vm create --name $vm_name --resource-group $resource_group_name  --image $vm_image --admin-username $admin_username --admin-password $admin_password --ssh-key-value $ssh_key_public





















echo "====================================================================="
echo "====                        erase vm                             ===="
echo "====================================================================="

delay_before_erase_all_servers=60
sleep $delay_before_erase_all_servers
az group delete --name $resource_group_name --yes
az group delete --name ResourceGroup01 --yes
az group delete --name ResourceGroup02 --yes
az group delete --name ResourceGroup03 --yes
