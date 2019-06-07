#
# variables for Gitlab pov
#

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "aws_key_pair" {
  description = "a key for the instance to be provisioned with"
}

variable "private_key" {
  description = "a local private key for ansible to authenticate with"
}

variable "domain" {
  description = "the domain to use for the hosted zone and access"
}

variable "subdomain" {
  description = "subdomain for the URL"
  default     = "gitlab.pov"
}
