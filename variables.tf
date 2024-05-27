/**
 * Create by : Benja kuneepong
 * Date : Wed, Feb 07, 2024  11:00:00 AM
 * Purpose : ประกาศตัวแปลเริิ่มต้นเพื่อไปใช้ในไฟล์​ var ของแต่ละ environment
 */

variable "awsprofile"   {}
variable "awsprofileid" {}
variable "aws_region" { default = "ap_southeast_1" }

variable "owner_name"       {}
variable "service_name"     {}
variable "system_name"      {}
variable "project_name"     {}
variable "sr_name"          {}
variable "environment"      {}
variable "create_by_name"   {}

variable "vpc_id"             {}
variable "subnet_app_b"       {}
variable "subnet_app_c"       {}
variable "subnet_nonexpose_b" {}
variable "subnet_nonexpose_c" {}
variable "subnet_secure_b"    {}
variable "subnet_secure_c"    {}

variable "aurora_engine"                        {}
variable "aurora_version"                       {}
variable "aurora_instance_type"                 {}
variable "aurora_master_username"               {}
variable "aurora_master_password"               {}
variable "aurora_ca_cert"                       {}
variable "database_name"                        {}


variable "rds_wts_utility_admin"                    {}
variable "rds_wts_utility_password"                 {}
variable "rds_wts_utility_database_name"            {}
variable "rds_wts_utility_instance_type"            {}
variable "rds_wts_utility_ca_cert_identifier"       {}
variable "rds_wts_utility_engine"                   {}
variable "rds_wts_utility_engine_version"           {}
variable "rds_wts_utility_multi_az"                 {}
variable "rds_wts_utility_storage_type"             {}
variable "rds_wts_utility_allocated_storage"        {}
variable "rds_wts_utility_max_allocated_storage"    {}


variable "rds_wts_gr_admin"                     {}
variable "rds_wts_gr_password"                  {}
variable "rds_wts_gr_database_name"             {}
variable "rds_wts_gr_instance_type"             {}
variable "rds_wts_gr_ca_cert_identifier"        {}
variable "rds_wts_gr_engine"                    {}
variable "rds_wts_gr_engine_version"            {}
variable "rds_wts_gr_multi_az"                  {}
variable "rds_wts_gr_storage_type"              {}
variable "rds_wts_gr_allocated_storage"         {}
variable "rds_wts_gr_max_allocated_storage"     {}

variable "ssl_policy"                           {}
variable "certificate_arn"                      {}

variable "mq_engine_type"                       {}
variable "mq_engine_version"                    {}
variable "mq_instance_type"                     {}
variable "mq_deployment_mode"                   {}
variable "mq_user_name"                         {}
variable "mq_user_password"                     {}