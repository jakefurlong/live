provider "aws" {
  region = "us-west-1"

  default_tags {
    tags = {
      Owner = "team-foo"
      ManagedBy = "terraform"
    }
  }
}

module "mysql" {
  source = "git::https://github.com/jakefurlong/modules.git//data-stores/mysql?ref=v0.0.1"

  db_username            = "admin"
  db_password            = "password"
  db_identifier_prefix   = "terraform-prod"
  db_engine              = "mysql"
  db_allocated_storage   = 10
  db_instance_class      = "db.t3.micro"
  db_skip_final_snapshot = true
  database_name          = "mysqlprod"
}

output "database_address" {
  description = "Full DNS name of the RDS database"
  value       = module.mysql.address
}

output "database_port" {
  description = "Port of the RDS database"
  value       = module.mysql.port
}