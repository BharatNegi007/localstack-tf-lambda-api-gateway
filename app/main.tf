locals {
  create          = var.create_function
  apigateway_name = var.api_name
  function_name   = var.name
  lambda_zip_name = "${path.module}/lambda.${random_string.r.result}.zip"
}

resource "random_string" "r" {
  length  = 16
  special = false
}
