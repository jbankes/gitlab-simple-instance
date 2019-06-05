#
# variables for Gitlab pov
#

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "domain" {
  description = "the domain to use for the hosted zone and access"
}
