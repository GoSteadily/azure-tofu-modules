# DB

Manages the PostgreSQL database server.

## Usage

```tf
module "db" {
  source = "git@github.com:GoSteadily/azure-tofu-modules//db"

  name           = "my-app"
  resource_group = module.network.resource_group
  admin_username = "admin"
  db_name        = "my-app"
}
```

See the [optional inputs](./variables.tf) to override their defaults.

## Outputs

```tf
module.db.id
module.db.host
module.db.user
module.db.password
module.db.name
```

## Documentation

- [`azurerm_postgresql_flexible_server`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server)
- [`azurerm_postgresql_flexible_server_database`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database)
- [What is Azure Database for PostgreSQL?](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/overview)
