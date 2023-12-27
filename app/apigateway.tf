resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.this.execution_arn}/*/*"
}
#--------------------------
# Create an API Gateway
#--------------------------

resource "aws_api_gateway_rest_api" "my_api" {
  name        = var.api_name
  description = var.api_description
}

#--------------------------------------
# Create a resource in the API Gateway
#--------------------------------------

resource "aws_api_gateway_resource" "my_resource" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = var.resource_path
}

#----------------------------------
# Create a method for the resource
#----------------------------------
resource "aws_api_gateway_method" "my_method" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.my_resource.id
  http_method   = var.http_method # Change this to your desired HTTP method
  authorization = "NONE"
}

#----------------------------------------------
# Integrate the method with the Lambda function
#-----------------------------------------------
resource "aws_api_gateway_integration" "my_integration" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.my_resource.id
  http_method             = aws_api_gateway_method.my_method.http_method
  integration_http_method = "POST" # Change this to your desired integration HTTP method
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.this.invoke_arn
}

#########################
# Deploy the API Gateway
##########################

resource "aws_api_gateway_deployment" "my_deployment" {
  depends_on = [aws_api_gateway_integration.my_integration]

  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = var.stage # Change this to your desired deployment stage
}
