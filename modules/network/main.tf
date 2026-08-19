resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets
  name                 = each.key
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefix
}

resource "azurerm_network_security_group" "nsg" {
  for_each = var.subnets

  name                = "${each.key}-nsg"
  location            = var.location
  resource_group_name = var.rg_name
}
resource "azurerm_network_security_rule" "rules" {
  for_each = var.subnets

  name                        = "${each.key}-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_address_prefix  = "*"

  destination_port_range = each.key == "frontend" ? "80" : (
    each.key == "backend" ? "8080" : "1433"
  )

  source_address_prefix = each.key == "frontend" ? "*" : (
    each.key == "backend" ? "10.0.1.0/24" : "10.0.2.0/24"
  )

  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg[each.key].name
}

# Attach NSG
resource "azurerm_subnet_network_security_group_association" "assoc" {
  for_each = var.subnets

  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}
# resource "azurerm_subnet" "bastion_subnet" {
#   name                 = "AzureBastionSubnet"   # 🔥 fixed name
#   resource_group_name  = var.rg_name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.0.2.0/27"]
# }