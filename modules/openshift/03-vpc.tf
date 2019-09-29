// Find the VPC.
data "aws_vpc" "openshift" {
  cidr_block           = "${var.vpc_cidr}"
}

// Find private subnet.
data "aws_subnet" "private-subnet" {
  vpc_id                  = "${data.aws_vpc.openshift.id}"
  cidr_block              = "${var.private_subnet_cidr}"
  // map_public_ip_on_launch = false

  // lifecycle {
  //   ignore_changes = ["tags"]
  // }
}

// Find bastion subnet.
data "aws_subnet" "bastion-subnet" {
  vpc_id                  = "${data.aws_vpc.openshift.id}"
  cidr_block              = "${var.bastion_subnet_cidr}"
  availability_zone_id    = "${data.aws_subnet.private-subnet.availability_zone_id}"
  
  // map_public_ip_on_launch = false
  //
  //  Use our common tags and add a specific name.
  // tags = "${merge(
  //   local.common_tags,
  //   map(
  //     "Name", "OpenShift Public Subnet"
  //   )
  // )}"
}
