# Create Security Group - SSH Traffic
resource "aws_security_group" "ec2-ssh" {
  name        = "ec2-ssh"
  description = "Allow SSH Access"
  vpc_id      = var.aws_vpc
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-ssh"
  }
}

# Create Security Group - Magento

resource "aws_security_group" "Magento" {
  name        = "Magento"
  description = "Magento Firewall Rules"
  vpc_id      = var.aws_vpc

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Magento"
  }
}

# Create Security Group - Varnish

resource "aws_security_group" "Varnish" {
  name        = "Varnish"
  description = "Varnish Firewall Rules"
  vpc_id      = var.aws_vpc

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Varnish"
  }
}