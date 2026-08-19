variable "rg_name" {}
variable "location" {}

variable "vnet_name" {}
variable "address_space" {}

variable "admin_username" {}
variable "admin_password" {}

# variable "subnets" {
#   type = map(string)
# }
variable "subnets" {
  type = map(object({
    address_prefix = list(string)
  }))
}

variable "vms" {
  description = "Map of VM configurations"
  type = map(object({
    subnet = string
    size   = string
  }))
}
variable "kv_name" {
  type        = string
  description = "Pehle se bane hue Key Vault ka naam"
}

variable "kv_rg_name" {
  type        = string
  description = "Wo doosra Resource Group jisme Key Vault rakha hai"
}

variable "secret_username_name" {
  type        = string
  description = "Key Vault me username wale secret ka naam"
}

variable "secret_password_name" {
  type        = string
  description = "Key Vault me password wale secret ka naam"
}
variable "db_user_secret" {
  
}
variable "db_pass_secret" {
  
}