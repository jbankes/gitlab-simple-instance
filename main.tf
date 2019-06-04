terraform {
  backend "s3" {
    bucket = "gitlab-pov-tfstates"
    key    = "state/gitlab-pov.tfstate"
  }
}

provider "aws" {
  region = "${var.aws_region}"
}

variable "aws_key_pair" {}

resource "aws_ebs_volume" "gitlab" {
  availability_zone = "us-east-1a"
  size              = 30

  tags = {
    Name = "gitlab_pov"
  }
}

resource "aws_instance" "gitlab" {
  ami             = "ami-4bf3d731"
  instance_type   = "t2.medium"
  key_name        = "${var.aws_key_pair}"
  security_groups = ["${aws_security_group.ssh_sg.name}", "${aws_security_group.http_sg.name}", "${aws_security_group.https_sg.name}"]

  tags = {
    Name = "gitlab_pov"
  }
}
