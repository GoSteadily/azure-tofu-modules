# Network

Manages a resource group and its virtual network.

## Usage

```tf
module "network" {
  source = "git@github.com:GoSteadily/azure-tofu-modules//network"

  name      = "my-app"
  location  = "Canada Central"
  addresses = "10.0.0.0/16"
}
```

## Outputs

```tf
module.network.resource_group.id
module.network.resource_group.name
module.network.resource_group.location
module.network.subnet_id
```

## Documentation

- [`azurerm_resource_group`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)
- [`azurerm_subnet`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)
