# data "azurerm_key_vault_secret" "vm_username" {
#   name         = "vm-username"
#   key_vault_id = var.kv_id
# }

# data "azurerm_key_vault_secret" "vm_password" {
#   name         = "vm-password"
#   key_vault_id = var.kv_id
# }
resource "azurerm_public_ip" "pip" {
 for_each = var.vms
  name                = "${each.key}-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
}
resource "azurerm_network_interface" "nic" {
  for_each = var.vms
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnets[each.value.subnet]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip[each.key].id
  }
}
resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.vms
  name                = each.key
  resource_group_name = var.rg_name
  location            = var.location
  size                = each.value.size

  # admin_username = data.azurerm_key_vault_secret.vm_username.value
  # admin_password = data.azurerm_key_vault_secret.vm_password.value
  admin_username = var.vm_username
  admin_password = var.vm_password

  disable_password_authentication = false

  network_interface_ids = [
   azurerm_network_interface.nic[each.key].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}