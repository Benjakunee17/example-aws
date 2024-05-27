/**
 * Create by : Thanakot Nipitvittaya
 * Date : Wed Feb 28 17:00:00 +07 2024
 * Purpose : สร้าง API Gateway Private
 */

resource "aws_api_gateway_rest_api" "wts_api_gateway" {
  name        = "${var.service_name}-wts-${var.environment}-api-gateway"
  description = "${var.service_name}-wts-${var.environment}-api-gateway"
  
  endpoint_configuration {
    types            = ["PRIVATE"]
    vpc_endpoint_ids = [aws_vpc_endpoint.api_gateway.id]
  }

    tags = {
    Name = "${var.service_name}-wts-${var.environment}-api-gateway"
  }
}

#######################################################
# Enable CloudWatch Logging for API Gateway
#######################################################

resource "aws_api_gateway_account" "api_gateway_enable_cloudwatch_logging" {
  cloudwatch_role_arn = aws_iam_role.api_gateway_cloudwatch_logging_role.arn

## depends on คือรอให้ iam role ของ api gateway enable cloudwatch logging create เสร็จก่อนแล้วจึงค่อย attach policy เข้าที่ api gateway
  depends_on = [aws_iam_role_policy.api_gateway_cloudwatch_logging_policy]
}


#######################################################
# API Gateway Policy allow execute-api via VPC endpoint
#######################################################

resource "aws_api_gateway_rest_api_policy" "wts_api_gateway" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  policy      = data.aws_iam_policy_document.wts_api_gateway.json

## depends on คือรอให้ iam policy ของ api gateway allow execute-api ผ่าน vpc endpoint create เสร็จก่อนแล้วจึงค่อย attach policy เข้าที่ api gateway
  depends_on = [data.aws_iam_policy_document.wts_api_gateway]
}



resource "aws_api_gateway_stage" "wts_api_gateway" {
  deployment_id = aws_api_gateway_deployment.wts_api_gateway.id
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  stage_name    = "prd"
}

resource "aws_api_gateway_deployment" "wts_api_gateway" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id

    lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_method_settings" "wts_api_gateway" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  stage_name  = aws_api_gateway_stage.wts_api_gateway.stage_name
  method_path = "*/*"

    settings {
    metrics_enabled         = true
    throttling_burst_limit  = 5000
    throttling_rate_limit   = 10000
    logging_level           = "ERROR"
  }

  ## depends on คือรอให้ iam role policy enable cloudwatch logging for api gateway attach ที่ api gateway เสร็จก่อนจึงสร้าง api gateway method setting
  depends_on = [aws_api_gateway_account.api_gateway_enable_cloudwatch_logging]
}


/**
 * Create by : Thanakot Nipitvittaya
 * Date : Wed Feb 28 17:00:00 +07 2024
 * Purpose : สร้าง api gateway vpc link สำหรับเชื่อมต่อกับ ECS Service ผ่าน AWS Private link
 */


resource "aws_api_gateway_vpc_link" "wts_utl_auth" {
  name        = "${var.service_name}-utl-${var.environment}-auth-vpclink"
  description = "${var.service_name}-utl-${var.environment}-auth-vpclink"
  target_arns = [aws_lb.wts_utl_auth_nlb.arn]

      tags = {
    Name = "${var.service_name}-utl-${var.environment}-auth-vpclink"
  }
}

resource "aws_api_gateway_vpc_link" "wts_utl_batch" {
  name        = "${var.service_name}-utl-${var.environment}-batch-vpclink"
  description = "${var.service_name}-utl-${var.environment}-batch-vpclink"
  target_arns = [aws_lb.wts_utl_batch_nlb.arn]

      tags = {
    Name = "${var.service_name}-utl-${var.environment}-batch-vpclink"
  }
}

resource "aws_api_gateway_vpc_link" "wts_utl_cfg" {
  name        = "${var.service_name}-utl-${var.environment}-cfg-vpclink"
  description = "${var.service_name}-utl-${var.environment}-cfg-vpclink"
  target_arns = [aws_lb.wts_utl_cfg_nlb.arn]

      tags = {
    Name = "${var.service_name}-utl-${var.environment}-cfg-vpclink"
  }
}

resource "aws_api_gateway_vpc_link" "wts_utl_gen_doc" {
  name        = "${var.service_name}-utl-${var.environment}-gen-doc-vpclink"
  description = "${var.service_name}-utl-${var.environment}-gen-doc-vpclink"
  target_arns = [aws_lb.wts_utl_gen_doc_nlb.arn]

      tags = {
    Name = "${var.service_name}-utl-${var.environment}-gen-doc-vpclink"
  }
}

resource "aws_api_gateway_vpc_link" "wts_utl_master" {
  name        = "${var.service_name}-utl-${var.environment}-master-vpclink"
  description = "${var.service_name}-utl-${var.environment}-master-vpclink"
  target_arns = [aws_lb.wts_utl_master_nlb.arn]

      tags = {
    Name = "${var.service_name}-utl-${var.environment}-master-vpclink"
  }
}

resource "aws_api_gateway_vpc_link" "wts_utl_report" {
  name        = "${var.service_name}-utl-${var.environment}-report-vpclink"
  description = "${var.service_name}-utl-${var.environment}-report-vpclink"
  target_arns = [aws_lb.wts_utl_report_nlb.arn]

      tags = {
    Name = "${var.service_name}-utl-${var.environment}-report-vpclink"
  }
}

resource "aws_api_gateway_vpc_link" "wts_utl_schedule" {
  name        = "${var.service_name}-utl-${var.environment}-schedule-vpclink"
  description = "${var.service_name}-utl-${var.environment}-schedule-vpclink"
  target_arns = [aws_lb.wts_utl_schedule_nlb.arn]

      tags = {
    Name = "${var.service_name}-utl-${var.environment}-schedule-vpclink"
  }
}

resource "aws_api_gateway_vpc_link" "wts_grt_grt" {
  name        = "${var.service_name}-grt-${var.environment}-grt-vpclink"
  description = "${var.service_name}-grt-${var.environment}-grt-vpclink"
  target_arns = [aws_lb.wts_grt_grt_nlb.arn]

      tags = {
    Name = "${var.service_name}-grt-${var.environment}-grt-vpclink"
  }
}

resource "aws_api_gateway_vpc_link" "wts_grt_ics" {
  name        = "${var.service_name}-grt-${var.environment}-ics-vpclink"
  description = "${var.service_name}-grt-${var.environment}-ics-vpclink"
  target_arns = [aws_lb.wts_grt_ics_nlb.arn]

      tags = {
    Name = "${var.service_name}-grt-${var.environment}-ics-vpclink"
  }
}

resource "aws_api_gateway_vpc_link" "wts_whm_whm" {
  name        = "${var.service_name}-whm-${var.environment}-whm-vpclink"
  description = "${var.service_name}-whm-${var.environment}-whm-vpclink"
  target_arns = [aws_lb.wts_whm_whm_nlb.arn]

      tags = {
    Name = "${var.service_name}-whm-${var.environment}-whm-vpclink"
  }
}



/**
 * Create by : Thanakot Nipitvittaya
 * Date : Wed Feb 28 17:00:00 +07 2024
 * Purpose : สร้าง api gateway resource
 */

resource "aws_api_gateway_resource" "auth_service" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.wts_api_gateway.root_resource_id
  path_part   = "auth-service"
}


resource "aws_api_gateway_resource" "batch_job_service" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.wts_api_gateway.root_resource_id
  path_part   = "batch-job-service"
}

resource "aws_api_gateway_resource" "configuration_service" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.wts_api_gateway.root_resource_id
  path_part   = "configuration-service"
}

resource "aws_api_gateway_resource" "gen_doc_service" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.wts_api_gateway.root_resource_id
  path_part   = "gen-doc-service"
}

resource "aws_api_gateway_resource" "goods_return_service" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.wts_api_gateway.root_resource_id
  path_part   = "goods-return-service"
}

resource "aws_api_gateway_resource" "ics_service" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.wts_api_gateway.root_resource_id
  path_part   = "ics-service"
}

resource "aws_api_gateway_resource" "master_service" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.wts_api_gateway.root_resource_id
  path_part   = "master_service"
}

resource "aws_api_gateway_resource" "report_service" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.wts_api_gateway.root_resource_id
  path_part   = "report-service"
}

resource "aws_api_gateway_resource" "schedule_job_service" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.wts_api_gateway.root_resource_id
  path_part   = "schedule-job-service"
}

resource "aws_api_gateway_resource" "warehouse_management_service" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.wts_api_gateway.root_resource_id
  path_part   = "warehouse-management-service"
}


/**
 * Create by : Thanakot Nipitvittaya
 * Date : Wed Feb 28 17:00:00 +07 2024
 * Purpose : สร้าง api gateway resource proxy, method, integration
 */


resource "aws_api_gateway_resource" "auth_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_resource.auth_service.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "auth_service_proxy" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.auth_service_proxy.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "auth_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.auth_service_proxy.id
  http_method = aws_api_gateway_method.auth_service_proxy.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "https://wts-auth-api.cpall.co.th/{proxy}"
 
  request_parameters =  {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  cache_key_parameters = ["method.request.path.proxy"]

  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.wts_utl_auth.id

}



resource "aws_api_gateway_resource" "batch_job_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_resource.batch_job_service.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "batch_job_service_proxy" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.batch_job_service_proxy.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "batch_job_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.batch_job_service_proxy.id
  http_method = aws_api_gateway_method.batch_job_service_proxy.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "https://wts-batch-job-api.cpall.co.th/{proxy}"
 
  request_parameters =  {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  cache_key_parameters = ["method.request.path.proxy"]

  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.wts_utl_batch.id

}


resource "aws_api_gateway_resource" "configuration_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_resource.configuration_service.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "configuration_service_proxy" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.configuration_service_proxy.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}


resource "aws_api_gateway_integration" "configuration_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.configuration_service_proxy.id
  http_method = aws_api_gateway_method.configuration_service_proxy.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "https://wts-master-api.cpall.co.th/{proxy}"
 
  request_parameters =  {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  cache_key_parameters = ["method.request.path.proxy"]

  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.wts_utl_cfg.id

}



resource "aws_api_gateway_resource" "gen_doc_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_resource.gen_doc_service.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "gen_doc_service_proxy" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.gen_doc_service_proxy.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "gen_doc_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.gen_doc_service_proxy.id
  http_method = aws_api_gateway_method.gen_doc_service_proxy.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "https://wts-gendoc-api.cpall.co.th/{proxy}"
 
  request_parameters =  {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  cache_key_parameters = ["method.request.path.proxy"]

  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.wts_utl_gen_doc.id

}


resource "aws_api_gateway_resource" "goods_return_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_resource.goods_return_service.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "goods_return_service_proxy" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.goods_return_service_proxy.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "goods_return_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.goods_return_service_proxy.id
  http_method = aws_api_gateway_method.goods_return_service_proxy.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "https://wts-grt-api.cpall.co.th/{proxy}"
 
  request_parameters =  {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  cache_key_parameters = ["method.request.path.proxy"]

  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.wts_grt_grt.id

}


resource "aws_api_gateway_resource" "ics_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_resource.ics_service.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "ics_service_proxy" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.ics_service_proxy.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "ics_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.ics_service_proxy.id
  http_method = aws_api_gateway_method.ics_service_proxy.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "https://wts-grt-ics.cpall.co.th/{proxy}"
 
  request_parameters =  {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  cache_key_parameters = ["method.request.path.proxy"]

  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.wts_grt_ics.id

}


resource "aws_api_gateway_resource" "master_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_resource.master_service.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "master_service_proxy" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.master_service_proxy.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "master_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.master_service_proxy.id
  http_method = aws_api_gateway_method.master_service_proxy.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "https://wts-master-api.cpall.co.th/{proxy}"
 
  request_parameters =  {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  cache_key_parameters = ["method.request.path.proxy"]

  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.wts_utl_master.id

}


resource "aws_api_gateway_resource" "report_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_resource.report_service.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "report_service_proxy" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.report_service_proxy.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "report_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.report_service_proxy.id
  http_method = aws_api_gateway_method.report_service_proxy.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "https://wts-report-api.cpall.co.th/{proxy}"
 
  request_parameters =  {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  cache_key_parameters = ["method.request.path.proxy"]

  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.wts_utl_report.id

}


resource "aws_api_gateway_resource" "schedule_job_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_resource.schedule_job_service.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "schedule_job_service_proxy" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.schedule_job_service_proxy.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "schedule_job_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.schedule_job_service_proxy.id
  http_method = aws_api_gateway_method.schedule_job_service_proxy.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "https://wts-schedule-job-api.cpall.co.th/{proxy}"
 
  request_parameters =  {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  cache_key_parameters = ["method.request.path.proxy"]

  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.wts_utl_schedule.id

}


resource "aws_api_gateway_resource" "warehouse_management_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  parent_id   = aws_api_gateway_resource.warehouse_management_service.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "warehouse_management_service_proxy" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.warehouse_management_service_proxy.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "warehouse_management_service_proxy" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.warehouse_management_service_proxy.id
  http_method = aws_api_gateway_method.warehouse_management_service_proxy.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "https://wts-whm-api.cpall.co.th/{proxy}"
 
  request_parameters =  {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  cache_key_parameters = ["method.request.path.proxy"]

  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.wts_whm_whm.id

}



/**
 * Create by : Thanakot Nipitvittaya
 * Date : Thu Feb 29 10:00:00 +07 2024
 * Purpose : enable CORS 
 */

resource "aws_api_gateway_method" "warehouse_management_service_proxy_options" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.warehouse_management_service_proxy.id
  http_method   = "OPTIONS"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "warehouse_management_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.warehouse_management_service_proxy.id
  http_method = aws_api_gateway_method.warehouse_management_service_proxy_options.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_method_response" "warehouse_management_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.warehouse_management_service_proxy.id
  http_method = aws_api_gateway_method.warehouse_management_service_proxy_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "warehouse_management_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.warehouse_management_service_proxy.id
  http_method = aws_api_gateway_method.warehouse_management_service_proxy_options.http_method
  status_code = aws_api_gateway_method_response.warehouse_management_service_proxy_options.status_code

    response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/json" = "Empty"
  }
}


resource "aws_api_gateway_method" "auth_service_proxy_options" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.auth_service_proxy.id
  http_method   = "OPTIONS"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "auth_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.auth_service_proxy.id
  http_method = aws_api_gateway_method.auth_service_proxy_options.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_method_response" "auth_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.auth_service_proxy.id
  http_method = aws_api_gateway_method.auth_service_proxy_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "auth_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.auth_service_proxy.id
  http_method = aws_api_gateway_method.auth_service_proxy_options.http_method
  status_code = aws_api_gateway_method_response.auth_service_proxy_options.status_code

    response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/json" = "Empty"
  }
}



resource "aws_api_gateway_method" "batch_job_service_proxy_options" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.batch_job_service_proxy.id
  http_method   = "OPTIONS"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "batch_job_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.batch_job_service_proxy.id
  http_method = aws_api_gateway_method.batch_job_service_proxy_options.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_method_response" "batch_job_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.batch_job_service_proxy.id
  http_method = aws_api_gateway_method.batch_job_service_proxy_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "batch_job_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.batch_job_service_proxy.id
  http_method = aws_api_gateway_method.batch_job_service_proxy_options.http_method
  status_code = aws_api_gateway_method_response.batch_job_service_proxy_options.status_code

    response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/json" = "Empty"
  }
}


resource "aws_api_gateway_method" "gen_doc_service_proxy_options" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.gen_doc_service_proxy.id
  http_method   = "OPTIONS"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "gen_doc_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.gen_doc_service_proxy.id
  http_method = aws_api_gateway_method.gen_doc_service_proxy_options.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_method_response" "gen_doc_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.gen_doc_service_proxy.id
  http_method = aws_api_gateway_method.gen_doc_service_proxy_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "gen_doc_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.gen_doc_service_proxy.id
  http_method = aws_api_gateway_method.gen_doc_service_proxy_options.http_method
  status_code = aws_api_gateway_method_response.gen_doc_service_proxy_options.status_code

    response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/json" = "Empty"
  }
}


resource "aws_api_gateway_method" "goods_return_service_proxy_options" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.goods_return_service_proxy.id
  http_method   = "OPTIONS"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "goods_return_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.goods_return_service_proxy.id
  http_method = aws_api_gateway_method.goods_return_service_proxy_options.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_method_response" "goods_return_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.goods_return_service_proxy.id
  http_method = aws_api_gateway_method.goods_return_service_proxy_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "goods_return_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.goods_return_service_proxy.id
  http_method = aws_api_gateway_method.goods_return_service_proxy_options.http_method
  status_code = aws_api_gateway_method_response.goods_return_service_proxy_options.status_code

    response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/json" = "Empty"
  }
}


resource "aws_api_gateway_method" "ics_service_proxy_options" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.ics_service_proxy.id
  http_method   = "OPTIONS"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "ics_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.ics_service_proxy.id
  http_method = aws_api_gateway_method.ics_service_proxy_options.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_method_response" "ics_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.ics_service_proxy.id
  http_method = aws_api_gateway_method.ics_service_proxy_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "ics_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.ics_service_proxy.id
  http_method = aws_api_gateway_method.ics_service_proxy_options.http_method
  status_code = aws_api_gateway_method_response.ics_service_proxy_options.status_code

    response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/json" = "Empty"
  }
}


resource "aws_api_gateway_method" "master_service_proxy_options" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.master_service_proxy.id
  http_method   = "OPTIONS"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "master_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.master_service_proxy.id
  http_method = aws_api_gateway_method.master_service_proxy_options.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_method_response" "master_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.master_service_proxy.id
  http_method = aws_api_gateway_method.master_service_proxy_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "master_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.master_service_proxy.id
  http_method = aws_api_gateway_method.master_service_proxy_options.http_method
  status_code = aws_api_gateway_method_response.master_service_proxy_options.status_code

    response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/json" = "Empty"
  }
}


resource "aws_api_gateway_method" "report_service_proxy_options" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.report_service_proxy.id
  http_method   = "OPTIONS"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "report_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.report_service_proxy.id
  http_method = aws_api_gateway_method.report_service_proxy_options.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_method_response" "report_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.report_service_proxy.id
  http_method = aws_api_gateway_method.report_service_proxy_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "report_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.report_service_proxy.id
  http_method = aws_api_gateway_method.report_service_proxy_options.http_method
  status_code = aws_api_gateway_method_response.report_service_proxy_options.status_code

    response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/json" = "Empty"
  }
}


resource "aws_api_gateway_method" "schedule_job_service_proxy_options" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.schedule_job_service_proxy.id
  http_method   = "OPTIONS"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "schedule_job_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.schedule_job_service_proxy.id
  http_method = aws_api_gateway_method.schedule_job_service_proxy_options.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_method_response" "schedule_job_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.schedule_job_service_proxy.id
  http_method = aws_api_gateway_method.schedule_job_service_proxy_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "schedule_job_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.schedule_job_service_proxy.id
  http_method = aws_api_gateway_method.schedule_job_service_proxy_options.http_method
  status_code = aws_api_gateway_method_response.schedule_job_service_proxy_options.status_code

    response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/json" = "Empty"
  }
}


resource "aws_api_gateway_method" "configuration_service_proxy_options" {
  rest_api_id   = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id   = aws_api_gateway_resource.configuration_service_proxy.id
  http_method   = "OPTIONS"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "configuration_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.configuration_service_proxy.id
  http_method = aws_api_gateway_method.configuration_service_proxy_options.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_method_response" "configuration_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.configuration_service_proxy.id
  http_method = aws_api_gateway_method.configuration_service_proxy_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "configuration_service_proxy_options" {
  rest_api_id = aws_api_gateway_rest_api.wts_api_gateway.id
  resource_id = aws_api_gateway_resource.configuration_service_proxy.id
  http_method = aws_api_gateway_method.configuration_service_proxy_options.http_method
  status_code = aws_api_gateway_method_response.configuration_service_proxy_options.status_code

    response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/json" = "Empty"
  }
}