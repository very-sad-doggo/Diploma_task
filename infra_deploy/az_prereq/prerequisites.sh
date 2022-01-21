#!/bin/bash

#Create Resource Group
az group create --name vladimir-ryadovoy-diploma --location ukwest

#Create Storage account
az storage account create \ 
-n tfstorage_acc \ 
-g vladimir-ryadovoy-diploma \ 
-l ukwest --sku Standard_LRS

#Tag Storage Acc

az resource tag \ 
--tags Environment=Prod \ 
Resource=tfstate \ 
-g vladimir-ryadovoy-diploma \ 
-n tfstorage_acc \ 
--resource-type "Microsoft.Storage/storageAccounts"

#create container for tfstate file

ACCOUNT_KEY="$(az storage account keys list -g vladimir-ryadovoy-diploma -n tfstorage_acc --query [0].value -o tsv)"

az storage container create \ 
-n tfstate \ 
--account-name tfstorage_acc \ 
--account-key $ACCOUNT_KEY