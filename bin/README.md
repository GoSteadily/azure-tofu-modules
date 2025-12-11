# Scripts

Useful utilities for managing the infrastructure.

## Configuration

- `ATM_PROJECT_ROOT` - The root directory of your current project.
- `ATM_WORKING_DIR` - The directory that contains your root module. It defaults to `ATM_PROJECT_ROOT/root`.

## Utilities

- [`save-keys node`](./bin/save-keys) - Save the public and private keys of a given node to separate files.
- [`with-pg-env pg-command`](./bin/with-pg-env) - Run a PostgreSQL command within the proper database context.
- [`recreate-vm`](./bin/recreate-vm) - Destroy and recreate a given virtual machine.
