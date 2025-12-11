# Scripts

Useful utilities for managing the infrastructure.

## Configuration

- `ATM_PROJECT_ROOT` - The root directory of your current project.
- `ATM_WORKING_DIR` - The directory that contains your root module. It defaults to `ATM_PROJECT_ROOT/root`.

## Utilities

- [`login`](./bin/login) - Login via SSH to a given virtual machine.
- [`recreate-vm`](./bin/recreate-vm) - Destroy and recreate a given virtual machine.
- [`save-keys node`](./bin/save-keys) - Save the public and private keys of a given node to separate files.
- [`with-pg-env pg-command`](./bin/with-pg-env) - Run a PostgreSQL command within the proper database context.

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
