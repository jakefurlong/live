provider "aws" {
  region = "us-west-1"
}

module "webserver-cluster" {
  source           = "../../../modules/services/webserver-cluster"
  cluster_name     = "webserver-stage"
  instance_type    = "t3.small"
  min_size         = 2
  max_size         = 2
  database_address = data.terraform_remote_state.db.outputs.database_address
  database_port    = data.terraform_remote_state.db.outputs.database_port
  template_name = "terraform-lt-stage"
  security_group_name = "terraform-alb-sg-stage"
  target_group_name = "terraform-tg-stage"
  load_balancer_name = "terraform-alb-stage"
  machine_image = "ami-04f7a54071e74f488"
}

output "alb_dns_name" {
  value       = module.webserver-cluster.alb_dns_name
  description = "The dns name of the load balancer"
}
