# Scripts

Useful utilities for managing the infrastructure.

## Configuration

- `ATM_PROJECT_ROOT` - The root directory of your current project.
- `ATM_WORKING_DIR` - The directory that contains your root module. It defaults to `ATM_PROJECT_ROOT/root`.
- `ATM_PROVISION_DIR` - The directory that contains the Nix configuration for provisioning your virtual machines. It defaults to `ATM_PROJECT_ROOT/provision`.

## Utilities

- [`install-nixos`](./install-nixos) - Install NixOS, using [nixos-anywhere](https://github.com/nix-community/nixos-anywhere), on one or more virtual machines.
- [`login`](./login) - Login via SSH to a given virtual machine.
- [`recreate-vm`](./recreate-vm) - Destroy and recreate a given virtual machine.
- [`restore-db`](./restore-db) - Restore a database from a backup.
- [`save-keys node`](./save-keys) - Save the public and private keys of a given node to separate files.
- [`with-pg-env pg-command`](./with-pg-env) - Run a PostgreSQL command within the proper database context.

## Usage

Here's how to access the scripts in your development environment:

```nix
{
  inputs = {
    azure-tofu-modules = {
      url = "github:GoSteadily/azure-tofu-modules";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, azure-tofu-modules }:
    flake-utils.lib.eachDefaultSystem(system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            azure-tofu-modules.packages.${system}.default
          ];
        };
      }
    );
}
```

By default, the scripts would be prefixed with `atm`. You can change the prefix as follows:

```nix
azure-tofu-modules.packages.${system}.default.override { withPrefix = "custom-prefix"; }
```
