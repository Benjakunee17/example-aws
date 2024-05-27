/**
 * Create by : Thanakot Nipitvittaya
 * Date :  Thu 29 12:00:00 +07 2024
 * Purpose : สร้าง iam role and policy สำหรับ allow api gateway enable cloudwatch logging
 */

data "aws_iam_policy_document" "api_gateway_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "api_gateway_cloudwatch_logging_role" {
  name               = "api_gateway_cloudwatch_logging_role"
  assume_role_policy = data.aws_iam_policy_document.api_gateway_assume_role.json
}

data "aws_iam_policy_document" "api_gateway_cloudwatch_logging" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:FilterLogEvents",
    ]

    resources = ["*"]
  }
}
resource "aws_iam_role_policy" "api_gateway_cloudwatch_logging_policy" {
  name   = "api_gateway_cloudwatch_logging_policy"
  role   = aws_iam_role.api_gateway_cloudwatch_logging_role.id
  policy = data.aws_iam_policy_document.api_gateway_cloudwatch_logging.json
}


/**
 * Create by : Thanakot Nipitvittaya
 * Date :  Thu 29 12:00:00 +07 2024
 * Purpose : สร้าง iam policy สำหรับ allow execute-api via VPC endpoint
 */

data "aws_iam_policy_document" "wts_api_gateway" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

      actions   = ["execute-api:Invoke"]
      resources = ["*"]
  }

  statement {
    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["execute-api:Invoke"]
    resources = ["*"]

    condition {
      test     = "StringNotEquals"
      variable = "aws:SourceVpce"
      values   = [aws_vpc_endpoint.api_gateway.id]
    }
  }
}


/**
 * Create by : Thanakot Nipitvittaya
 * Date :  Thu 29 12:00:00 +07 2024
 * Purpose : สร้าง iam policy สำหรับ allow access s3 bucket wts-prd-react-web-app-frontend-bucket via VPC endpoint
 */

data "aws_iam_policy_document" "wts_report_cpall_co_th_bucket" {
  statement {
    principals {
    type        = "*"
    identifiers = ["*"]
    }
    sid    = "access-specific-vpce-only"
    effect = "Allow"

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.wts_report_cpall_co_th_bucket.arn}",
      "${aws_s3_bucket.wts_report_cpall_co_th_bucket.arn}/*"
    ]
        condition {
      test     = "StringEquals"
      variable = "aws:SourceVpce"

      values = [aws_vpc_endpoint.s3.id]
    }
  }
}