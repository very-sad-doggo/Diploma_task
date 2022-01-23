resource "azurerm_virtual_network" "vnet" {
  name          = "vnet-${terraform.workspace}"
  address_space = ["${lookup(var.address_space, terraform.workspace)}"]

  #  address_space       = ["${var.address_space[terraform.workspace]}"]
  location            = "${var.location}"
  resource_group_name = "${var.res_group_name}"

  tags = {
    environment = "${terraform.workspace}"
  }
}