locals {
  group_to_location = merge({
    test = "Canada Central"
  }, var.group_to_location)

  parts       = split("-", terraform.workspace)
  group       = element(local.parts, 0)
  environment = element(local.parts, 1)

  prefix   = "${var.name}-${local.group}-${local.environment}"
  location = local.group_to_location[local.group]
  is_prod  = local.environment == "prod"
  num_vms  = local.is_prod ? 4 : 1
}

check "local_environment_check" {
  assert {
    condition     = contains(var.allowed_environments, local.environment)
    error_message = "${local.environment} is not an allowed environment, expected: ${join(", ", var.allowed_environments)}"
  }
}

module "network" {
  source = "git@github.com:GoSteadily/azure-tofu-modules//network"

  name      = local.prefix
  location  = local.location
  addresses = var.addresses
}

module "vm" {
  source = "git@github.com:GoSteadily/azure-tofu-modules//vm"
  count  = local.num_vms

  name           = local.num_vms == 1 ? "${local.prefix}" : "${local.prefix}-${count.index}"
  resource_group = module.network.resource_group
  subnet_id      = module.network.subnet_id
  vm_size        = var.vm_size
}

module "db" {
  source = "git@github.com:GoSteadily/azure-tofu-modules//db"

  name           = local.prefix
  resource_group = module.network.resource_group

  admin_username = var.db_admin_username
  db_name        = var.db_name

  firewall_rules = var.firewall_rules

  use_general            = local.is_prod
  use_pgbouncer          = local.is_prod
  extra_pgbouncer_config = local.is_prod ? var.extra_pgbouncer_config : {}
}
