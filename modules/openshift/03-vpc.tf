//  Define the VPC.
resource "aws_vpc" "openshift" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "OpenShift VPC"
    )
  )}"
}

//  Create an Internet Gateway for the VPC.
resource "aws_internet_gateway" "openshift" {
  vpc_id = "${aws_vpc.openshift.id}"

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "OpenShift IGW"
    )
  )}"
}

resource "aws_eip" "openshift-nat" {
  // vpc_id = "${aws_vpc.openshift.id}"
  
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "OpenShift NAT EIP"
    )
  )}"
}

resource "aws_nat_gateway" "openshift" {
  subnet_id = "${aws_subnet.public-subnet.id}"
  allocation_id = "${aws_eip.openshift-nat.id}"

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "OpenShift NAT"
    )
  )}"
}

//  Create a public subnet.
resource "aws_subnet" "public-subnet" {
  vpc_id                  = "${aws_vpc.openshift.id}"
  cidr_block              = "${var.bastion_subnet_cidr}"
  availability_zone       = "${data.aws_availability_zones.azs.names[0]}"
  map_public_ip_on_launch = false
  depends_on              = ["aws_internet_gateway.openshift"]

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "OpenShift Public Subnet"
    )
  )}"
}


//  Create a private subnet.
resource "aws_subnet" "private-subnet" {
  vpc_id                  = "${aws_vpc.openshift.id}"
  cidr_block              = "${var.private_subnet_cidr}"
  availability_zone       = "${data.aws_availability_zones.azs.names[0]}"
  map_public_ip_on_launch = false
  depends_on              = [] // "aws_nat_gateway.openshift"]

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "OpenShift Private Subnet"
    )
  )}"
}

//  Create a route table allowing all public addresses access to the IGW.
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.openshift.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.openshift.id}"
  }

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "OpenShift Public Route Table"
    )
  )}"
}


//  Create a route table allowing all private addresses access to the NAT.
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.openshift.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.openshift.id}"
  }
}

//  Now associate the route table with the public subnet - giving
//  all public subnet instances access to the internet.
resource "aws_route_table_association" "public-subnet" {
  subnet_id      = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.public.id}"
}

//  Now associate the route table with the private subnet - giving
//  all private subnet instances access to  internet through NAT.
resource "aws_route_table_association" "private-subnet" {
  subnet_id      = "${aws_subnet.private-subnet.id}"
  route_table_id = "${aws_route_table.private.id}"
}

