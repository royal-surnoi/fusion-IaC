variable "AMI_id"{
    type = string
    default = "ami-0453ec754f44f9a4a"
}

variable "tags" {
    type = map
    default = {
        Name = "dev-deploy"
        Project = "fusion-iq"
        Envronment = "dev"
    }
  
}