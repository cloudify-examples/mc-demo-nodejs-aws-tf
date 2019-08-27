variable "admin_user" {
  description = "Admin user for the AMI we're launching"
}

variable "keypair_name" {
  description = "A name for the key you are importing."
}

variable "vpc_id" {
  description = "ID of existing VPC to launch VM into"
}

variable "agents_security_group_id" {
  description = "ID of security group containing agent rules"
}

variable "subnet_cidr" {
  description = "CIDR block for the new subnet"
}

variable "min_ftp_port" {
  description = "Minimum port number for FTP"
}

variable "max_ftp_port" {
  description = "Maximum port number for FTP"
}

variable "aws_region" {
  description = "AWS region to launch servers."
}

# Ubuntu Precise 12.04 LTS (x64)
variable "aws_amis" {
  default = {
    ca-central-1 = "ami-033e6106180a626d0"
  }
}
