# Terraform. Задание 1.
+ Скачать последнюю версию terraform
+ Написать terraform манифест, который с помощью data source сущностей получает из облака информацию о AWS VPC/Azure virtual network, subnets и security groups 
+ Вывести в оутпут имена AWS VPC/Azure virtual network, subnets и security groups

## Скачать последнюю версию terraform
### Install on Debian/Ubuntu
```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update
sudo apt install terraform
terraform -v
```

### Set variables. Execute in terminal
```
export AWS_ACCESS_KEY_ID=my-key-id
export AWS_SECRET_ACCESS_KEY=my-secret-access-key
```

### Start
```
terraform init
terraform plan
terraform apply
```

### Simple output
```
Outputs:

sg = tolist([
  "sg-0348a338e4d91c489",
  "sg-03695425ed0e47e87",
  "sg-03c02f43ce72c6992",
  "sg-07a2fc71d0e095c5d",
  "sg-08b922a4d81369fb1",
  "sg-0dca32dff67575a5b",
  "sg-0dfa1d25dd76340b7",
])
subnets = tolist([
  "subnet-074f178fbddd57fe3",
  "subnet-0f5cc4e0aafdeaf92",
  "subnet-096a34a2b0e1bde1b",
])
vpcs = tolist([
  "vpc-0e7d09b16db4805b7",
])
```