resource "random_password" "db_password" {
  length           = 20
  override_special = "+-_"
}

resource "azurerm_postgresql_flexible_server" "this" {
  name                = "${var.name}-db"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  version             = var.server_version

  administrator_login    = var.admin_username
  administrator_password = random_password.db_password.result

  backup_retention_days = var.backup_retention_days
  sku_name              = var.use_general ? var.general_sku_name : var.burstable_sku_name
  zone                  = var.allow_azure_to_choose_zone ? null : var.zone
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  name      = var.db_name
  server_id = azurerm_postgresql_flexible_server.this.id
  #
  # Prevent the possibility of accidental data loss.
  #
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "azure" {
  name      = "azure"
  server_id = azurerm_postgresql_flexible_server.this.id

  #
  # Allow public access from any Azure service within Azure to this server.
  #
  # re: https://github.com/hashicorp/terraform-provider-azurerm/issues/13873#issuecomment-1007339452
  #
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "user" {
  for_each = var.firewall_rules

  name             = each.key
  server_id        = azurerm_postgresql_flexible_server.this.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address

  lifecycle {
    ignore_changes = [
      start_ip_address,
      end_ip_address
    ]
  }
}

locals {
  pgbouncer = {
    "pgbouncer.enabled"             = "true"
    "metrics.pgbouncer_diagnostics" = "on"
  }

  pgbouncer_config = {
    #
    # N.B. It's slightly less than 50 since Azure uses some connections
    #
    "pgbouncer.default_pool_size" = var.pgbouncer_default_pool_size
  }
}

check "pgbouncer_availability_check" {
  assert {
    condition     = !var.use_pgbouncer || (var.use_pgbouncer && var.use_general)
    error_message = "PgBouncer is only available in the General Purpose pricing tier"
  }
}

resource "azurerm_postgresql_flexible_server_configuration" "pgbouncer" {
  for_each = var.use_pgbouncer ? local.pgbouncer : {}
  name     = each.key
  value    = each.value

  server_id = azurerm_postgresql_flexible_server.this.id
}

resource "azurerm_postgresql_flexible_server_configuration" "pgbouncer-config" {
  # pgbouncer.enabled must be set to true before
  # we can set any of the pgbouncer configurations
  depends_on = [azurerm_postgresql_flexible_server_configuration.pgbouncer]

  for_each = var.use_pgbouncer ? local.pgbouncer_config : {}
  name     = each.key
  value    = each.value

  server_id = azurerm_postgresql_flexible_server.this.id
}
