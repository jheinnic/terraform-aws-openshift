variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1."
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC, e.g: 10.0.0.0/16"
}

variable "bastion_subnet_cidr" {
  description = "Private CIDR block for bastion subnet, e.g: 10.209.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Private CIDR block for private subnet, e.g: 10.209.129.0/24"
}

variable "key_name" {
  description = "The name of the key to user for ssh access, e.g: consul-cluster"
}

variable "public_key_path" {
  description = "The local public key path, e.g. ~/.ssh/id_rsa.pub"
}

variable "cluster_name" {
  description = "Name of the cluster, e.g: 'openshift-cluster'. Useful when running multiple clusters in the same AWS account."
}

variable "cluster_id" {
  description = "ID of the cluster, e.g: 'openshift-cluster-us-east-1'. Useful when running multiple clusters in the same AWS account."
}

variable "master_instance_type" {
  description = "Master node instance type, e.g: m5.xlarge."
  default = "m5.xlarge"
}

variable "master_spot_price" {
  description = "EC2 instance spot pricing allowance for OpenShift Master Node"
  default = "0.39"
}

variable "node_instance_type" {
  description = "Instance type of other cluster nodes, e.g: t3.large. Note that OpenShift will not run on anything smaller than t3.large"
  default = "t2.large"
}

variable "node_spot_price" {
  description = "EC2 instance spot pricing allowance for OpenShift Compute Nodes"
  default = "0.34"
}

variable "bastion_instance_type" {
  description = "Instance type of installer bastion, e.g: t2.small."
  default = "t2.small"
}

variable "bastion_spot_price" {
  description = "EC2 instance spot pricing allowance for installer bastion"
  default = "0.33"
}

data "aws_availability_zones" "azs" {}
