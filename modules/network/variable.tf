variable "location" {}
variable "rg_name" {}
variable "vnet_name" {}
# variable "address_space" {}
variable "address_space" { type = list(string) }
# variable "subnets" {
#     type = map(string)
#     default = {
#       "frontend_subnet" = "10.0.1.0/24"
#     }
   
# }
variable "subnets" {
  type = map(object({
    address_prefix = list(string)
  }))
}

