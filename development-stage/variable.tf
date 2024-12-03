variable "AMI_id"{
    type = string
    default = "ami-0453ec754f44f9a4a"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "tags" {
    type = map
    default = {
        Name = "DevelopmentServer"
        Application = "FusionIQ"
        Envronment  = "Development"
        Owner       = "DevOpsTeam"
        CostCenter  = "DevOpsTeam"
    }
}

variable "cidr_blocks" {
    type = string
    default = "0.0.0.0/0"
  
}

variable "ingress_rule" {
  default = [{
    description = "access to all inbound"
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
  },
  {
    description = "access to all inbound"
    from_port = 8080
    to_port = 8080
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
  }
  ,{
    description = "access to all inbound"
    from_port = 80
    to_port = 80
    ip_protocol = "all"
    cidr_ipv4 = "0.0.0.0/0"
  }]
}