variable "aws_region" {
  type        = string
  description = "AWS Region the instance is launched in"
  default     = "us-east-2"
}

variable "aws_subnet" {
  description = "List of vectors of subnets and Availability Zones"
  type        = string
  default     = "subnet-0e478ddd6ae2ed0b4"
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
#  rocky8
#  rocky9
variable "os" {
  type        = string
  description = "AWS AMI OS"
  default     = "rocky8"
}

variable "amis" {
  description = "List of AMIs based on regions"
  type = map(map(object({
    ami  = string
    user = string
  })))
  default = {
    "us-east-2" = {
      "rocky8" = {
        ami  = "ami-02391db2758465a87"
        user = "rocky"
      }
      "rocky9" = {
        ami  = "ami-05150ea4d8a533099"
        user = "rocky"
      }
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
variable "OS_TEST" {}