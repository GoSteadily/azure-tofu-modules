# Azure OpenTofu Modules

[OpenTofu](https://opentofu.org/) modules to reuse across all our [Azure](https://azure.microsoft.com/)-based projects.

## Usage

A default template is provided to get you started quickly. To use it, do the following:

```bash
git init project
cd project

nix flake init --template git+ssh://git@github.com/GoSteadily/azure-tofu-modules

git add .
git commit -m "Initial commit"
```

Finally, read the [README](./templates/default#readme) and follow the instructions to finish setting up.

## Modules

- [`db`](./db#readme)
- [`network`](./network#readme)
- [`vm`](./vm#readme)

## Useful Scripts

There are a number of [scripts](./bin#readme) that are useful to have when working on the infrastructure. They are made available as the default package from `flake.nix`.

## Documentation

- [Module Blocks](https://opentofu.org/docs/language/modules/syntax/)
- [Module Sources](https://opentofu.org/docs/language/modules/sources/)
- [The `lifecycle` Meta-Argument](https://opentofu.org/docs/language/meta-arguments/lifecycle/)
- Providers
  - [hashicorp/azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
  - [hashicorp/random](https://registry.terraform.io/providers/hashicorp/random/latest)
  - [hashicorp/tls](https://registry.terraform.io/providers/hashicorp/tls/latest)
