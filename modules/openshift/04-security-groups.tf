data "aws_security_group" "de-outbound-services" {
  name     = "de-outbound-services"
  vpc_id   = data.aws_vpc.openshift.id
}

data "aws_security_group" "dataeng-default" {
  name     = "dataeng-networkstack-GJXS4NT3N5GH-sgdefault-1R4KSD1SIVJV2"
  vpc_id   = data.aws_vpc.openshift.id
}

data "aws_security_group" "dataeng-bastion" {
  name     = "dataeng-networkstack-GJXS4NT3N5GH-sgbastion-1C8XOTGIVVEW4"
  vpc_id   = data.aws_vpc.openshift.id
}
