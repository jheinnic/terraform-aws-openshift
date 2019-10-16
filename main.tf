# Setup our providers so that we have deterministic dependecy resolution. 
provider "aws" {
  version = "~> 2.23"
  region  = "${var.region}"
  shared_credentials_file = "/Users/johnheinnickel/.aws/credentials"
  profile                 = "personal"
}

provider "local" {
  version = "~> 1.3"
}

provider "template" {
  version = "~> 2.1"
}

//  Create the OpenShift cluster using our module.
module "openshift" {
  source          = "./modules/openshift"
  region          = "${var.region}"
  //  Smallest that meets the min specs for OS
  vpc_cidr        = "10.144.0.0/16"
  bastion_subnet_cidr     = "10.144.1.0/24"
  private_subnet_cidr     = "10.144.129.0/24"
  key_name        = "personal-openshift-key"
  public_key_path = "${var.public_key_path}"
  cluster_name    = "jch-openshift"
  cluster_id      = "jch-openshift-${var.region}"
  bastion_instance_type = "${var.bastion_instance_type}"
  bastion_spot_price      = "${var.bastion_spot_price}"
}

//  Output some useful variables for quick SSH access etc.
output "master-url" {
  value = "https://${module.openshift.master-private_ip}.nip.io:8443"
}
output "master-private_ip" {
  value = "${module.openshift.master-private_ip}"
}
output "bastion-public_ip" {
  value = "${module.openshift.bastion-public_ip}"
output "node1-private_ip" {
  value = "${module.openshift.node1-private_ip}"
}
output "node2-private_ip" {
  value = "${module.openshift.node2-private_ip}"
}
output "node3-private_ip" {
  value = "${module.openshift.node3-private_ip}"
}
output "node4-private_ip" {
  value = "${module.openshift.node4-private_ip}"
}
output "node5-private_ip" {
  value = "${module.openshift.node5-private_ip}"
}
output "node6-private_ip" {
  value = "${module.openshift.node6-private_ip}"
}
output "node7-private_ip" {
  value = "${module.openshift.node7-private_ip}"
}
output "node8-private_ip" {
  value = "${module.openshift.node8-private_ip}"
}
