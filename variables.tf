# EC2
variable "key_name" {
  description = "Name for ssh key"
  type        = string
  default     = ""
}

variable "public_key" {
  description = "Public key"
  type        = string
  default     = ""
}

variable "ami_type" {
  description = "Default OS"
  type        = string
  default     = "ami-0085d4f8878cddc81"
}

variable "ec2_instance" {
  type = map
  default = {
    "type"          = "m5.large"
    "root_hdd_size" = 50
    "root_hdd_type" = "gp2"
  }
}

variable "subnet_id" {
  description = "Subnet ID for EC2"
  type        = string
  default     = ""
}

variable "vpc_security_group_ids" {
  description = "VPC security Group ID"
  type        = string
  default     = ""
}

variable "public_ip" {
  description = "Associate public IP with instance"
  type        = bool
  default     = true
}

variable "ec2_tags" {
  description = "Map fo tags for EC2"
  type        = map
  default = {
    ec2 = "my-ec2"
  }
}

variable "user_data" {
  description = "Data provided on lunching"
  type        = string
  default     = ""
}

variable "instance_profile" {
  description = "IAM instance profile"
  type        = string
  default     = ""
}

variable "instance_count" {
  type        = number
  description = "Number of instances deployed"
  default     = 1
}