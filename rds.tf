/**
 * Create by : Benja kuneepong
 * Date : Wed, Feb 07, 2024  07:00:00 PM
 * Purpose : สร้าง subnet group สำหรับ aurora DB
 */

resource "aws_db_subnet_group" "warehouse_management" {
  name       = "${var.service_name}-${var.system_name}-${var.environment}-aurora-rds-subnet-group"
  subnet_ids = [var.subnet_secure_b, var.subnet_secure_c]

  tags = {
    Name = "${var.service_name}-${var.system_name}-${var.environment}-aurora-subnet-group"
  }
}

/**
 * Create by : Benja kuneepong
 * Date : Wed, Feb 07, 2024  07:00:00 PM
 * Purpose : สร้าง parameter group สำหรับ aurora DB
 */
resource "aws_rds_cluster_parameter_group" "warehouse_management" {
  name        = "${var.service_name}-${var.system_name}-${var.environment}-aurora-rds-parameter-group"
  description = "RDS aurora default cluster parameter group for wts"
  family      = "aurora-mysql8.0"

#  lifecycle {
#    ignore_changes = all
#  }

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }

  parameter {
    name         = "time_zone"
    value        = "Asia/Bangkok"
    apply_method = "pending-reboot"
  }

  lifecycle {
 ignore_changes = all
  }

}


/**
 * Create by : Benja kuneepong
 * Date : Wed, Feb 07, 2024  07:00:00 PM
 * Purpose : สร้าง aurora DB
 */
resource "aws_rds_cluster" "warehouse_management" {
  cluster_identifier              = "${var.service_name}-wm-aurora-${var.environment}"
  engine                          = var.aurora_engine
  engine_version                  = var.aurora_version
  database_name                   = var.database_name
  master_username                 = var.aurora_master_username
  master_password                 = var.aurora_master_password
  # define availability zones for multi az
  availability_zones              = ["ap-southeast-1b", "ap-southeast-1c"]
  storage_encrypted               = true
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.warehouse_management.id
  db_subnet_group_name            = aws_db_subnet_group.warehouse_management.id
  vpc_security_group_ids          = [aws_security_group.warehouse_management_aurora_db_sg.id]
  backup_retention_period         = 7
  preferred_backup_window         = "17:30-19:30"
  copy_tags_to_snapshot           = true
  skip_final_snapshot             = true

lifecycle {
 ignore_changes = [availability_zones]
  }
}

/**
 * Create by : Benja kuneepong
 * Date : Wed, Feb 07, 2024  07:00:00 PM
 * Purpose : สร้าง cluster writer สำหรับ aurora DB
 */
resource "aws_rds_cluster_instance" "warehouse_management_1" {

  identifier                   = "${var.service_name}-wm-aurora-${var.environment}-instance-1"
  cluster_identifier           = aws_rds_cluster.warehouse_management.id
  instance_class               = var.aurora_instance_type
  engine                       = aws_rds_cluster.warehouse_management.engine
  engine_version               = aws_rds_cluster.warehouse_management.engine_version
  performance_insights_enabled = true
   ca_cert_identifier          = var.aurora_ca_cert
  copy_tags_to_snapshot        = true
  apply_immediately            = true
  promotion_tier               = 0

#  lifecycle {
#    ignore_changes = all
#  }

  tags = {
    Name = "${var.service_name}-wm-aurora-${var.environment}-instance-1"
  }
}

resource "aws_rds_cluster_instance" "warehouse_management_2" {

  identifier                   = "${var.service_name}-wm-aurora-${var.environment}-instance-2"
  cluster_identifier           = aws_rds_cluster.warehouse_management.id
  instance_class               = var.aurora_instance_type
  engine                       = aws_rds_cluster.warehouse_management.engine
  engine_version               = aws_rds_cluster.warehouse_management.engine_version
  performance_insights_enabled = true
   ca_cert_identifier          = var.aurora_ca_cert
  copy_tags_to_snapshot        = true
  apply_immediately            = true
  promotion_tier               = 1

#  lifecycle {
#    ignore_changes = all
#  }

  tags = {
    Name = "${var.service_name}-wm-aurora-${var.environment}-instance-2"
  }
}

/**
 * Create by : Benja kuneepong
 * Date : Thu, Feb 08, 2024  10:00:00 AM
 * Purpose : สร้าง subnet group สำหรับ rds mysql 
 */

resource "aws_db_subnet_group" "wts_gr_rds" {
  name       = "${var.service_name}-${var.system_name}-${var.environment}-gr-rds-subnet-group"
  subnet_ids = [var.subnet_secure_b, var.subnet_secure_c]

  tags = {
    Name = "${var.service_name}-${var.system_name}-${var.environment}-gr-rds-subnet-group"
  }
}

resource "aws_db_subnet_group" "wts_utility_rds" {
  name       = "${var.service_name}-${var.system_name}-${var.environment}-utility-rds-subnet-group"
  subnet_ids = [var.subnet_secure_b, var.subnet_secure_c]

  tags = {
    Name = "${var.service_name}-${var.system_name}-${var.environment}-utility-rds-subnet-group"
  }
}

/**
 * Create By : Benja kuneepong
 * Date : Thu, Feb 08, 2024  10:00:00 AM
 * Purpose : สร้าง parameter group สำหรับ mysql rds
 */


resource "aws_db_parameter_group" "wts_gr_rds" {
  name        = "${var.service_name}-${var.system_name}-${var.environment}-gr-parameter-group"
  description = "mysql rds gr parameter group"
  family      = "mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }

  parameter {
    name  = "time_zone"
    value = "Asia/Bangkok"
  }

  lifecycle {
 ignore_changes = all
  }
  
}

resource "aws_db_option_group" "wts_gr_rds" {
  name                     = "${var.service_name}-${var.system_name}-${var.environment}-gr-option-group"
  option_group_description = "mysql rds gr option group"
  engine_name              = "mysql"
  major_engine_version     = "8.0"

}

resource "aws_db_parameter_group" "wts_utility_rds" {
  name        = "${var.service_name}-${var.system_name}-${var.environment}-utility-parameter-group"
  description = "mysql rds utility parameter group"
  family      = "mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }

    parameter {
    name  = "time_zone"
    value = "Asia/Bangkok"
  }

}

resource "aws_db_option_group" "wts_utility_rds" {
  name                     = "${var.service_name}-${var.system_name}-${var.environment}-utility-option-group"
  option_group_description = "mysql rds utility option group"
  engine_name              = "mysql"
  major_engine_version     = "8.0"

}

/**
 * Create By : Benja kuneepong
 * Date : Thu, Feb 08, 2024  10:00:00 AM
 * Purpose : สร้าง mysql rds
 */
resource "aws_db_instance" "wts_gr" {

  identifier           = "${var.service_name}-gr-rds-${var.environment}"
  engine               = var.rds_wts_gr_engine
  engine_version       = var.rds_wts_gr_engine_version
  instance_class       = var.rds_wts_gr_instance_type
  option_group_name    = aws_db_option_group.wts_gr_rds.name
  parameter_group_name = aws_db_parameter_group.wts_gr_rds.name
  ca_cert_identifier   = var.rds_wts_gr_ca_cert_identifier

  multi_az               = var.rds_wts_gr_multi_az
  db_subnet_group_name   = aws_db_subnet_group.wts_gr_rds.name
  vpc_security_group_ids = [aws_security_group.wts_gr_rds_sg.id]

  # Make sure that database name is capitalized, otherwise RDS will try to recreate RDS instance every time
  db_name  = var.rds_wts_gr_database_name
  username = var.rds_wts_gr_admin
  password = var.rds_wts_gr_password
  port     = 3306

  storage_encrypted     = true
  storage_type          = var.rds_wts_gr_storage_type
  allocated_storage     = var.rds_wts_gr_allocated_storage
  max_allocated_storage = var.rds_wts_gr_max_allocated_storage

  backup_window               = "00:00-03:00"
  backup_retention_period     = 7
  copy_tags_to_snapshot       = true
  skip_final_snapshot         = false
  deletion_protection         = true
  auto_minor_version_upgrade  = false
  #apply_immediately       = true

  maintenance_window                    = "Mon:04:00-Mon:07:00"
  enabled_cloudwatch_logs_exports       = ["error", "audit"]
  performance_insights_enabled          = true
  performance_insights_retention_period = 7


   /*
   lifecycle {
     ignore_changes = all
   }
  */

  tags = {
    Name   = "${var.service_name}-gr-rds-${var.environment}"
  }
}


resource "aws_db_instance" "wts_utility" {

  identifier           = "${var.service_name}-utility-rds-${var.environment}"
  engine               = var.rds_wts_utility_engine
  engine_version       = var.rds_wts_utility_engine_version
  instance_class       = var.rds_wts_utility_instance_type
  option_group_name    = aws_db_option_group.wts_utility_rds.name
  parameter_group_name = aws_db_parameter_group.wts_utility_rds.name
  ca_cert_identifier   = var.rds_wts_utility_ca_cert_identifier

  multi_az               = var.rds_wts_utility_multi_az
  db_subnet_group_name   = aws_db_subnet_group.wts_utility_rds.name
  vpc_security_group_ids = [aws_security_group.wts_utility_rds_sg.id]

  # Make sure that database name is capitalized, otherwise RDS will try to recreate RDS instance every time
  db_name  = var.rds_wts_utility_database_name
  username = var.rds_wts_utility_admin
  password = var.rds_wts_utility_password
  port     = 3306

  storage_encrypted     = true
  storage_type          = var.rds_wts_utility_storage_type
  allocated_storage     = var.rds_wts_utility_allocated_storage
  max_allocated_storage = var.rds_wts_utility_max_allocated_storage

  backup_window               = "00:00-03:00"
  backup_retention_period     = 7
  copy_tags_to_snapshot       = true
  skip_final_snapshot         = false
  deletion_protection         = true
  auto_minor_version_upgrade  = false
  #apply_immediately       = true

  maintenance_window                    = "Mon:04:00-Mon:07:00"
  enabled_cloudwatch_logs_exports       = ["error", "audit"]
  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  
   /*
   lifecycle {
     ignore_changes = all
   }
  */
  
  tags = {
    Name   = "${var.service_name}-utility-rds-${var.environment}"
  }
}
