variable "aws_region" {
  type        = string
  description = "AWS Region the instance is launched in"
  default     = "us-gov-west-1"
}

variable "aws_subnet" {
  description = "List of vectors of subnets and Availability Zones"
  type        = string
  default     = "subnet-0523d8467cf8e5cec"
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
#  rhel-8.4
#  rhel-7.8
#  opensuse-15-SP2
#  ubuntu-20.04
#  ubuntu-18.04
#  centos-8.2
#  centos-7.8
variable "os" {
  type        = string
  description = "AWS AMI OS"
  default     = "ubuntu-20.04"
}

variable "amis" {
  description = "List of RHEL OS images based on regions"
  type        = map(map(string))
  default = {
    "us-gov-west-1" = {
      "rhel-8.4"        = "ami-0ac4e06a69870e5be"
      "rhel-7.8"        = "ami-e9d5ec88"
      "opensuse-15-SP2" = "ami-04e3d865"
      "ubuntu-20.04"    = "ami-84556de5"
      "ubuntu-18.04"    = "ami-0086246041e9dbd36"
      "centos-8.2"      = "ami-967158f7"
      "centos-7.8"      = "ami-03f2d3b9602dcc98d"
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
  default     = 2
}

variable "extra_worker_nodes" {
  type        = number
  description = "Number of RKE2 worker nodes to add for idempotency tests"
  default     = 2
}

variable "ansible_user" {
  type        = string
  description = "Username used by Ansible to run remote configuration"
  default     = "ubuntu"
}

variable "GITHUB_RUN_ID" {}
