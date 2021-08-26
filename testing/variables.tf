variable "aws_region" {
  type        = string
  description = "AWS Region the instance is launched in"
  default     = "us-gov-west-1"
}

variable "aws_subnet" {
  description = "List of vectors of subnets and Availability Zones"
  type        = string
  default     = "vpc-07402b459d3b18976"
}

variable "tf_user" {
  type    = string
  default = "rke2-ansible-github-actions"
}

### AMI
variable "instance_type" {
  type        = string
  description = "AWS type of instance"
  default     = "t2.xlarge"
}

# OS Options
#  rhel8
#  rhel7
#  opensuse
#  ubuntu20
#  centos8
#  centos7
#  rocky8
variable "os" {
  type        = string
  description = "AWS AMI OS"
  default     = "ubuntu20"
}

variable "amis" {
  description = "List of RHEL OS images based on regions"
  type        = map(map(string))
  default = {
    "us-gov-west-1" = {
      "rhel8"    = "ami-0ac4e06a69870e5be"
      "rhel7"    = "ami-e9d5ec88"
      "opensuse" = "ami-04e3d865"
      "ubuntu20" = "ami-84556de5"
      "centos8"  = "ami-967158f7"
      "centos7"  = "ami-bbba86da"
      "rocky8"   = "ami-06370d1e5ddbf1f76"
    }
  }
}

variable "control_nodes" {
  type        = number
  description = "Number of RKE2 manager nodes"
  default     = 3
}

variable "worker_nodes" {
  type        = number
  description = "Number of RKE2 worker nodes"
  default     = 3
}

variable "ansible_user" {
  type        = string
  description = "Username used by Ansible to run remote configuration"
  default     = "ubuntu"
}
