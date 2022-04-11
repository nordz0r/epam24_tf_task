# Terraform. Задание 2.
+ Написать terraform манифест для разворачивания AWS EC2/Azure VM. Этот инстанс должен содержать nginx. Nginx должен быть установлен во время провиженинга инстанса, например с помощью user data.
+ (Дополнительно) Добавить в манифест код для создания базы данных AWS RDS/Azure Database. Тип базы на ваше усмотрение. 


### Set variables. Execute in terminal
```
export AWS_ACCESS_KEY_ID=my-key-id
export AWS_SECRET_ACCESS_KEY=my-secret-access-key
```

### Start
```
cd backend 
terraform init
cd ..
terraform init
terraform plan
terraform apply
```

### Simple output
```
aws_vpc.vcp: Creating...
aws_vpc.vcp: Still creating... [10s elapsed]
aws_vpc.vcp: Creation complete after 12s [id=vpc-003d5a72eda8c9f39]
aws_internet_gateway.gateway: Creating...
aws_subnet.subnet-1: Creating...
aws_subnet.subnet-2: Creating...
aws_security_group.sg_ec2: Creating...
aws_subnet.subnet-1: Creation complete after 0s [id=subnet-08f6ea37e018c4ec5]
aws_route_table_association.subnet-1: Creating...
aws_internet_gateway.gateway: Creation complete after 0s [id=igw-06af7492802712344]
aws_route.route_to_gateway: Creating...
aws_subnet.subnet-2: Creation complete after 0s [id=subnet-0b058c3af0213b74c]
aws_route_table_association.subnet-2: Creating...
module.rds.aws_db_subnet_group.default: Creating...
aws_route_table_association.subnet-1: Creation complete after 1s [id=rtbassoc-0138572f8ccaaf9dc]
aws_route_table_association.subnet-2: Creation complete after 1s [id=rtbassoc-08fddd7fef4e33ff9]
aws_route.route_to_gateway: Creation complete after 1s [id=r-rtb-0f18aeb5f5989240b1080289494]
module.rds.aws_db_subnet_group.default: Creation complete after 2s [id=main]
aws_security_group.sg_ec2: Creation complete after 2s [id=sg-0d5dea81355a99504]
aws_security_group.sg_rds: Creating...
module.nginx.aws_instance.nginx: Creating...
aws_security_group.sg_rds: Creation complete after 2s [id=sg-0bdcf3c3723b828d4]
module.rds.aws_db_instance.mysql: Creating...
module.nginx.aws_instance.nginx: Still creating... [10s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [10s elapsed]
module.nginx.aws_instance.nginx: Still creating... [20s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [20s elapsed]
module.nginx.aws_instance.nginx: Still creating... [30s elapsed]
module.nginx.aws_instance.nginx: Creation complete after 32s [id=i-0db69120ad5a72054]
module.rds.aws_db_instance.mysql: Still creating... [30s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [40s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [50s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [1m0s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [1m10s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [1m20s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [1m30s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [1m40s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [1m50s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [2m0s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [2m10s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [2m20s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [2m30s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [2m40s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [2m50s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [3m0s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [3m10s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [3m20s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [3m30s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [3m40s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [3m50s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [4m0s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [4m10s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [4m20s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [4m30s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [4m40s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [4m50s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [5m0s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [5m10s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [5m20s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [5m30s elapsed]
module.rds.aws_db_instance.mysql: Still creating... [5m40s elapsed]
module.rds.aws_db_instance.mysql: Creation complete after 5m45s [id=mysql]

Apply complete! Resources: 12 added, 0 changed, 0 destroyed.

Outputs:

nginx_public_dns = "ec2-3-64-11-118.eu-central-1.compute.amazonaws.com"
```
