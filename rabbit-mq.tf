/**
 * Create by : Thanakot Nipitvittaya
 * Date :  Thu 29 10:00:00 +07 2024
 * Purpose : สร้าง Rabbit MQ สำหรับ wts
 */

 resource "aws_mq_broker" "wts_rabbitmq" {
  broker_name = "${var.service_name}-wts-${var.environment}-rabbitmq"

  configuration {
    id       = aws_mq_configuration.wts_rabbitmq.id
    revision = aws_mq_configuration.wts_rabbitmq.latest_revision
  }

  engine_type                   = "${var.mq_engine_type}"
  engine_version                = "${var.mq_engine_version}"
  storage_type                  = "ebs"                         # rabbit mq only supported ebs for storage
  host_instance_type            = "${var.mq_instance_type}"
  subnet_ids                    = ["${var.subnet_app_c}"]
  security_groups               = [aws_security_group.vpce_rabbit_mq_sg.id]
  deployment_mode               = "${var.mq_deployment_mode}"
  publicly_accessible           = false                         # automatic create vpc endpoint for rabbit mq if use private
  auto_minor_version_upgrade    = true

  maintenance_window_start_time  { 
    day_of_week = "WEDNESDAY"
    time_of_day = "18:00:00"
    time_zone   = "UTC"
  }
 
  user {
    username = "${var.mq_user_name}"
    password = "${var.mq_user_password}"
  }

  tags = {
    Name = "${var.service_name}-wts-${var.environment}-rabbitmq"
    }

  lifecycle {
    ignore_changes = [configuration, maintenance_window_start_time]
  }
}


resource "aws_mq_configuration" "wts_rabbitmq" {
  description    = "${var.service_name}-wts-rabbitmq-${var.environment}-configuration"
  name           = "${var.service_name}-wts-rabbitmq-${var.environment}-configuration"
  engine_type    = "${var.mq_engine_type}"
  engine_version = "${var.mq_engine_version}"

  data = <<DATA
# Default RabbitMQ delivery acknowledgement timeout is 30 minutes
consumer_timeout = 1800000
DATA

  tags = {
    Name = "${var.service_name}-wts-rabbitmq-${var.environment}-configuration"
    }

  lifecycle {
    ignore_changes = [data]
  }
}