resource "aws_instance" "development-instance" {
  ami = var.AMI_id
  instance_type =  var.instance_type
  vpc_security_group_ids = [aws_security_group.dev-stage-sg.id]
  
  tags = var.tags
}

resource "aws_security_group" "dev-stage-sg" {
    name        = "DevelopmentServer-sg"
    description = "Allow SSH,HTTP,80 and 8080 inbound traffic and all outbound traffic"
    tags = var.tags
}

# resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
#   security_group_id = aws_security_group.dev-stage-sg.id
#   cidr_ipv4         = var.cidr_blocks
#   from_port         = 22
#   ip_protocol       = "tcp"
#   to_port           = 22
# }
# resource "aws_vpc_security_group_ingress_rule" "allow_HTTP_ipv4" {
#   security_group_id = aws_security_group.dev-stage-sg.id
#   cidr_ipv4         = var.cidr_blocks
#   from_port         = 80
#   ip_protocol       = "tcp"
#   to_port           = 80
# }

resource "aws_vpc_security_group_ingress_rule" "allow_8080_ipv4" {
  security_group_id = aws_security_group.dev-stage-sg.id
  description       = [for description in var.ingress_rule : description ]
  cidr_ipv4         = [for cidr_ipv4 in var.ingress_rule : cidr_blocks ]
  from_port         = [for from_port in var.ingress_rule : from_port ]
  ip_protocol       = [for ip_protocol in var.ingress_rule : ip_protocol ]
  to_port           = [for to_port in var.ingress_rule : to_port ]
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.dev-stage-sg.id
  cidr_ipv4         = var.cidr_blocks
  ip_protocol       = "-1" # semantically equivalent to all ports
}