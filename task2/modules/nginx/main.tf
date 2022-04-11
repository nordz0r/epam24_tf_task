## Create EC-2 Instance with nginx
resource "aws_instance" "nginx" {
  ami                         = var.ec2_ami
  instance_type               = var.instance_type
  security_groups             = var.sg
  subnet_id                   = var.subnet
  associate_public_ip_address = true
  user_data                   = data.template_file.user_data.rendered
  lifecycle {
    create_before_destroy = true
  }
  tags = merge(var.tags, { Name = "Nginx Web Server" })
}