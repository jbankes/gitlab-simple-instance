terraform {
  backend "s3" {
    bucket = "gitlab-pov-tfstates"
    key    = "state/gitlab-pov.tfstate"
  }
}

provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_ebs_volume" "gitlab" {
  availability_zone = "us-east-1a"
  size              = 30

  tags = {
    Name = "gitlab_pov"
  }
}

resource "aws_instance" "gitlab" {
  ami             = "ami-02eac2c0129f6376b"
  instance_type   = "t2.medium"
  key_name        = "${var.aws_key_pair}"
  security_groups = ["${aws_security_group.ssh_sg.name}", "${aws_security_group.http_sg.name}", "${aws_security_group.https_sg.name}"]

  tags = {
    Name = "gitlab_pov"
  }

  # remote-exec to wait for instance so Ansible doesn't kick off early
  provisioner "remote-exec" {
    inline = "echo 'instance is up'"
  }

  connection {
    type        = "ssh"
    user        = "centos"
    private_key = "${file("${var.private_key}")}"
  }

  # run ansible playbook
  provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_instance.gitlab.public_ip}, -u centos --key-file ${var.private_key} playbook/gitlab.yml -e gitlab_external_url=http://gitlab.pov.${var.domain}"
  }
}

data "aws_route53_zone" "domain" {
  name = "${var.domain}"
}

resource "aws_route53_record" "gitlab" {
  zone_id = "${data.aws_route53_zone.domain.zone_id}"
  name    = "gitlab.pov.${var.domain}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.gitlab.public_ip}"]
}
