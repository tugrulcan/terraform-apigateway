resource "aws_s3_bucket" "terraform-serverless-example" {
  bucket = "${var.project_name}-zip"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    prefix  = ""
    enabled = true

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_expiration {
      days = 60
    }
  }

  tags = {
    project    = var.project_name
    created_by = "terraform"
  }
}