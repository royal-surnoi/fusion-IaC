resource "aws_instance" "development-instance" {
  ami = var.AMI_id
  instance_type =  var.instance_type
  tags = var.tags
}