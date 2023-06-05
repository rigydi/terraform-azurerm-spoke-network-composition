#########################################
# This file is for testing purpose only. Remove this file in production scenarios!
#
# The resources created with this file are the hub resources (vnet and private DNS zone)
# to test the functionalities of terraform-azurerm-spoke-network-composition
#########################################

resource "azurerm_resource_group" "hub" {
  provider = azurerm.hub

  name     = var.hub_details.hub_vnet_resource_group_name
  location = var.application_details.location
}

resource "azurerm_virtual_network" "hub" {
  provider = azurerm.hub

  name                = var.hub_details.hub_vnet_name
  resource_group_name = var.hub_details.hub_vnet_resource_group_name
  address_space       = ["10.0.0.0/24"]
  location            = var.application_details.location

  depends_on = [azurerm_resource_group.hub]
}

resource "azurerm_private_dns_zone" "hub" {
  provider = azurerm.hub

  name                = "contoso.com"
  resource_group_name = var.hub_details.hub_vnet_resource_group_name

  depends_on = [azurerm_virtual_network.hub]
}