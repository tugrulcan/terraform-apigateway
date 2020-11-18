variable "project_name" {
  description = "The default project name"
  default     = "terraform-apigateway-serverless"
}

variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}
variable "region" {
  description = "AWS Region"
  # Europe(Stockholm)
  default     = "eu-north-1"
}

variable "app_version" {
  default = "1.0.1"
}