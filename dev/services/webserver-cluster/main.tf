provider "aws" {
  region = "us-west-1"
}

module "webserver-cluster" {
  source        = "../../../modules/services/webserver-cluster"
  cluster_name  = "webserver-dev"
  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2
  database_address = data.terraform_remote_state.db.outputs.database_address
  database_port = data.terraform_remote_state.db.outputs.database_port
  template_name = "terraform-lt-dev"
  security_group_name = "terraform-alb-sg-dev"
  target_group_name = "terraform-tg-dev"
  load_balancer_name = "terraform-alb-dev"
  machine_image = "ami-04f7a54071e74f488"
}

output "alb_dns_name" {
  value       = module.webserver-cluster.alb_dns_name
  description = "The dns name of the load balancer"
}