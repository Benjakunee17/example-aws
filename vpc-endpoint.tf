/**
 * Create by : Benja kuneepong
 * Date : Wed, Feb 07, 2024  11:00:00 AM
 * Purpose : ให้ใช้งาน AWS Internal Service แบบ Private Link
 */

##############################
# VPC Endpoint (api gateway)
##############################
resource "aws_vpc_endpoint" "api_gateway" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.execute-api"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = false

  security_group_ids = [aws_security_group.vpce_api_gateway_sg.id]
  subnet_ids         = [var.subnet_app_b, var.subnet_app_c]

  tags = {
    Name = "${var.service_name}-${var.system_name}-${var.environment}-vpc-endpoint-api-gateway"
  }
}

##############################
# VPC Endpoint (s3)
##############################
resource "aws_vpc_endpoint" "s3" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = false

  security_group_ids = [aws_security_group.vpce_s3_sg.id]
  subnet_ids         = [var.subnet_app_b, var.subnet_app_c]

  tags = {
    Name = "${var.service_name}-${var.system_name}-${var.environment}-vpc-endpoint-s3"
  }
}