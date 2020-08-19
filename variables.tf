//  The region we will deploy our cluster into.
variable "region" {
  description = "Region to deploy the cluster into"
  default = "us-east-1"
}

variable "aws_access_key" {
  description = ""
}

variable "aws_secret_access_key" {
  description = ""
}

//  The public key to use for SSH access.
variable "public_key_path" {
  default = "~/.ssh/jenkinsOne.pub"
}

variable "public_key_name" {
  default = "john-heinnickel-minishift-key"
}

variable "master_instance_type" {
  description = "Master node instance type, e.g: m5.xlarge."
  default = "m5.xlarge"
}

variable "master_spot_price" {
  description = "EC2 instance spot pricing allowance for OpenShift Master Node"
  default = "0.09125"
}

variable "node_instance_type" {
  description = "Instance type of other cluster nodes, e.g: t2.large. Note that OpenShift will not run on anything smaller than t2.large"
  default = "t2.large"
}

variable "node_spot_price" {
  description = "EC2 instance spot pricing allowance for OpenShift Compute Nodes"
  default = "0.07"
}

variable "bastion_instance_type" {
  description = "Instance type of installer bastion, e.g: t2.small."
  default = "t2.small"
}

variable "bastion_spot_price" {
  description = "Minishift node EC2 instance spot pricing allowance for installer bastion"
  default = "0.05"
}

