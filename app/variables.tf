# ---------------------
# API GATEWAY
# ---------------------
variable "api_name" {
  type = string
  default = "helloworld-localstack"
}

variable "api_description" {
  type = string
  default = "Test"
}

variable "resource_path" {
  type = string
  default = "/"
}

variable "http_method" {
  type = string
  default = "GET"
}

variable "stage" {
  description = "API Gateway Stage, default to `test`."
  type        = string
  default     = "test"
}

variable "api_domain_name" {
  type        = string
  description = "DNS domain in the AWS account which you own or is linked via NS records to a DNS zone you own, default to `helloworld.myapp.earth`."
  default     = "helloworld.myapp.earth"
}

# ---------------------
# LAMBDA FUNCTIONS
# ---------------------
variable "create_function" {
  type = bool 
  default = true
}

variable "create_layer" {
  type = bool
  default = true
}

variable "runtime" {
  type    = string
  default = "nodejs18.x"
}

variable "description" {
  type    = string
  default = "helloworld-localstack-lambda-function"
}

variable "architectures" {
  type    = list(string)
  default = ["x86_64"]
}

variable "package_type" {
  type    = string
  default = "Zip"
}

variable "handler" {
  type    = string
  default = "handler.hello"
}

variable "memory_size" {
  type    = number
  default = 128
}

# ---------------------
# GENERAL USE
# ---------------------
variable "name" {
  description = "The string that is used in the `name` filed or equivalent in most resources."
  type        = string
  default     = "helloworld-localstack"
}

variable "tags" {
  type    = map(string)
  default = {}
}
