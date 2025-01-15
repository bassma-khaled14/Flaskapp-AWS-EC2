provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "flaskapp-awsec2" {
  ami = data.aws_ami.amazon_linux.id  
  instance_type = "t2.micro"
  tags = {
    Name = "flaskapp-awsec2"
  }

  vpc_security_group_ids = [aws_security_group.flaskapp-awsec2.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install docker -y
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              EOF
}

resource "aws_security_group" "flaskapp-awsec2" {
  name_prefix = "flaskapp-awsec2-sg"

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = aws_instance.flaskapp-awsec2.public_ip
}