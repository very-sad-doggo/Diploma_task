variable "address_space" {
  type        = map(string)
  description = "CIDR for the whole VPC"
}

variable "location" {
  description = "Azure location"
}

variable "res_group_name" {
  description = "Azure resource group name"
}