# Security Group Rules for Magento App

resource "aws_security_group_rule" "allow_ALB_80_to_magento" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = resource.aws_security_group.ALB-Magento.id
  security_group_id        = resource.aws_security_group.Magento.id
  description              = "Allow inbound traffic from ALB on port 80"
}

resource "aws_security_group_rule" "allow_Varnish_80_to_magento" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = resource.aws_security_group.Varnish.id
  security_group_id        = resource.aws_security_group.Magento.id
  description              = "Allow inbound traffic from Varnish on port 80"
}


# Security Group Rules for Varnish App

resource "aws_security_group_rule" "allow_ALB_80_to_varnish" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = resource.aws_security_group.ALB-Magento.id
  security_group_id        = resource.aws_security_group.Varnish.id
  description              = "Allow inbound traffic from ALB on port 80"
}