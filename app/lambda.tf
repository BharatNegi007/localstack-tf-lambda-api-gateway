data "archive_file" "this" {
  type        = "zip"
  source_dir  = "${path.module}/nodejs"
  output_path = local.lambda_zip_name

  depends_on = [
    random_string.r
  ]
}

resource "aws_iam_role" "this" {
  name = "${local.function_name}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name   = "policy"
    policy = data.aws_iam_policy_document.this.json
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:AssignPrivateIpAddresses",
      "ec2:UnassignPrivateIpAddresses"
    ]

    effect = "Allow"

    resources = [
      "*"
    ]
  }
}

resource "aws_lambda_function" "this" {
  count = local.create && var.create_function && !var.create_layer ? 1 : 0

  function_name                      = local.function_name
  description                        = var.description
  role                               = aws_iam_role.this.arn
  handler                            = var.package_type != "Zip" ? null : var.handler
  memory_size                        = var.memory_size
  runtime                            = var.runtime
  architectures                      = var.architectures
  package_type                       = var.package_type
  filename                           = local.lambda_zip_name
}
