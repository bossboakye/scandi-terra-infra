# Magento application EC2 Instance
resource "aws_instance" "Magento" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.aws_key_pair
  vpc_security_group_ids = [
    resource.aws_security_group.ec2-ssh.id,
    resource.aws_security_group.Magento.id
  ]
  subnet_id                   = var.vpc_public_subnets_1
  associate_public_ip_address = true
  tags = {
    "Name" = "Magento"
  }
}