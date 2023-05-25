
provider "aws" {
  region  = var.aws_region

}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">3.0.0"
    }
  }
}
# Test
variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "name" {
  type    = string
  default = "test_name"
}

variable "value" {
  type    = string
  default = "test_value"
  sensitive = true
}

resource "aws_ssm_parameter" "foo" {
  name  = "name-${var.name}"
  # type  = "SecureString"
  type  = "String"
  value = "value-${var.value}"
  tags = {
    environment = "update"
  }
}

output "ssm_value" {
  value = aws_ssm_parameter.foo.value
  sensitive = true
}

