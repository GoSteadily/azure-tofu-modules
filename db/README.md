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

### Firewall rules

To set the firewall rules you can do the following:

```tf
module "db" {
  # ...

  firewall_rules = {
    home = {
      start_ip_address = "127.0.0.1"
      end_ip_address   = "127.0.0.1"
    }

    work = {
      start_ip_address = "127.0.0.2"
      end_ip_address   = "127.0.0.2"
    }

    # ...
  }
}
```

You're allowed to change your firewall rules manually in Azure and OpenTofu won't say your state has drifted.

### PgBouncer

You can enable PgBouncer and configure it as follows:

```tf
module "db" {
  # ...

  use_pgbouncer = true
  extra_pgbouncer_config = {
    "pgbouncer.max_prepared_statements" = "10"
  }
}
```

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
