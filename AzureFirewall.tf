
# Public IP used by Azure Firewall
resource "azurerm_public_ip" "Terra-publicip-azurefirewall" {
  name                = "publicip-azurefw"
  resource_group_name = azurerm_resource_group.Terra_aks_rg.name
  location            = azurerm_resource_group.Terra_aks_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Azure Firewall 
# cf. https://www.terraform.io/docs/providers/azurerm/r/firewall.html
resource "azurerm_firewall" "Terra-azurefirewall" {
  name                = "azurefirewall"
  resource_group_name = azurerm_resource_group.Terra_aks_rg.name
  location            = azurerm_resource_group.Terra_aks_rg.location
  zones               = var.az-firewall

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.Terra_aks_firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.Terra-publicip-azurefirewall.id
  }
}

# User Define Route to use Azure Firewall 
# cf. https://www.terraform.io/docs/providers/azurerm/r/route_table.html
resource "azurerm_route_table" "Terra-route-azurefirewall" {
  name                          = "route-azurefirewall"
  resource_group_name = azurerm_resource_group.Terra_aks_rg.name
  location            = azurerm_resource_group.Terra_aks_rg.location
  disable_bgp_route_propagation = false
  depends_on = [azurerm_firewall.Terra-azurefirewall]

  route {
    name           = "route-to-internet"
    address_prefix = "0.0.0.0/24"
    # expected route.0.next_hop_type to be one of [VirtualNetworkGateway VnetLocal Internet VirtualAppliance None]
    next_hop_type = "VirtualAppliance"
    # Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance.
    next_hop_in_ip_address = azurerm_firewall.Terra-azurefirewall.ip_configuration[0].private_ip_address
  }

  tags = {
    environment = "Production"
  }
}
