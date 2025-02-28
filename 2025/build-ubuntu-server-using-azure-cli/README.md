# build ubuntu server using azure cli

## contents

- [build ubuntu server using azure cli](#build-ubuntu-server-using-azure-cli)
  - [contents](#contents)
  - [introduction](#introduction)
  - [overview](#overview)
  - [install homebrew on MAC](#install-homebrew-on-mac)
  - [install azure cli](#install-azure-cli)
  - [log in to azure](#log-in-to-azure)
  - [query azure account to check we are logged in](#query-azure-account-to-check-we-are-logged-in)
  - [create resource group to hold all our artifacts eg server, networking, security policies etc](#create-resource-group-to-hold-all-our-artifacts-eg-server-networking-security-policies-etc)
  - [create vm](#create-vm)

## introduction

today we are going to go through the basics of building a linux server on Microsoft Azure using the Azure CLI which allows all work to be scripted, executing the build and run of the code and building the server in the cloud, all done as part of the script

this makes your work repeatable and predictable, and although it is more work to set everything up, in the long run it is much easier to run scripts than to build everything from scratch each time

## overview

1. install the azure cli 
2. log in to azure using the azure cli
3. create a workspace on azure where all of our server components will go - server, hard drive, networking, security etc
4. build and run the server
5. interrogate the server
6. obtain the ip address of the server
7. use the ip address to run a script on the server

## install homebrew on MAC

Obviously Windows has a different command line package manager (Choco) so let's run this first on a MAC and we can look at Windows on another video.

So ... firstly install 'HomeBrew' on the MAC

instructions at

https://brew.sh/

uses this script

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

if it's already installed we can verify it's running the latest version

```bash
echo "======================================================================="
echo "====           installing tools - homebrew, azurecli      ============="
echo "======================================================================="
echo check for homebrew updates
echo brew upgrade
brew upgrade
echo brew update
brew update
brew doctor
```

## install azure cli

```bash
brew install azure-cli
sleep 1
aws_version=$(aws --version)
aws_version="${aws_version:0:16}"
echo aws cli installed of version $aws_version
```


## log in to azure 

```bash
echo "======================================================================="
echo "====                logging in to azure portal            ============="
echo "======================================================================="
echo
echo
echo
az login
```

## query azure account to check we are logged in

```bash
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
```

## create resource group to hold all our artifacts eg server, networking, security policies etc

```bash
echo "============================================================="
echo "====                  create resource group              ===="
echo "============================================================="
resource_group_name=ResourceGroup01
resource_group_location=uksouth
echo creating resource group $resource_group_name in uk south region
az group create --name $resource_group_name --location $resource_group_location
```

```bash
echo "====================================================================="
echo "====                   view resource group details               ===="
echo "====================================================================="
echo az resource list
az resource list -g $resource_group_name -o table 
```


## create vm

```bash
vm_os_type_debian=debian
vm_os_ubuntu=ubuntu
vm_image_ubuntu=Ubuntu2204
vm_image=$vm_image_ubuntu
vm_name=vm01
admin_username=azureuser
admin_password=TestPassword123!!
ssh_key_public=~/.ssh/azureCliPublicKey.pub
az vm create --name $vm_name --resource-group $resource_group_name  --image $vm_image --admin-username $admin_username --admin-password $admin_password --ssh-key-value $ssh_key_public
```

