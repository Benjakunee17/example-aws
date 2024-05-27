/**
 * Create by : Thanakot Nipitvittaya
 * Date : Tue Feb 27 15:00:00 +07 2024
 * Purpose : สร้าง ALB และ NLB สำหรับ ecs service
 */
 
resource "aws_lb" "wts_grt_grt_alb" {
  name               = "${var.service_name}-grt-${var.environment}-grt-alb"
  internal           = true # Set to true for internal ALB
  load_balancer_type = "application"
  security_groups    = [aws_security_group.wts_alb_ecs_sg.id]
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  enable_http2               = true
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-grt-${var.environment}-grt-alb"
  }
}

resource "aws_lb_target_group" "wts_grt_grt_tg" {
  name        = "${var.service_name}-grt-${var.environment}-grt-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-grt-${var.environment}-grt-tg"
  }
}


resource "aws_lb_listener" "wts_grt_grt_listener" {
  load_balancer_arn = aws_lb.wts_grt_grt_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_grt_grt_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-grt-${var.environment}-grt-listener"
  }
}

resource "aws_lb" "wts_grt_grt_nlb" {
  name               = "${var.service_name}-grt-${var.environment}-grt-nlb"
  internal           = true # Set to true for internal NLB
  load_balancer_type = "network"
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-grt-${var.environment}-grt-nlb"
  }
}

resource "aws_lb_target_group" "wts_grt_grt_nlb_tg" {
  name        = "${var.service_name}-grt-${var.environment}-grt-nlb-tg"
  port        = 443
  protocol    = "TCP"
  target_type = "alb"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-grt-${var.environment}-grt-nlb-tg"
  }
}


resource "aws_lb_listener" "wts_grt_grt_nlb_listener" {
  load_balancer_arn = aws_lb.wts_grt_grt_nlb.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_grt_grt_nlb_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-grt-${var.environment}-grt-nlb-listener"
  }
}

resource "aws_lb_target_group_attachment" "wts_grt_grt_nlb_tg_attachment" {
  target_group_arn = aws_lb_target_group.wts_grt_grt_nlb_tg.arn
  target_id        = aws_lb.wts_grt_grt_alb.arn
  port             = 443
}




resource "aws_lb" "wts_grt_ics_alb" {
  name               = "${var.service_name}-grt-${var.environment}-ics-alb"
  internal           = true # Set to true for internal ALB
  load_balancer_type = "application"
  security_groups    = [aws_security_group.wts_alb_ecs_sg.id]
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  enable_http2               = true
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-grt-${var.environment}-ics-alb"
  }
}

resource "aws_lb_target_group" "wts_grt_ics_tg" {
  name        = "${var.service_name}-grt-${var.environment}-ics-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-grt-${var.environment}-ics-tg"
  }
}


resource "aws_lb_listener" "wts_grt_ics_listener" {
  load_balancer_arn = aws_lb.wts_grt_ics_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_grt_ics_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-grt-${var.environment}-ics-listener"
  }
}

resource "aws_lb" "wts_grt_ics_nlb" {
  name               = "${var.service_name}-grt-${var.environment}-ics-nlb"
  internal           = true # Set to true for internal NLB
  load_balancer_type = "network"
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-grt-${var.environment}-ics-nlb"
  }
}

resource "aws_lb_target_group" "wts_grt_ics_nlb_tg" {
  name        = "${var.service_name}-grt-${var.environment}-ics-nlb-tg"
  port        = 443
  protocol    = "TCP"
  target_type = "alb"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-grt-${var.environment}-ics-nlb-tg"
  }
}


resource "aws_lb_listener" "wts_grt_ics_nlb_listener" {
  load_balancer_arn = aws_lb.wts_grt_ics_nlb.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_grt_ics_nlb_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-grt-${var.environment}-ics-nlb-listener"
  }
}

resource "aws_lb_target_group_attachment" "wts_grt_ics_nlb_tg_attachment" {
  target_group_arn = aws_lb_target_group.wts_grt_ics_nlb_tg.arn
  target_id        = aws_lb.wts_grt_ics_alb.arn
  port             = 443
}



resource "aws_lb" "wts_utl_auth_alb" {
  name               = "${var.service_name}-utl-${var.environment}-auth-alb"
  internal           = true # Set to true for internal ALB
  load_balancer_type = "application"
  security_groups    = [aws_security_group.wts_alb_ecs_sg.id]
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  enable_http2               = true
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-auth-alb"
  }
}

resource "aws_lb_target_group" "wts_utl_auth_tg" {
  name        = "${var.service_name}-utl-${var.environment}-auth-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-auth-tg"
  }
}


resource "aws_lb_listener" "wts_utl_auth_listener" {
  load_balancer_arn = aws_lb.wts_utl_auth_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_utl_auth_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-auth-listener"
  }
}

resource "aws_lb" "wts_utl_auth_nlb" {
  name               = "${var.service_name}-utl-${var.environment}-auth-nlb"
  internal           = true # Set to true for internal NLB
  load_balancer_type = "network"
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-auth-nlb"
  }
}

resource "aws_lb_target_group" "wts_utl_auth_nlb_tg" {
  name        = "${var.service_name}-utl-${var.environment}-auth-nlb-tg"
  port        = 443
  protocol    = "TCP"
  target_type = "alb"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-auth-nlb-tg"
  }
}


resource "aws_lb_listener" "wts_utl_auth_nlb_listener" {
  load_balancer_arn = aws_lb.wts_utl_auth_nlb.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_utl_auth_nlb_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-auth-nlb-listener"
  }
}

resource "aws_lb_target_group_attachment" "wts_utl_auth_nlb_tg_attachment" {
  target_group_arn = aws_lb_target_group.wts_utl_auth_nlb_tg.arn
  target_id        = aws_lb.wts_utl_auth_alb.arn
  port             = 443
}


resource "aws_lb" "wts_utl_batch_alb" {
  name               = "${var.service_name}-utl-${var.environment}-batch-alb"
  internal           = true # Set to true for internal ALB
  load_balancer_type = "application"
  security_groups    = [aws_security_group.wts_alb_ecs_sg.id]
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  enable_http2               = true
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-batch-alb"
  }
}

resource "aws_lb_target_group" "wts_utl_batch_tg" {
  name        = "${var.service_name}-utl-${var.environment}-batch-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-batch-tg"
  }
}


resource "aws_lb_listener" "wts_utl_batch_listener" {
  load_balancer_arn = aws_lb.wts_utl_batch_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_utl_batch_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-batch-listener"
  }
}

resource "aws_lb" "wts_utl_batch_nlb" {
  name               = "${var.service_name}-utl-${var.environment}-batch-nlb"
  internal           = true # Set to true for internal NLB
  load_balancer_type = "network"
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-batch-nlb"
  }
}

resource "aws_lb_target_group" "wts_utl_batch_nlb_tg" {
  name        = "${var.service_name}-utl-${var.environment}-batch-nlb-tg"
  port        = 443
  protocol    = "TCP"
  target_type = "alb"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-batch-nlb-tg"
  }
}


resource "aws_lb_listener" "wts_utl_batch_nlb_listener" {
  load_balancer_arn = aws_lb.wts_utl_batch_nlb.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_utl_batch_nlb_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-batch-nlb-listener"
  }
}

resource "aws_lb_target_group_attachment" "wts_utl_batch_nlb_tg_attachment" {
  target_group_arn = aws_lb_target_group.wts_utl_batch_nlb_tg.arn
  target_id        = aws_lb.wts_utl_batch_alb.arn
  port             = 443
}


resource "aws_lb" "wts_utl_cfg_alb" {
  name               = "${var.service_name}-utl-${var.environment}-cfg-alb"
  internal           = true # Set to true for internal ALB
  load_balancer_type = "application"
  security_groups    = [aws_security_group.wts_alb_ecs_sg.id]
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  enable_http2               = true
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-cfg-alb"
  }
}

resource "aws_lb_target_group" "wts_utl_cfg_tg" {
  name        = "${var.service_name}-utl-${var.environment}-cfg-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-cfg-tg"
  }
}


resource "aws_lb_listener" "wts_utl_cfg_listener" {
  load_balancer_arn = aws_lb.wts_utl_cfg_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_utl_cfg_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-cfg-listener"
  }
}

resource "aws_lb" "wts_utl_cfg_nlb" {
  name               = "${var.service_name}-utl-${var.environment}-cfg-nlb"
  internal           = true # Set to true for internal NLB
  load_balancer_type = "network"
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-cfg-nlb"
  }
}

resource "aws_lb_target_group" "wts_utl_cfg_nlb_tg" {
  name        = "${var.service_name}-utl-${var.environment}-cfg-nlb-tg"
  port        = 443
  protocol    = "TCP"
  target_type = "alb"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-cfg-nlb-tg"
  }
}


resource "aws_lb_listener" "wts_utl_cfg_nlb_listener" {
  load_balancer_arn = aws_lb.wts_utl_cfg_nlb.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_utl_cfg_nlb_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-cfg-nlb-listener"
  }
}

resource "aws_lb_target_group_attachment" "wts_utl_cfg_nlb_tg_attachment" {
  target_group_arn = aws_lb_target_group.wts_utl_cfg_nlb_tg.arn
  target_id        = aws_lb.wts_utl_cfg_alb.arn
  port             = 443
}


resource "aws_lb" "wts_utl_gen_doc_alb" {
  name               = "${var.service_name}-utl-${var.environment}-gen-doc-alb"
  internal           = true # Set to true for internal ALB
  load_balancer_type = "application"
  security_groups    = [aws_security_group.wts_alb_ecs_sg.id]
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  enable_http2               = true
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-gen-doc-alb"
  }
}

resource "aws_lb_target_group" "wts_utl_gen_doc_tg" {
  name        = "${var.service_name}-utl-${var.environment}-gen-doc-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-gen-doc-tg"
  }
}


resource "aws_lb_listener" "wts_utl_gen_doc_listener" {
  load_balancer_arn = aws_lb.wts_utl_gen_doc_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_utl_gen_doc_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-gen-doc-listener"
  }
}

resource "aws_lb" "wts_utl_gen_doc_nlb" {
  name               = "${var.service_name}-utl-${var.environment}-gen-doc-nlb"
  internal           = true # Set to true for internal NLB
  load_balancer_type = "network"
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-gen-doc-nlb"
  }
}

resource "aws_lb_target_group" "wts_utl_gen_doc_nlb_tg" {
  name        = "${var.service_name}-utl-${var.environment}-gen-doc-nlb-tg"
  port        = 443
  protocol    = "TCP"
  target_type = "alb"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-gen-doc-nlb-tg"
  }
}


resource "aws_lb_listener" "wts_utl_gen_doc_nlb_listener" {
  load_balancer_arn = aws_lb.wts_utl_gen_doc_nlb.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_utl_gen_doc_nlb_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-gen-doc-nlb-listener"
  }
}

resource "aws_lb_target_group_attachment" "wts_utl_gen_doc_nlb_tg_attachment" {
  target_group_arn = aws_lb_target_group.wts_utl_gen_doc_nlb_tg.arn
  target_id        = aws_lb.wts_utl_gen_doc_alb.arn
  port             = 443
}


resource "aws_lb" "wts_utl_master_alb" {
  name               = "${var.service_name}-utl-${var.environment}-master-alb"
  internal           = true # Set to true for internal ALB
  load_balancer_type = "application"
  security_groups    = [aws_security_group.wts_alb_ecs_sg.id]
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  enable_http2               = true
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-master-alb"
  }
}

resource "aws_lb_target_group" "wts_utl_master_tg" {
  name        = "${var.service_name}-utl-${var.environment}-master-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-master-tg"
  }
}


resource "aws_lb_listener" "wts_utl_master_listener" {
  load_balancer_arn = aws_lb.wts_utl_master_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_utl_master_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-master-listener"
  }
}

resource "aws_lb" "wts_utl_master_nlb" {
  name               = "${var.service_name}-utl-${var.environment}-master-nlb"
  internal           = true # Set to true for internal NLB
  load_balancer_type = "network"
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-master-nlb"
  }
}

resource "aws_lb_target_group" "wts_utl_master_nlb_tg" {
  name        = "${var.service_name}-utl-${var.environment}-master-nlb-tg"
  port        = 443
  protocol    = "TCP"
  target_type = "alb"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-master-nlb-tg"
  }
}


resource "aws_lb_listener" "wts_utl_master_nlb_listener" {
  load_balancer_arn = aws_lb.wts_utl_master_nlb.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_utl_master_nlb_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-master-nlb-listener"
  }
}

resource "aws_lb_target_group_attachment" "wts_utl_master_nlb_tg_attachment" {
  target_group_arn = aws_lb_target_group.wts_utl_master_nlb_tg.arn
  target_id        = aws_lb.wts_utl_master_alb.arn
  port             = 443
}


resource "aws_lb" "wts_utl_report_alb" {
  name               = "${var.service_name}-utl-${var.environment}-report-alb"
  internal           = true # Set to true for internal ALB
  load_balancer_type = "application"
  security_groups    = [aws_security_group.wts_alb_ecs_sg.id]
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  enable_http2               = true
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-report-alb"
  }
}

resource "aws_lb_target_group" "wts_utl_report_tg" {
  name        = "${var.service_name}-utl-${var.environment}-report-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-report-tg"
  }
}


resource "aws_lb_listener" "wts_utl_report_listener" {
  load_balancer_arn = aws_lb.wts_utl_report_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_utl_report_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-report-listener"
  }
}

resource "aws_lb" "wts_utl_report_nlb" {
  name               = "${var.service_name}-utl-${var.environment}-report-nlb"
  internal           = true # Set to true for internal NLB
  load_balancer_type = "network"
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-report-nlb"
  }
}

resource "aws_lb_target_group" "wts_utl_report_nlb_tg" {
  name        = "${var.service_name}-utl-${var.environment}-report-nlb-tg"
  port        = 443
  protocol    = "TCP"
  target_type = "alb"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-report-nlb-tg"
  }
}


resource "aws_lb_listener" "wts_utl_report_nlb_listener" {
  load_balancer_arn = aws_lb.wts_utl_report_nlb.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_utl_report_nlb_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-report-nlb-listener"
  }
}

resource "aws_lb_target_group_attachment" "wts_utl_report_nlb_tg_attachment" {
  target_group_arn = aws_lb_target_group.wts_utl_report_nlb_tg.arn
  target_id        = aws_lb.wts_utl_report_alb.arn
  port             = 443
}


resource "aws_lb" "wts_utl_schedule_alb" {
  name               = "${var.service_name}-utl-${var.environment}-schedule-alb"
  internal           = true # Set to true for internal ALB
  load_balancer_type = "application"
  security_groups    = [aws_security_group.wts_alb_ecs_sg.id]
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  enable_http2               = true
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-schedule-alb"
  }
}

resource "aws_lb_target_group" "wts_utl_schedule_tg" {
  name        = "${var.service_name}-utl-${var.environment}-schedule-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-schedule-tg"
  }
}


resource "aws_lb_listener" "wts_utl_schedule_listener" {
  load_balancer_arn = aws_lb.wts_utl_schedule_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_utl_schedule_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-schedule-listener"
  }
}

resource "aws_lb" "wts_utl_schedule_nlb" {
  name               = "${var.service_name}-utl-${var.environment}-schedule-nlb"
  internal           = true # Set to true for internal NLB
  load_balancer_type = "network"
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-schedule-nlb"
  }
}

resource "aws_lb_target_group" "wts_utl_schedule_nlb_tg" {
  name        = "${var.service_name}-utl-${var.environment}-schedule-nlb-tg"
  port        = 443
  protocol    = "TCP"
  target_type = "alb"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-schedule-nlb-tg"
  }
}


resource "aws_lb_listener" "wts_utl_schedule_nlb_listener" {
  load_balancer_arn = aws_lb.wts_utl_schedule_nlb.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_utl_schedule_nlb_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-schedule-nlb-listener"
  }
}

resource "aws_lb_target_group_attachment" "wts_utl_schedule_nlb_tg_attachment" {
  target_group_arn = aws_lb_target_group.wts_utl_schedule_nlb_tg.arn
  target_id        = aws_lb.wts_utl_schedule_alb.arn
  port             = 443
}


resource "aws_lb" "wts_whm_whm_alb" {
  name               = "${var.service_name}-whm-${var.environment}-whm-alb"
  internal           = true # Set to true for internal ALB
  load_balancer_type = "application"
  security_groups    = [aws_security_group.wts_alb_ecs_sg.id]
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  enable_http2               = true
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-whm-${var.environment}-whm-alb"
  }
}

resource "aws_lb_target_group" "wts_whm_whm_tg" {
  name        = "${var.service_name}-whm-${var.environment}-whm-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-whm-${var.environment}-whm-tg"
  }
}


resource "aws_lb_listener" "wts_whm_whm_listener" {
  load_balancer_arn = aws_lb.wts_whm_whm_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_whm_whm_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-whm-${var.environment}-whm-listener"
  }
}

resource "aws_lb" "wts_whm_whm_nlb" {
  name               = "${var.service_name}-whm-${var.environment}-whm-nlb"
  internal           = true # Set to true for internal NLB
  load_balancer_type = "network"
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-whm-${var.environment}-whm-nlb"
  }
}

resource "aws_lb_target_group" "wts_whm_whm_nlb_tg" {
  name        = "${var.service_name}-whm-${var.environment}-whm-nlb-tg"
  port        = 443
  protocol    = "TCP"
  target_type = "alb"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-whm-${var.environment}-whm-nlb-tg"
  }
}


resource "aws_lb_listener" "wts_whm_whm_nlb_listener" {
  load_balancer_arn = aws_lb.wts_whm_whm_nlb.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_whm_whm_nlb_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-whm-${var.environment}-whm-nlb-listener"
  }
}

resource "aws_lb_target_group_attachment" "wts_whm_whm_nlb_tg_attachment" {
  target_group_arn = aws_lb_target_group.wts_whm_whm_nlb_tg.arn
  target_id        = aws_lb.wts_whm_whm_alb.arn
  port             = 443
}



/**
 * Create by : Thanakot Nipitvittaya
 * Date : Wed Feb 28 12:00:00 +07 2024
 * Purpose : สร้าง ALB สำหรับ API Gateway
 */


resource "aws_lb" "wts_api_gateway_alb" {
  name               = "${var.service_name}-wts-${var.environment}-api-gateway-alb"
  internal           = true # Set to true for internal ALB
  load_balancer_type = "application"
  security_groups    = [aws_security_group.wts_alb_api_gateway_sg.id]
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  enable_http2               = true
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-wts-${var.environment}-api-gateway-alb"
  }
}

resource "aws_lb_target_group" "wts_api_gateway_tg" {
  name        = "${var.service_name}-wts-${var.environment}-api-gateway-tg"
  port        = 443
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-wts-${var.environment}-api-gateway-tg"
  }
}


resource "aws_lb_listener" "wts_api_gateway_listener" {
  load_balancer_arn = aws_lb.wts_api_gateway_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_api_gateway_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-wts-${var.environment}-api-gateway-listener"
  }
}


##################################################################################
# print output ip address of api gateway endpoint interface and attach it to target group
##################################################################################

data "aws_network_interface" "api_gateway_eni" {
  for_each = aws_vpc_endpoint.api_gateway.network_interface_ids
  id       = each.value
}

resource "aws_lb_target_group_attachment" "wts_api_gateway_tg_attachment" {
  target_group_arn = aws_lb_target_group.wts_api_gateway_tg.arn

  for_each         = data.aws_network_interface.api_gateway_eni
  target_id        = each.value.private_ip
  port             = 443
}


/**
 * Create by : Thanakot Nipitvittaya
 * Date : Wed Feb 28 13:00:00 +07 2024
 * Purpose : สร้าง ALB สำหรับ S3 endpoint interface
 */


resource "aws_lb" "wts_utl_report_s3_alb" {
  name               = "${var.service_name}-utl-${var.environment}-report-s3-alb"
  internal           = true # Set to true for internal ALB
  load_balancer_type = "application"
  security_groups    = [aws_security_group.wts_alb_report_s3_sg.id]
  subnets            = [var.subnet_app_b, var.subnet_app_c]

  enable_deletion_protection = false
  idle_timeout               = "60"
  enable_http2               = true
  desync_mitigation_mode     = "defensive"
  #preserve_host_header       = "false"
  drop_invalid_header_fields = false
  enable_waf_fail_open       = false

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-report-s3-alb"
  }
}

resource "aws_lb_target_group" "wts_utl_report_s3_tg" {
  name        = "${var.service_name}-utl-${var.environment}-report-s3-tg"
  port        = 443
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-report-s3-tg"
  }
}


resource "aws_lb_listener" "wts_utl_report_s3_listener" {
  load_balancer_arn = aws_lb.wts_utl_report_s3_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wts_utl_report_s3_tg.arn
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-utl-${var.environment}-report-s3-listener"
  }
}

resource "aws_lb_listener_rule" "wts_utl_report_s3_listener_rule" {
  listener_arn    = aws_lb_listener.wts_utl_report_s3_listener.arn
  priority        = 1

  action {
    type          = "redirect"
    redirect {
      host        = "#{host}"
      path        = "/#{path}index.html"
      query       = "#{query}"
      port        = "#{port}"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition    {
    path_pattern {
      values = ["*/"]
    }
  }

    tags = {
    Name = "${var.service_name}-utl-${var.environment}-report-s3-listener-rule"
  }

}

##################################################################################
# print output ip address of s3 endpoint interface and attach it to target group
##################################################################################

data "aws_network_interface" "s3_endpoint_eni" {
  for_each = aws_vpc_endpoint.s3.network_interface_ids
  id       = each.value
}

resource "aws_lb_target_group_attachment" "wts_utl_report_s3_tg_attachment" {
  target_group_arn = aws_lb_target_group.wts_utl_report_s3_tg.arn

  for_each         = data.aws_network_interface.s3_endpoint_eni
  target_id        = each.value.private_ip
  port             = 443
}