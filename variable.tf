

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
}

variable "ami_id" {
  description = "Optional: pin a specific AMI ID. Leave as null to auto-select the latest Ubuntu 24.04 LTS AMI for the region."
  type        = string
}

variable "master_instance_type" {
  description = "Instance type for the Kubernetes control-plane node"
  type        = string
}

variable "worker_instance_type" {
  description = "Instance type for the Kubernetes worker nodes"
  type        = string
}

variable "worker_count" {
  description = "Number of worker nodes to launch"
  type        = number
}

variable "key_name" {
  description = "Name of an existing EC2 key pair for SSH access"
  type        = string
}

variable "storage_size" {
  type    = number
}


