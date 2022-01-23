provider "azurerm" {
  features {}
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

module "res_group" {
  source   = "./resource_group"
  location = "${var.location}"
}

module "vnet" {
  source         = "./base/VNet"
  address_space  = "${var.address_space}"
  location       = "${var.location}"
  res_group_name = "vladimir-ryadovoy-diploma"
}

module "security_group" {
  source         = "./base/security_group"
  location       = "${var.location}"
  res_group_name = "vladimir-ryadovoy-diploma"
}

module "subnet" {
  source           = "./base/subnet"
  res_group_name   = "vladimir-ryadovoy-diploma"
  net_sec_group_id = "${module.security_group.net_sec_group_id}"
  vnet_name        = "${module.vnet.vnet_name}"
  address_prefixes  = ["10.20.0.0/24"]
}

module "k8s" {
  source         = "./aks_cluster"
  res_group_name = "vladimir-ryadovoy-diploma"
  subnet_id      = "${module.subnet.subnet_id}"
  location       = "${var.location}"
  ssh_public_key = "${var.ssh_public_key}"
  agent_count    = "${var.agent_count}"
  client_id      = "${var.client_id}"
  client_secret  = "${var.client_secret}"
}

module "psql" {
  source                 = "./psql"
  location               = "${var.location}"
  res_group_name         = "vladimir-ryadovoy-diploma"
  pgsql_capacity         = "${var.pgsql_capacity}"
  pgsql_tier             = "${var.pgsql_tier}"
  pgsql_storage          = "${var.pgsql_storage}"
  pgsql_backup           = "${var.pgsql_backup}"
  pgsql_redundant_backup = "${var.pgsql_redundant_backup}"
  pgsql_password         = "${var.pgsql_password}"
}