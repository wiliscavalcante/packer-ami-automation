variable "aws_region" {
  type    = string
  default = "sa-east-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ssh_username" {
  type    = string
  default = "ec2-user"
}

variable "vpc_id" {
  type    = string
  default = "vpc-b4efa2d3"
}

variable "subnet_id" {
  type    = string
  default = "subnet-7619e710"
}

variable "security_group_id" {
  type    = string
  default = "sg-08204d3a12073deb6"
}

variable "iam_instance_profile" {
  type = string
  default = "SSMAutomationPackerCF"
}

variable "resource_name" {
  type    = string
  default = "default-resource"
}

variable "ad_domain" {
  type    = string
  default = "example.com"
}

variable "resource_owner" {
  type    = string
  default = "owner@example.com"
}

variable "bu" {
  type    = string
  default = "business-unit"
}

variable "environment" {
  type    = string
  default = "development"
}

variable "location" {
  type    = string
  default = "USA"
}

variable "cost_string" {
  type    = string
  default = "1001"
}

variable "app_id" {
  type    = string
  default = "app-001"
}

variable "resource_app_role" {
  type    = string
  default = "role"
}

source "amazon-ebs" "example" {
  region                  = var.aws_region
  instance_type           = var.instance_type
  ssh_username            = var.ssh_username
  ami_name                = "packer-ami-${regex_replace(timestamp(), "[^A-Za-z0-9-]", "-")}"

  source_ami_filter {
    filters = {
      "name"                = "amzn2-ami-hvm-*-x86_64-gp2"
      "root-device-type"    = "ebs"
      "virtualization-type" = "hvm"
    }
    owners                = ["137112412989"]
    most_recent           = true
  }

  vpc_id                  = var.vpc_id
  subnet_id               = var.subnet_id
  security_group_id       = var.security_group_id
  iam_instance_profile    = var.iam_instance_profile
  ssh_interface           = "private_ip"
  associate_public_ip_address = false

  run_tags = {
    "Name"          = var.resource_name
    "ResourceName"  = var.resource_name
    "adDomain"      = var.ad_domain
    "ResourceOwner" = var.resource_owner
    "BU"            = var.bu
    "Environment"   = var.environment
    "Location"      = var.location
    "CostString"    = var.cost_string
    "AppID"         = var.app_id
    "ResourceAppRole" = var.resource_app_role
  }

  tags = {
    "Name"          = var.resource_name
    "ResourceName"  = var.resource_name
  }
}

build {
  sources = [
    "source.amazon-ebs.example"
  ]

  provisioner "shell" {
    script = "scripts/bootstrap.sh"
  }
}
