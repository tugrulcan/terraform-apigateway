provider "aws" {
  version    = "~> 3.15.0"
  profile = "usr_aws_terraform"
  region     = var.region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}
