# VM

Manages the virtual machine.

## Usage

```tf
module "vm" {
  source = "git@github.com:GoSteadily/azure-tofu-modules//vm"

  name           = "my-app"
  resource_group = module.network.resource_group
  subnet_id      = module.network.subnet_id
  vm_size        = "Standard_DS1_v2"
}
```

See the [outputs](../network/outputs.tf) of the `network` module.

## Outputs

```tf
module.vm.ip_address
module.vm.public_key
module.vm.private_key
```

## Documentation

- [`azurerm_linux_virtual_machine`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine)
- [`tls_private_key`](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key)
- [Sizes for virtual machines in Azure](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/overview)
