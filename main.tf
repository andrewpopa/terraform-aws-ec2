# EC2
resource "aws_key_pair" "tf_key" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_instance" "tf_ec2" {
  ami                         = var.ami_type
  instance_type               = var.ec2_instance["type"]
  vpc_security_group_ids      = [var.vpc_security_group_ids]
  key_name                    = aws_key_pair.tf_key.key_name
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.public_ip

  root_block_device {
    volume_type = var.ec2_instance["root_hdd_type"]
    volume_size = var.ec2_instance["root_hdd_size"]
    delete_on_termination = true
  }

  tags = {
    Name = var.ec2_tags["ec2"]
  }
}