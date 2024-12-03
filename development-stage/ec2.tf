resource "aws_instance" "development-instance" {
  ami = var.AMI_id
  instance_type =  var.instance_type
  vpc_security_group_ids = [aws_security_group.dev-stage-sg.id]
  user_data = <<EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y docker
    sudo service docker start
    sudo usermod -a -G docker ec2-user
  EOF
  tags = var.tags
}

resource "aws_security_group" "dev-stage-sg" {
    name        = "DevelopmentServer-sg"
    description = "Allow SSH,HTTP,80 and 8080 inbound traffic and all outbound traffic"
    tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.dev-stage-sg.id
  cidr_ipv4         = var.cidr_blocks
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_ingress_rule" "allow_HTTP_ipv4" {
  security_group_id = aws_security_group.dev-stage-sg.id
  cidr_ipv4         = var.cidr_blocks
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_8080_ipv4" {
  security_group_id = aws_security_group.dev-stage-sg.id
  cidr_ipv4         = var.cidr_blocks
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.dev-stage-sg.id
  cidr_ipv4         = var.cidr_blocks
  ip_protocol       = "-1" # semantically equivalent to all ports
}