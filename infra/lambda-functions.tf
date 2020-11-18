data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "../example"
  output_path = "../lambda.zip"
}

resource "aws_s3_bucket_object" "file_uploaded" {
  bucket = aws_s3_bucket.terraform-serverless-example.id
  key    = "lambda-function/v${var.app_version}/example.zip"
  source = data.archive_file.lambda_zip.output_path
}

resource "aws_lambda_function" "example" {
  function_name = "ServerlessExample"

  # The bucket name as created earlier with "aws s3api create-bucket"
  s3_bucket        = aws_s3_bucket.terraform-serverless-example.bucket
  s3_key           = aws_s3_bucket_object.file_uploaded.key
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)

  # "main" is the filename within the zip file (main.js) and "handler"
  # is the name of the property under which the handler function was
  # exported in that file.
  handler = "main.handler"
  runtime = "nodejs10.x"

  role = aws_iam_role.lambda_exec.arn

  tags = {
    project    = var.project_name
    created_by = "terraform"
  }
}