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
    pgsql_password   = "vova123"
EOF
echo terraform.tfvars
cat terraform.tfvars