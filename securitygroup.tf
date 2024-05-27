/**
 * Create by : Benja kuneepong
 * Date : Wed, Feb 07, 2024  11:00:00 AM
 * Purpose : ใช้สำหรับกำหนด security group สำหรับ vpc endpoint
 */
resource "aws_security_group" "vpce_s3_sg" {
  name_prefix = "${var.service_name}-${var.system_name}-${var.environment}-vpce-s3-sg"
  description = "${var.service_name}-${var.system_name}-${var.environment}-vpce-s3-sg"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range of vpc endpoint for s3
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-${var.system_name}-${var.environment}-vpce-s3-sg"
  }
}


resource "aws_security_group" "vpce_api_gateway_sg" {
  name_prefix = "${var.service_name}-${var.system_name}-${var.environment}-vpce-api-gateway-sg"
  description = "${var.service_name}-${var.system_name}-${var.environment}-vpce-api-gateway-sg"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range of vpc endpoint for api gateway
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-${var.system_name}-${var.environment}-vpce-api-gateway-sg"
  }
}

resource "aws_security_group" "vpce_rabbit_mq_sg" {
  name_prefix = "${var.service_name}-${var.system_name}-${var.environment}-vpce-rabbit-mq-sg"
  description = "${var.service_name}-${var.system_name}-${var.environment}-vpce-rabbit-mq-sg"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range of vpc endpoint for rabbit mq
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    from_port        = 5671
    to_port          = 5671
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-${var.system_name}-${var.environment}-vpce-rabbit-mq-sg"
  }
}

/**
 * Create by : Benja kuneepong
 * Date : Wed, Feb 07, 2024  07:00:00 PM
 * Purpose : ใช้สำหรับกำหนด security group สำหรับ aurora DB
 */

resource "aws_security_group" "warehouse_management_aurora_db_sg" {
  name_prefix = "wts-wm-aurora-sg"
  description = "Security group for Aurora database"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range of the Aurora database
  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["10.151.23.0/24"]
  }

    ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["172.19.104.64/26"]
  }

     ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["172.19.104.0/26"]
  }

     ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["100.64.64.0/18"]
  }

     ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["100.64.0.0/18"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-${var.system_name}-${var.environment}-wm-aurora-sg"
  }

    lifecycle {
    ignore_changes = all
  }

}

/**
 * Create by : Benja kuneepong
 * Date : Wed, Feb 07, 2024  07:00:00 PM
 * Purpose : ใช้สำหรับกำหนด security group สำหรับ rds mysql
 */

resource "aws_security_group" "wts_gr_rds_sg" {
  name_prefix = "wts-gr-rds-sg"
  description = "Security group for rds mysql"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range of rds mysql
  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["10.151.23.0/24"]
  }

    ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["172.19.104.64/26"]
  }

     ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["172.19.104.0/26"]
  }

     ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["100.64.64.0/18"]
  }

     ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["100.64.0.0/18"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = {
    Name = "${var.service_name}-${var.system_name}-${var.environment}-gr-rds-sg"
  }

    lifecycle {
    ignore_changes = all
  }

}

resource "aws_security_group" "wts_utility_rds_sg" {
  name_prefix = "wts-utility-rds-sg"
  description = "Security group for rds mysql"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range of rds mysql
  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["10.151.23.0/24"]
  }

    ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["172.19.104.64/26"]
  }

     ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["172.19.104.0/26"]
  }

     ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["100.64.64.0/18"]
  }

     ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["100.64.0.0/18"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = {
    Name = "${var.service_name}-${var.system_name}-${var.environment}-utility-rds-sg"
  }

    lifecycle {
    ignore_changes = all
  }
  
}

/**
 * Create by : Benja kuneepong
 * Date : Tue, Feb 27, 2024  11:00:00 AM
 * Purpose : ใช้สำหรับกำหนด security group สำหรับ alb
 */

 resource "aws_security_group" "wts_alb_api_gateway_sg" {
  name_prefix = "${var.service_name}-wts-${var.environment}-alb-api-gateway-sg"
  description = "${var.service_name}-wts-${var.environment}-alb-api-gateway-sg"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range to alb
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-wts-${var.environment}-alb-api-gateway-sg"
  }
}

resource "aws_security_group" "wts_alb_ecs_sg" {
  name_prefix = "${var.service_name}-wts-${var.environment}-alb-ecs-sg"
  description = "${var.service_name}-wts-${var.environment}-alb-ecs-sg"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range to alb
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-wts-${var.environment}-alb-ecs-sg"
  }
}


resource "aws_security_group" "wts_alb_report_s3_sg" {
  name_prefix = "${var.service_name}-wts-${var.environment}-alb-report-s3-sg"
  description = "${var.service_name}-wts-${var.environment}-alb-report-s3-sg"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range to alb
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-wts-${var.environment}-alb-report-s3-sg"
  }
}


/**
 * Create by : Benja kuneepong
 * Date : Tue, Feb 27, 2024  11:00:00 AM
 * Purpose : ใช้สำหรับกำหนด security group สำหรับ ecs service
 */

resource "aws_security_group" "wts_utl_auth_sg" {
  name_prefix = "${var.service_name}-utl-${var.environment}-auth-sg"
  description = "${var.service_name}-utl-${var.environment}-auth-sg"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range to ecs service
  ingress {
    from_port        = 8090
    to_port          = 8090
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-auth-sg"
  }
}


resource "aws_security_group" "wts_utl_batch_job_sg" {
  name_prefix = "${var.service_name}-utl-${var.environment}-batch-job-sg"
  description = "${var.service_name}-utl-${var.environment}-batch-job-sg"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range to ecs service
  ingress {
    from_port        = 8889
    to_port          = 8889
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-batch-job-sg"
  }
}


resource "aws_security_group" "wts_utl_configuration_sg" {
  name_prefix = "${var.service_name}-utl-${var.environment}-configuration-sg"
  description = "${var.service_name}-utl-${var.environment}-configuration-sg"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range to ecs service
  ingress {
    from_port        = 8081
    to_port          = 8081
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-configuration-sg"
  }
}


resource "aws_security_group" "wts_gen_doc_sg" {
  name_prefix = "${var.service_name}-utl-${var.environment}-gen-doc-sg"
  description = "${var.service_name}-utl-${var.environment}-gen-doc-sg"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range to ecs service
  ingress {
    from_port        = 8085
    to_port          = 8085
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-gen-doc-sg"
  }
}


resource "aws_security_group" "wts_grt_goods_return_sg" {
  name_prefix = "${var.service_name}-grt-${var.environment}-goods-return-sg"
  description = "${var.service_name}-grt-${var.environment}-goods-return-sg"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range to ecs service
  ingress {
    from_port        = 8082
    to_port          = 8082
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-grt-${var.environment}-goods-return-sg"
  }
}


resource "aws_security_group" "wts_grt_ics_sg" {
  name_prefix = "${var.service_name}-grt-${var.environment}-ics-sg"
  description = "${var.service_name}-grt-${var.environment}-ics-sg"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range to ecs service
  ingress {
    from_port        = 11080
    to_port          = 11080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-grt-${var.environment}-ics-sg"
  }
}


resource "aws_security_group" "wts_utl_master_sg" {
  name_prefix = "${var.service_name}-utl-${var.environment}-master-sg"
  description = "${var.service_name}-utl-${var.environment}-master-sg"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range to ecs service
  ingress {
    from_port        = 8083
    to_port          = 8083
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-master-sg"
  }
}


resource "aws_security_group" "wts_utl_report_sg" {
  name_prefix = "${var.service_name}-utl-${var.environment}-report-sg"
  description = "${var.service_name}-utl-${var.environment}-report-sg"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range to ecs service
  ingress {
    from_port        = 8084
    to_port          = 8084
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-report-sg"
  }
}


resource "aws_security_group" "wts_utl_schedule_job_sg" {
  name_prefix = "${var.service_name}-utl-${var.environment}-schedule-job-sg"
  description = "${var.service_name}-utl-${var.environment}-schedule-job-sg"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range to ecs service
  ingress {
    from_port        = 8888
    to_port          = 8888
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-schedule-job-sg"
  }
}


resource "aws_security_group" "wts_whm_warehouse_management_sg" {
  name_prefix = "${var.service_name}-whm-${var.environment}-warehouse-management-sg"
  description = "${var.service_name}-whm-${var.environment}-warehouse-management-sg"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range to ecs service
  ingress {
    from_port        = 8094
    to_port          = 8094
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-whm-${var.environment}-warehouse-management-sg"
  }
}

/**
 * Create by : Benja kuneepong
 * Date : Tue, Feb 27, 2024  11:00:00 AM
 * Purpose : ใช้สำหรับกำหนด security group สำหรับ aws code build
 */

 resource "aws_security_group" "wts_codebuild_sg" {
  name_prefix = "${var.service_name}-wts-${var.environment}-codebuild-sg"
  description = "${var.service_name}-wts-${var.environment}-codebuild-sg"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range to aws code build
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.service_name}-wts-${var.environment}-codebuild-sg"
  }
}