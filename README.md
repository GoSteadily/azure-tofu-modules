# Azure OpenTofu Modules

[OpenTofu](https://opentofu.org/) modules to reuse across all our [Azure](https://azure.microsoft.com/)-based projects.

## Current Modules

- [`db`](./db)
- [`network`](./network)
- [`vm`](./vm)

## Useful Scripts

There are a number of [scripts](./bin) that are useful to have when working on the infrastructure. They are made available as the default package from `flake.nix`.

## Documentation

- [Module Blocks](https://opentofu.org/docs/language/modules/syntax/)
- [Module Sources](https://opentofu.org/docs/language/modules/sources/)
- [The `lifecycle` Meta-Argument](https://opentofu.org/docs/language/meta-arguments/lifecycle/)
- Providers
  - [hashicorp/azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
  - [hashicorp/random](https://registry.terraform.io/providers/hashicorp/random/latest)
  - [hashicorp/tls](https://registry.terraform.io/providers/hashicorp/tls/latest)
