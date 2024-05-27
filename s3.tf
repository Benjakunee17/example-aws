/** 
 * Create by : Benja kuneepong
 * Date : Wed, Feb 07, 2024  11:00:00 AM
 * Purpose : สร้าง bucket / กำหนด policy สำหรับการ access control list / กำหนด policy สำหรับการ access ใน bucket
 */
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "${var.service_name}-${var.system_name}-${var.environment}-terraform-state-bucket"
   lifecycle {
     prevent_destroy = true
   }
  tags = {
    Name        = "${var.service_name}-${var.system_name}-${var.environment}-terraform-state-bucket"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_bucket" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
      status     = "Enabled"
      mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket_acl" "terraform_state_bucket" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  depends_on = [aws_s3_bucket_ownership_controls.terraform_state_bucket]
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "terraform_state_bucket" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state_bucket" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

/** 
 * Create by : Benja kuneepong
 * Date : Tue, Feb 27, 2024  11:00:00 AM
 * Purpose : สร้าง bucket ของ wts 6 buckets ดังนี้ wts-report.cpall.co.th, wts-wts-react-web-app-frontend-bucket, wts-grt-goods-return-service-bucket, wts-utl-master-service-bucket, wts-utl-report-service-bucket, wts-whm-warehouse-management-bucket
 */
resource "aws_s3_bucket" "wts_report_cpall_co_th_bucket" {
  bucket = "${var.service_name}-report.cpall.co.th"
   lifecycle {
     prevent_destroy = true
   }
  tags = {
    Name        = "${var.service_name}-report.cpall.co.th"
  }
}

resource "aws_s3_bucket_versioning" "wts_report_cpall_co_th_bucket" {
  bucket = aws_s3_bucket.wts_report_cpall_co_th_bucket.id
  versioning_configuration {
      status     = "Enabled"
      mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket_acl" "wts_report_cpall_co_th_bucket" {
  bucket = aws_s3_bucket.wts_report_cpall_co_th_bucket.id
  depends_on = [aws_s3_bucket_ownership_controls.wts_report_cpall_co_th_bucket]
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "wts_report_cpall_co_th_bucket" {
  bucket = aws_s3_bucket.wts_report_cpall_co_th_bucket.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "wts_report_cpall_co_th_bucket" {
  bucket = aws_s3_bucket.wts_report_cpall_co_th_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


#######################################################
# S3 Bucket Policy allow access via VPC endpoint
#######################################################

resource "aws_s3_bucket_policy" "wts_report_cpall_co_th_bucket" {
  bucket = aws_s3_bucket.wts_report_cpall_co_th_bucket.id
  policy = data.aws_iam_policy_document.wts_report_cpall_co_th_bucket.json

## depends on คือรอให้ iam policy ของ s3 bucket create เสร็จก่อนแล้วจึงค่อย attach policy เข้าที่ bucket
  depends_on = [data.aws_iam_policy_document.wts_report_cpall_co_th_bucket]
}



resource "aws_s3_bucket" "wts_react_web_app_frontend_bucket" {
  bucket = "${var.service_name}-${var.environment}-react-web-app-frontend-bucket"
   lifecycle {
     prevent_destroy = true
   }
  tags = {
    Name        = "${var.service_name}-${var.environment}-react-web-app-frontend-bucket"
  }
}

resource "aws_s3_bucket_versioning" "wts_react_web_app_frontend_bucket" {
  bucket = aws_s3_bucket.wts_react_web_app_frontend_bucket.id
  versioning_configuration {
      status     = "Enabled"
      mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket_acl" "wts_react_web_app_frontend_bucket" {
  bucket = aws_s3_bucket.wts_react_web_app_frontend_bucket.id
  depends_on = [aws_s3_bucket_ownership_controls.wts_react_web_app_frontend_bucket]
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "wts_react_web_app_frontend_bucket" {
  bucket = aws_s3_bucket.wts_react_web_app_frontend_bucket.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "wts_react_web_app_frontend_bucket" {
  bucket = aws_s3_bucket.wts_react_web_app_frontend_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket" "wts_grt_goods_return_service_bucket" {
  bucket = "${var.service_name}-grt-goods-return-service-bucket"
   lifecycle {
     prevent_destroy = true
   }
  tags = {
    Name        = "${var.service_name}-grt-goods-return-service-bucket"
  }
}

resource "aws_s3_bucket_versioning" "wts_grt_goods_return_service_bucket" {
  bucket = aws_s3_bucket.wts_grt_goods_return_service_bucket.id
  versioning_configuration {
      status     = "Enabled"
      mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket_acl" "wts_grt_goods_return_service_bucket" {
  bucket = aws_s3_bucket.wts_grt_goods_return_service_bucket.id
  depends_on = [aws_s3_bucket_ownership_controls.wts_grt_goods_return_service_bucket]
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "wts_grt_goods_return_service_bucket" {
  bucket = aws_s3_bucket.wts_grt_goods_return_service_bucket.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "wts_grt_goods_return_service_bucket" {
  bucket = aws_s3_bucket.wts_grt_goods_return_service_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket" "wts_utl_master_service_bucket" {
  bucket = "${var.service_name}-utl-master-service-bucket"
   lifecycle {
     prevent_destroy = true
   }
  tags = {
    Name        = "${var.service_name}-utl-master-service-bucket"
  }
}

resource "aws_s3_bucket_versioning" "wts_utl_master_service_bucket" {
  bucket = aws_s3_bucket.wts_utl_master_service_bucket.id
  versioning_configuration {
      status     = "Enabled"
      mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket_acl" "wts_utl_master_service_bucket" {
  bucket = aws_s3_bucket.wts_utl_master_service_bucket.id
  depends_on = [aws_s3_bucket_ownership_controls.wts_utl_master_service_bucket]
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "wts_utl_master_service_bucket" {
  bucket = aws_s3_bucket.wts_utl_master_service_bucket.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "wts_utl_master_service_bucket" {
  bucket = aws_s3_bucket.wts_utl_master_service_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket" "wts_utl_report_service_bucket" {
  bucket = "${var.service_name}-utl-report-service-bucket"
   lifecycle {
     prevent_destroy = true
   }
  tags = {
    Name        = "${var.service_name}-utl-report-service-bucket"
  }
}

resource "aws_s3_bucket_versioning" "wts_utl_report_service_bucket" {
  bucket = aws_s3_bucket.wts_utl_report_service_bucket.id
  versioning_configuration {
      status     = "Enabled"
      mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket_acl" "wts_utl_report_service_bucket" {
  bucket = aws_s3_bucket.wts_utl_report_service_bucket.id
  depends_on = [aws_s3_bucket_ownership_controls.wts_utl_report_service_bucket]
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "wts_utl_report_service_bucket" {
  bucket = aws_s3_bucket.wts_utl_report_service_bucket.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "wts_utl_report_service_bucket" {
  bucket = aws_s3_bucket.wts_utl_report_service_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket" "wts_whm_warehouse_management_bucket" {
  bucket = "${var.service_name}-whm-warehouse-management-bucket"
   lifecycle {
     prevent_destroy = true
   }
  tags = {
    Name        = "${var.service_name}-whm-warehouse-management-bucket"
  }
}

resource "aws_s3_bucket_versioning" "wts_whm_warehouse_management_bucket" {
  bucket = aws_s3_bucket.wts_whm_warehouse_management_bucket.id
  versioning_configuration {
      status     = "Enabled"
      mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket_acl" "wts_whm_warehouse_management_bucket" {
  bucket = aws_s3_bucket.wts_whm_warehouse_management_bucket.id
  depends_on = [aws_s3_bucket_ownership_controls.wts_whm_warehouse_management_bucket]
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "wts_whm_warehouse_management_bucket" {
  bucket = aws_s3_bucket.wts_whm_warehouse_management_bucket.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "wts_whm_warehouse_management_bucket" {
  bucket = aws_s3_bucket.wts_whm_warehouse_management_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}