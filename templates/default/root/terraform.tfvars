#
# Learn more: https://opentofu.org/docs/v1.10/language/values/variables/#variable-definitions-tfvars-files
#
# Please take a look at ./variables.tf to see all the variables you can set here.
#

name = ""

vm_size = ""

db_admin_username = ""

db_name = ""

#
# Try `curl ifconfig.me` to get your public IP address.
#
firewall_rules = {
  example = {
    start_ip_address = ""
    end_ip_address   = ""
  }
}
