# Azure OpenTofu Modules

[OpenTofu](https://opentofu.org/) modules to reuse across all our [Azure](https://azure.microsoft.com/)-based projects.

## Current Modules

- [`db`](./db)
- [`network`](./network)
- [`vm`](./vm)

## Useful Scripts

There are a number of [scripts](./bin) that are useful to have when working on the infrastructure. They are made available as the default package from `flake.nix`.

## Templates

A default template is provided to get you started quickly. To use it, do the following:

```bash
mkdir project && cd project

nix flake init --template git+ssh://git@github.com/GoSteadily/azure-tofu-modules?ref=add-bash-scripts#default

git init
git add .
git commit -m "Initial commit"
```

Finally, please read the [README](./templates/default) and follow the instructions to finish setting up.

## Documentation

- [Module Blocks](https://opentofu.org/docs/language/modules/syntax/)
- [Module Sources](https://opentofu.org/docs/language/modules/sources/)
- [The `lifecycle` Meta-Argument](https://opentofu.org/docs/language/meta-arguments/lifecycle/)
- Providers
  - [hashicorp/azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
  - [hashicorp/random](https://registry.terraform.io/providers/hashicorp/random/latest)
  - [hashicorp/tls](https://registry.terraform.io/providers/hashicorp/tls/latest)
