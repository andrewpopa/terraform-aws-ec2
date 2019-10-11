module "vpc" {
  source = "github.com/andrewpopa/terraform-aws-vpc"

  # VPC
  cidr_block          = "172.16.0.0/16"
  vpc_public_subnets  = ["172.16.10.0/24", "172.16.11.0/24", "172.16.12.0/24"]
  vpc_private_subnets = ["172.16.13.0/24", "172.16.14.0/24", "172.16.15.0/24"]
  vpc_tags = {
    vpc            = "my-aws-vpc"
    public_subnet  = "public-subnet"
    private_subnet = "private-subnet"
    internet_gw    = "my-internet-gateway"
    nat_gateway    = "nat-gateway"
  }
}

module "security-group" {
  source = "github.com/andrewpopa/terraform-aws-security-group"

  # Security group
  security_group_name        = "my-aws-security-group"
  security_group_description = "my-aws-security-group-descr"
  ingress_ports              = [22, 443, 8800, 5432]
  tf_vpc                     = module.vpc.vpc_id
}

data "template_file" "user_data" {
  template = "${file("user_data.sh")}"
}

module "ec2" {
  source   = "../"
  ami_type = "ami-0085d4f8878cddc81"
  ec2_instance = {
    type          = "m5.large"
    root_hdd_size = 50
    root_hdd_type = "gp2"
  }
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = module.security-group.sg_id
  key_name               = "andrei_ec2_public_key"
  public_key             = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIdRIGZBoLupNf3xvLZYWEMRkhoVOs7HjB80tbTH6b/k2BEQdvfmeSgMW0K4ezavCFyo6nehEPmY194QH4NllzlvfhbdpXrNWq3iXONB6pijuH0XryB/ZEm8tyw0nRXlAAVtqzaRbYVJg41VV5KcyyfBE7nzjmIql6A67d7Pij8yKuBzmpbMWNEuYvrIZCtHqlA4hmK+RyrzyfwMdyVXC0a2TLUkKBnaFMMBD+izfUDMDwolQ+NEZ3Bl3gWRrXMjirNVKXLzKRIeO44B2L/nmiZNI58KUiYJNVRFERP0rv9Ya+NvJXh8wonTbz1viWZ0oaKubbtYcLgPoc9I7buuf9"
  public_ip              = true
  user_data              = data.template_file.user_data.rendered
  ec2_tags = {
    ec2 = "my-ptfe-instance"
  }
    
}
