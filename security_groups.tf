#
## Security Groups for Gitlab POV
# 

resource "aws_security_group" "ssh_sg" {
  name        = "toolchain_allow_ssh"
  description = "All SSH traffic"

  tags {
    Project = "gitlab_pov"
    Name    = "gitlab_sg_ssh"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "http_sg" {
  name        = "toolchain_allow_http"
  description = "All http traffic"

  tags {
    Project = "gitlab_pov"
    Name    = "gitlab_sg_http"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "https_sg" {
  name        = "toolchain_allow_https"
  description = "All https traffic"

  tags {
    Project = "gitlab_pov"
    Name    = "gitlab_sg_https"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
