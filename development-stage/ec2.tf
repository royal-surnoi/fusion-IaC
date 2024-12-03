resource "aws_instance" "development-instance" {
  ami = var.AMI_id
  instance_type =  "t2.micro"
  tags = var.tags
}