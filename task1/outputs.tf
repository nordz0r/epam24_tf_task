## Outputs
output "vpcs" {
  value = data.aws_vpcs.vpc.ids
}

output "subnets" {
  value = data.aws_subnets.subnet.ids
}

output "sg" {
  value = data.aws_security_groups.sg.ids
}

