# Azure Infrastructure Resources

This repository contains OpenTofu modules for managing the Azure infrastructure.

## Usage

- Feel free to change the name of the default development shell in `flake.nix`.

```bash
nix develop
```

- Copy `example.envrc` to `.envrc` and set the variables you see there.
- Open `storage/terraform.tfvars` and set the variables you see there.

```bash
# Exit and re-enter the development shell to update the environment variables you set in .envrc
exit
nix develop

ts init
ts plan
ts apply
```

- Open `root/terraform.tfvars` and set the variables you see there.
- Open `root/providers.tf` and use the `resource_group_name` and `storage_account_name` that was output from the last `ts apply` command to set the missing values.

```bash
t init

t workspace new test-staging
t plan
t apply

t workspace new test-prod
t plan
t apply
```

## FAQ

### How to override `atm-scripts`?

Here's an example that shows how to override the version of PostgreSQL that's used.

```nix
pkgs = import nixpkgs {
  inherit system;
  overlays = [
    azure-tofu-modules.overlays.default
    (final: prev: {
      atm-scripts = prev.atm-scripts.override { postgresqlPackage = final.postgresql_14; };
    })
  ];
};
```

- [Overlays](https://nixos.org/manual/nixpkgs/stable/#chap-overlays)
- [Overriding](https://nixos.org/manual/nixpkgs/stable/#chap-overrides)

### How to resolve errors for SKU not available?

- [Resolve errors for SKU not available](https://learn.microsoft.com/en-us/azure/azure-resource-manager/troubleshooting/error-sku-not-available?tabs=azure-cli)

To determine which SKUs are available in a location or zone, use the `az vm list-skus` command. For e.g.

```bash
az vm list-skus --location CanadaCentral --size Standard_A --all --output table
```
