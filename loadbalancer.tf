# Terraform AWS Application Load Balancer (ALB)

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.1.0"

  name               = "magento-alb"
  load_balancer_type = "application"
  vpc_id             = var.aws_vpc
  subnets = [
    var.vpc_public_subnets_1,
    var.vpc_public_subnets_2
  ]
  security_groups = [resource.aws_security_group.ALB-Magento.id]

  # Listeners

  # HTTP Listener - HTTP to HTTPS Redirect
  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  # HTTPS Listener
  https_listeners = [
    # HTTPS Listener Index = 0 for HTTPS 443
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = var.acm
      target_group_index = 1

    },
  ]

  # Target Groups
  target_groups = [
    # Magento Target Group - TG Index = 0
    {
      name_prefix          = "main-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      # Magentod Target Group - Targets
      targets = {
        magento = {
          target_id = resource.aws_instance.Magento.id
          port      = 80
        }
      }
      tags = {
        InstanceTargetGroupTag = "magento-TG"
      }

    },
    # Varnish Target Group - TG Index = 1
    {
      name_prefix          = "cache-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      # Varnish Target Group - Targets
      targets = {
        varnish = {
          target_id = resource.aws_instance.Varnish.id
          port      = 80
        }

      }
      tags = {
        InstanceTargetGroupTag = "varnish-TG"
      }
    }
  ]


  # HTTPS Listener Rules
  https_listener_rules = [
    # Rule-1: /static/* should be routed to Magento EC2 Instance
    {
      https_listener_index = 0
      actions = [
        {
          type               = "forward"
          target_group_index = 0
        }
      ]
      conditions = [{
        path_patterns = ["/static/*"]
      }]
    },
    # Rule-2: /media/* should be routed to Magento EC2 Instance
    {
      https_listener_index = 0
      actions = [
        {
          type               = "forward"
          target_group_index = 0
        }
      ]
      conditions = [{
        path_patterns = ["/media/*"]
      }]
    },

  ]

  tags = {
    Name = "magento-ALB"
  } # ALB Tag
}