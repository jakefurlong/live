provider "aws" {
  region = "us-west-1"
}

module "mysql" {
  source = "git::https://github.com/jakefurlong/modules.git//data-stores/mysql"

  db_username            = "admin"
  db_password            = "password"
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