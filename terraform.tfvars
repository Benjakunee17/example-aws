/**
 * Create by : Thanakot Nipitvittaya
 * Date : Wed, Feb 07, 2024  11:00:00 AM
 * Purpose : ประกาศตัวแปลเพื่อใช้ในแต่ละ resource
 */

awsprofile   = "cpalogwtsprd"
awsprofileid = "559386985737"
aws_region   = "ap-southeast-1"

owner_name     = "cpall"
system_name    = "wts"
service_name   = "wts"
project_name   = ""
sr_name        = ""
environment    = "prd"
create_by_name = "tech-thanakot"

#cpalogwtsprd-vpc
vpc_id             = "vpc-00d902d2be1657672"
subnet_app_b       = "subnet-085d1ae51c479f79b"
subnet_app_c       = "subnet-0d496c777add3fd97"
subnet_nonexpose_b = "subnet-0e25338cba0dfbc77"
subnet_nonexpose_c = "subnet-0dde2f934ff851d39"
subnet_secure_b    = "subnet-03272445871b45369"
subnet_secure_c    = "subnet-05716240fd56344be"

#aurora mysql wts warehouse
aurora_engine                       = "aurora-mysql"
aurora_version                      = "8.0.mysql_aurora.3.04.1"
database_name                       = "DB_WAREHOUSE_MANAGEMENT"
aurora_master_username              = "admin"
aurora_master_password              = "rIiHijuxnWkGHtk3taI3"
aurora_instance_type                = "db.r6g.large"
aurora_ca_cert                      = "rds-ca-rsa4096-g1"

#rds mysql wts utility
rds_wts_utility_engine                    = "mysql"
rds_wts_utility_engine_version            = "8.0.36"
rds_wts_utility_multi_az                  = "true"
rds_wts_utility_storage_type              = "gp3"
rds_wts_utility_allocated_storage         = "200"
rds_wts_utility_max_allocated_storage     = "1000"
rds_wts_utility_admin                     = "admin"
rds_wts_utility_password                  = "caW86hwbeTCRK2p3EbPz"
rds_wts_utility_database_name             = "DB_AUTH"
rds_wts_utility_instance_type             = "db.r6g.large"
rds_wts_utility_ca_cert_identifier        = "rds-ca-rsa4096-g1"

#rds mysql wts gr
rds_wts_gr_engine                   = "mysql"
rds_wts_gr_engine_version           = "8.0.36"
rds_wts_gr_multi_az                 = "true"
rds_wts_gr_storage_type             = "gp3"
rds_wts_gr_allocated_storage        = "200"
rds_wts_gr_max_allocated_storage    = "1000"
rds_wts_gr_admin                    = "admin"
rds_wts_gr_password                 = "jhr1HmpLWXCUP44USXA3"
rds_wts_gr_database_name            = "DB_GOODS_RETURN"
rds_wts_gr_instance_type            = "db.r6g.large"
rds_wts_gr_ca_cert_identifier       = "rds-ca-rsa4096-g1"

#loadBalancer ssl certififcate
ssl_policy                          = "ELBSecurityPolicy-TLS13-1-2-2021-06"
certificate_arn                     = "arn:aws:acm:ap-southeast-1:559386985737:certificate/8b1ee350-1201-4617-bd87-8f7052eb86f4"

#rabbit mq
mq_engine_type                      = "RabbitMQ"
mq_engine_version                   = "3.10.25"
mq_instance_type                    = "mq.m5.large"
mq_deployment_mode                  = "CLUSTER_MULTI_AZ"
mq_user_name                        = "admin"
mq_user_password                    = "ygBirVPxpsgjGLJXkb3q"