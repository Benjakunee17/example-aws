# /**
#  * Create by : Thanakot Nipitvittaya
#  * Date : Wed, Feb 07, 2024  11:00:00 AM
#  * Purpose : สร้าง ecs cluster สำหรับ run container ของ service wts
#  */

resource "aws_ecs_cluster" "ecs_cluster_wts" {
  name = "${var.service_name}-${var.system_name}-${var.environment}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${var.service_name}-${var.system_name}-${var.environment}-cluster"
  }
}

resource "aws_ecs_cluster_capacity_providers" "ecs_cluster_capacity_providers_wts" {
  cluster_name = aws_ecs_cluster.ecs_cluster_wts.id
  capacity_providers = ["FARGATE"]
            
  default_capacity_provider_strategy {
    base              = "0"
    weight            = "1"
    capacity_provider = "FARGATE"
  }

  lifecycle {
    ignore_changes = all
  }

}