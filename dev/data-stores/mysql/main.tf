provider "aws" {
  region = "us-west-1"
}

data "aws_secretsmanager_secret_version" "db_dev" {
  secret_id = "dev/db_creds"
}

locals {
  db_credentials = jsondecode(data.aws_secretsmanager_secret_version.db_dev.secret_string)
}

module "mysql" {
  source = "git::https://github.com/jakefurlong/modules.git//data-stores/mysql?ref=v0.0.3"

  db_username            = local.db_credentials["username"]
  db_password            = local.db_credentials["password"]
  db_identifier_prefix   = "terraform-dev"
  db_engine              = "mysql"
  db_allocated_storage   = 10
  db_instance_class      = "db.t3.micro"
  db_skip_final_snapshot = true
  database_name          = "mysqldev"
}

output "database_address" {
  description = "Full DNS name of the RDS database"
  value       = module.mysql.address
}

output "database_port" {
  description = "Port of the RDS database"
  value       = module.mysql.port
}