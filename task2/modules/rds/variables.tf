## Database credentials
variable rds_credentials {
  type    = object({
    username = string
    password = string
    dbname = string
  })

  default = {
    username = "db_admin"
    password = "db_password"
    dbname = "db_wordpress"
  }
  description = "RDS user, password and database"
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

## Instance type from main module
variable "instance_type" {
}

## Subnets from main module
variable "subnets" {
}

## Security groups from main module
variable "sg" {
}