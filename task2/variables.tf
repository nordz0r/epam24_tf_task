# Vars
## Region settings
variable "region" {
  type = string
  default = "eu-central-1"
  description = "Default Region"
}



## Instance type
variable "instance_type" {
  type = string
  default = "t2.micro"
  description = "Webserver and RDS instance_type"
}

## Tags
variable "tags" {
  type = map
  default = {
    Owner   = "andrei_scheglov@epam.com"
    Project = "Terraform_task2"
  }
  description = "Default tags"
}