terraform {
  backend "s3" {
    bucket       = "nimbusdevops"
    key          = "terraform-state/stage/services/webserver-cluster/terraform.tfstate"
    region       = "us-west-1"
    use_lockfile = true
  }
}