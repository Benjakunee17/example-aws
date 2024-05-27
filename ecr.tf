/**
 * Create by : Benja kuneepong
 * Date : Wed Feb 28 15:00:00 +07 2024
 * Purpose : สร้าง ECR Repository สำหรับเก็บ Image ของ ECS Services
 */


resource "aws_ecr_repository" "wts_utl_auth_service" {
  name                 = "${var.service_name}-utl-${var.environment}-auth-service-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

    tags = {
    Name = "${var.service_name}-utl-${var.environment}-auth-service-ecr"
  }
}


resource "aws_ecr_repository" "wts_utl_batch_job_service" {
  name                 = "${var.service_name}-utl-${var.environment}-batch-job-service-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

    tags = {
    Name = "${var.service_name}-utl-${var.environment}-batch-job-service-ecr"
  }
}


resource "aws_ecr_repository" "wts_utl_configuration_service" {
  name                 = "${var.service_name}-utl-${var.environment}-configuration-service-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

    tags = {
    Name = "${var.service_name}-utl-${var.environment}-configuration-service-ecr"
  }
}


resource "aws_ecr_repository" "wts_utl_gen_doc_service" {
  name                 = "${var.service_name}-utl-${var.environment}-gen-doc-service-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

    tags = {
    Name = "${var.service_name}-utl-${var.environment}-gen-doc-service-ecr"
  }
}


resource "aws_ecr_repository" "wts_grt_goods_return_consumer_service" {
  name                 = "${var.service_name}-grt-${var.environment}-goods-return-consumer-service-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

    tags = {
    Name = "${var.service_name}-grt-${var.environment}-goods-return-consumer-service-ecr"
  }
}


resource "aws_ecr_repository" "wts_utl_report_service" {
  name                 = "${var.service_name}-utl-${var.environment}-report-service-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

    tags = {
    Name = "${var.service_name}-utl-${var.environment}-report-service-ecr"
  }
}


resource "aws_ecr_repository" "wts_utl_schedule_job_service" {
  name                 = "${var.service_name}-utl-${var.environment}-schedule-job-service-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

    tags = {
    Name = "${var.service_name}-utl-${var.environment}-schedule-job-service-ecr"
  }
}


resource "aws_ecr_repository" "wts_utl_master_consumer_service" {
  name                 = "${var.service_name}-utl-${var.environment}-master-consumer-service-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

    tags = {
    Name = "${var.service_name}-utl-${var.environment}-master-consumer-service-ecr"
  }
}


resource "aws_ecr_repository" "wts_utl_master_service" {
  name                 = "${var.service_name}-utl-${var.environment}-master-service-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

    tags = {
    Name = "${var.service_name}-utl-${var.environment}-master-service-ecr"
  }
}


resource "aws_ecr_repository" "wts_grt_goods_return_producer_service" {
  name                 = "${var.service_name}-grt-${var.environment}-goods-return-producer-service-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

    tags = {
    Name = "${var.service_name}-grt-${var.environment}-goods-return-producer-service-ecr"
  }
}


resource "aws_ecr_repository" "wts_grt_goods_return_service" {
  name                 = "${var.service_name}-grt-${var.environment}-goods-return-service-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

    tags = {
    Name = "${var.service_name}-grt-${var.environment}-goods-return-service-ecr"
  }
}


resource "aws_ecr_repository" "wts_grt_ics_service" {
  name                 = "${var.service_name}-grt-${var.environment}-ics-service-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

    tags = {
    Name = "${var.service_name}-grt-${var.environment}-ics-service-ecr"
  }
}


resource "aws_ecr_repository" "wts_openjdk_repo" {
  name                 = "${var.service_name}-wts-${var.environment}-openjdk-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

    tags = {
    Name = "${var.service_name}-wts-${var.environment}-openjdk-repo"
  }
}


resource "aws_ecr_repository" "wts_whm_warehouse_management_service" {
  name                 = "${var.service_name}-whm-${var.environment}-warehouse-management-service-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

    tags = {
    Name = "${var.service_name}-whm-${var.environment}-warehouse-management-service-ecr"
  }
}