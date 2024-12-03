resource "aws_instance" "development-instance" {
  ami = var.AMI_id
  instance_type =  var.instance_type
  vpc_security_group_ids = [aws_security_group.dev-stage-sg.id]
  tags = var.tags
}

resource "aws_security_group" "dev-stage-sg" {
    name        = "allow_tls"
    description = "Allow SSH,HTTP,80 and 8080 inbound traffic and all outbound traffic"
    # vpc_id      = aws_vpc.main.id
    tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.dev-stage-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
resource "aws_vpc_security_group_ingress_rule" "allow_HTTP_ipv4" {
  security_group_id = aws_security_group.dev-stage-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_8080_ipv4" {
  security_group_id = aws_security_group.dev-stage-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.dev-stage-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}