# Crete subnet for RDS
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = var.subnets
}

resource "aws_db_instance" "mysql" {
  identifier                      = "mysql"
  engine                          = "mysql"
  engine_version                  = "8.0.27"
  instance_class                  = var.instance_type
  db_subnet_group_name            = aws_db_subnet_group.default.name
  enabled_cloudwatch_logs_exports = ["general", "error"]
  db_name                         = var.rds_credentials.dbname
  username                        = var.rds_credentials.username
  password                        = var.rds_credentials.password
  allocated_storage               = 20
  max_allocated_storage           = 0
  storage_type                    = "gp2"
  vpc_security_group_ids          = var.sg
  skip_final_snapshot             = true
  tags = merge(var.tags, { Name = "RDS mysql" })
}

