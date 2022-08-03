variable "ssh_public_key" {
  type     = string
  nullable = false
}

output "instance_ip_addr" {
  value = aws_instance.server.public_ip
}


provider "aws" {
  region = "us-west-1"
}


resource "aws_instance" "server" {
  ami                         = "ami-085284d24fe829cd0"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.main.id]
  associate_public_ip_address = true
  key_name                    = "ssh-key"

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    }
  ]
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = var.ssh_public_key
}


