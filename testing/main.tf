provider "aws" {
  region                      = var.aws_region
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

###
### SECURITY GROUPS
###
resource "aws_security_group" "allow-all" {
  name   = "${var.tf_user}-allow-all"
  vpc_id = "vpc-07402b459d3b18976"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "allow-all"
    Owner      = var.tf_user
    github_run = "${var.GITHUB_RUN_ID}"
  }
}

###
### EC2 INSTANCES
###
# EC2 Instance for RKE2 Cluster - Manager
resource "aws_instance" "control_node" {
  count = var.control_nodes

  ami           = lookup(var.amis[var.aws_region], var.os)
  instance_type = var.instance_type
  subnet_id     = "subnet-0523d8467cf8e5cec"
  key_name      = "rke2-ansible-ci"
  root_block_device {
    volume_type = "standard"
    volume_size = 30
  }

  vpc_security_group_ids = [aws_security_group.allow-all.id]

  tags = {
    Name        = "rke2_ansible-testing-server-${var.os}-${count.index}"
    StopAtNight = "True"
    Owner       = var.tf_user
    NodeType    = "Server"
    github_run  = "${var.GITHUB_RUN_ID}"
  }

  provisioner "remote-exec" {
    inline = [
      "uptime",
    ]
  }
}

# EC2 Instance for RKE2 Cluster - Workers
resource "aws_instance" "worker_node" {
  count = var.worker_nodes

  ami                         = lookup(var.amis[var.aws_region], var.os)
  instance_type               = var.instance_type
  subnet_id                   = "subnet-0523d8467cf8e5cec"
  key_name                    = "rke2-ansible-ci"
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.allow-all.id]

  root_block_device {
    volume_type = "standard"
    volume_size = 60
  }

  tags = {
    Name        = "rke2_ansible-testing-agent-${var.os}-${count.index}"
    StopAtNight = "True"
    Owner       = var.tf_user
    NodeType    = "Agent"
    github_run  = "${var.GITHUB_RUN_ID}"
  }

  provisioner "remote-exec" {
    inline = [
      "uptime",
    ]
  }
}
