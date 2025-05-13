data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = "nimbusdevops"
    key    = "terraform-state/stage/data-stores/mysql/terraform.tfstate"
    region = "us-west-1"
  }
}