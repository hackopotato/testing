variable "subscription_id" {
  default = "12345678-1234-1234-1234-1234567890"
}

variable "ventureName" {
  default = "12345678-1234-1234-1234-1234567890"
}

variable "tenant_id" {
  default = "12345678-1234-1234-1234-1234567890"
}


provider "azurerm" {
    use_msi         = true
    subscription_id = var.subscription_id
    tenant_id       = var.tenant_id
    features {}
}

#### Add your terraform below
resource "azurerm_resource_group" "test" {
  name     = "testResourceGroup1"
  location = "West US"
  
}
