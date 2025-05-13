terraform {
  backend "s3" {
    bucket       = "nimbusdevops"
    key          = "terraform-state/stage/data-stores/mysql/terraform.tfstate"
    region       = "us-west-1"
    use_lockfile = true
  }
}