#!/bin/bash

#Create Resource Group
az group create --name vladimir-ryadovoy-diploma --location ukwest

#Create Storage account
az storage account create \
-n ryadovoystoracc \
-g vladimir-ryadovoy-diploma \
-l ukwest --sku Standard_LRS

#Tag Storage Acc

az resource tag \
--tags Environment=Prod \
Resource=tfstate \
-g vladimir-ryadovoy-diploma \
-n ryadovoystoracc \
--resource-type "Microsoft.Storage/storageAccounts"

#create container for tfstate file

ACCOUNT_KEY="$(az storage account keys list -g vladimir-ryadovoy-diploma -n ryadovoystoracc --query [0].value -o tsv)"

az storage container create \
-n tfstate \
--account-name ryadovoystoracc \
--account-key $ACCOUNT_KEY

#Populate backend.tfvars file

cat <<EOF > backend.tfvars
    resource_group_name   = "vladimir-ryadovoy-diploma"
    storage_account_name  = "ryadovoystoracc"
    container_name        = "tfstate"
    access_key            = "$ACCOUNT_KEY"
    key                   = "terraform.tfstate"
EOF
echo backend.tfvars
cat backend.tfvars

#!/bin/bash

#Get AppOwner Tennant ID
AZ_TENANT_ID=$(az ad sp list --display-name epm-rdsp-azure-devops --query "[].appOwnerTenantId" --out tsv)
#Get subscription ID 
SUBSCRIPTION_ID=$( az account list --query "[?isDefault].id" -o tsv )
#Get Client ID
SERVICE_PRINCIPAL_ID=$(az ad sp list --display-name epm-rdsp-azure-devops --query '[].appId' -o tsv)
SERVICE_PRINCIPAL_OBJECT_ID=$(az ad sp list --display-name epm-rdsp-azure-devops --query '[].objectId' -o tsv)

#prepare terraform.tfvars file
cat <<EOF > terraform.tfvars
    subscription_id = "$SUBSCRIPTION_ID"
    client_id       = "$SERVICE_PRINCIPAL_ID"
    client_secret   = "Wye7Q~JKsFwuLOw11euTt4EHupLWcLIVNyjoU"
    tenant_id       = "$AZ_TENANT_ID"
    pgsql_password   = "Vova&Gena42069"
EOF
echo terraform.tfvars
cat terraform.tfvars