#!/bin/bash
### DEPRICATED AT THIS POINT
# defaults
export PROJECT_NAME=vladimir-diploma-task 
export ARM_LOCATION="ukwest"
ARM_UNIQUE_STATE_NAME=ryadovoystoracc
export SSH_PUBKEY_PATH="~/.ssh/id_rsa.pub"

# Account IDs
TENANT_ID=$(az account show --query 'homeTenantId' -o tsv)
SUBSCRIPTION_ID=$( az account list --query "[?isDefault].id" -o tsv )
SERVICE_PRINCIPAL_ID=$(az ad sp list --display-name epm-rdsp-azure-devops --query '[].appId' -o tsv)
SERVICE_PRINCIPAL_OBJECT_ID=$(az ad sp list --display-name epm-rdsp-azure-devops --query '[].objectId' -o tsv)

# Resource Group
export ARM_RESOURCE_GROUP_NAME="vladimir-ryadovoy-diploma"; 

# Vault for keys
# ARM_VAULT_NAME="$ARM_UNIQUE_STATE_NAME"
# az keyvault create --location "$ARM_LOCATION" --name "$ARM_VAULT_NAME" --resource-group "$ARM_RESOURCE_GROUP_NAME"


# Backend for the tfstate
export ARM_STORAGE_ACCOUNT_NAME="$ARM_UNIQUE_STATE_NAME"
export ARM_STORAGE_ACCOUNT_KEY=$(az storage account keys list --resource-group $ARM_RESOURCE_GROUP_NAME --account-name $ARM_STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
# export ARM_ACCESS_KEY=$(az keyvault secret show --name terraform-backend-key --vault-name myKeyVault --query value -o tsv)
export ARM_ACCESS_KEY=$ARM_STORAGE_ACCOUNT_KEY

echo "TENANT_ID is $TENANT_ID"

export MSYS_NO_PATHCONV=1
export ARM_SUBSCRIPTION_ID=$SUBSCRIPTION_ID
export ARM_TENANT_ID=$TENANT_ID
export ARM_CLIENT_ID=$SERVICE_PRINCIPAL_ID
export ARM_SERVICE_PRINCIPAL_OBJECT_ID=de6b714b-5431-48d0-aa4d-95df7644446f


# Prepare terraform.tfvars
cat <<EOF > terraform.tfvars
    projectname = "${PROJECT_NAME}"
    region = "${ARM_LOCATION}"
    resource_group_name = "${ARM_RESOURCE_GROUP_NAME}"
    client_id = "${ARM_CLIENT_ID}"
    aks_service_principal_object_id = "${ARM_SERVICE_PRINCIPAL_OBJECT_ID}"
    aks_service_principal_client_secret = "Wye7Q~JKsFwuLOw11euTt4EHupLWcLIVNyjoU"
    virtual_network_name = "VNet-${PROJECT_NAME}"
    aks_subnet_name     = "subnet-${PROJECT_NAME}"
    aks_name            = "aks-cluster-${PROJECT_NAME}"
    vm_user_name        = "${PROJECT_NAME}"
    ssh_public_key = "${SSH_PUBKEY_PATH}"
    storage_account_name= "${ARM_STORAGE_ACCOUNT_NAME}"
    pgsql_password = "vova123"
EOF

echo "terraform.tfvars:"
cat terraform.tfvars
