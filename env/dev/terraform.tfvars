rg_name  = "rg-dev2"
location = "Central India"

vnet_name     = "vnet-dev"
address_space = ["10.0.0.0/16"]

# subnets = {
#   frontend = "10.0.1.0/24"
#   backend  = "10.0.2.0/24"
# }
subnets = {
  frontend = {
    address_prefix = ["10.0.1.0/24"]
  }
  backend = {
    address_prefix = ["10.0.2.0/24"]
  }
  database = {
    address_prefix = ["10.0.3.0/24"]
  }
}

vms = {
  frontend-vm = {
    subnet = "frontend"
    size   = "Standard_B1s"
  }

  backend-vm = {
    subnet = "backend"
    size   = "Standard_B1s"
  }
}

admin_username = "adminuser"
admin_password = "adminuser*123"

kv_name   = "nevalosskeyvault3456"
kv_rg_name = "rg-dev"
secret_username_name = "vm-username"
secret_password_name = "vm-password"
db_user_secret = "db-username"
db_pass_secret = "db-password"

