resource "aws_instance" "development-instance" {
  ami = "ami-0453ec754f44f9a4a"
  instance_type =  "t2.micro"
  tags = {
    Name = "dev-deploy"
  }
}