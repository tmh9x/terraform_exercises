provider "aws" {
  region = "eu-central-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  
  name = "podinfo-vpc"
  cidr = "10.0.0.0/16"
  
  azs             = ["eu-central-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.2.0/24"]
}

module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"
  
  instance_type   = "t2.micro"
  name            = "Podinfo_Instance"
  ami             = "ami-0f7204385566b32d0"
  subnet_id       = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids = [ aws_security_group.podinfo_sg.id ]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install docker -y
              sudo service docker start
              sudo docker run -d -p 80:9898 stefanprodan/podinfo
              EOF
}

resource "aws_security_group" "podinfo_sg" {
  name = "podinfo_sg"
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

/* resource "aws_security_group_rule" "ssh_inbound" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.vpc.default_security_group_id
  cidr_blocks      = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "http_inbound" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.vpc.default_security_group_id
  cidr_blocks      = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = module.vpc.default_security_group_id
  cidr_blocks      = ["0.0.0.0/0"]
} */

output "public_ip" {
  value = module.ec2.public_ip
}

output "sg_id" {
  value = module.vpc.default_security_group_id
}
