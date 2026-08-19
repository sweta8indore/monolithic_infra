# variable "subnet_ids" {}

# variable "admin_username" {}
# variable "admin_password" {}
variable "vm_username" {}
variable "vm_password" {}
# variable "kv_id" {}

variable "rg_name" {
}

variable "location" {
}

variable "subnets" {
  description = "Map of subnet IDs"
  type        = map(string)
}

variable "vms" {
  description = "Map of VM configurations"
  type = map(object({
    subnet = string
    size   = string
  }))
}
# variable "kv_name" {
  
# }