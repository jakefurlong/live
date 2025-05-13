provider "aws" {
  region = "us-west-1"
}

module "webserver-cluster" {
  source           = "../../../modules/services/webserver-cluster"
  cluster_name     = "webserver-prod"
  instance_type    = "t3.large"
  min_size         = 2
  max_size         = 2
  database_address = data.terraform_remote_state.db.outputs.database_address
  database_port    = data.terraform_remote_state.db.outputs.database_port
  template_name = "terraform-lt-prod"
  security_group_name = "terraform-alb-sg-prod"
  target_group_name = "terraform-tg-prod"
  load_balancer_name = "terraform-alb-prod"
}

output "alb_dns_name" {
  value       = module.webserver-cluster.alb_dns_name
  description = "The dns name of the load balancer"
}
