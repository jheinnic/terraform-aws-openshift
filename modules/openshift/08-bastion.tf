//  Launch configuration for the consul cluster auto-scaling group.
resource "aws_eip" "bastion_eip" {
  instance = "${aws_spot_instance_request.bastion.spot_instance_id}"
  vpc      = true
}

resource "aws_spot_instance_request" "bastion" {
  ami                  = "${data.aws_ami.amazonlinux.id}"
  instance_type        = "${var.bastion_instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.bastion-instance-profile.id}"
  subnet_id            = "${aws_subnet.public-subnet.id}"
  spot_price           = "${var.bastion_spot_price}"
  spot_type            = "persistent"
  wait_for_fulfillment = true
  instance_interruption_behaviour = "stop"
  associate_public_ip_address = false

  vpc_security_group_ids = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-ssh.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  key_name = "${aws_key_pair.keypair.key_name}"

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "OpenShift Installer Bastion"
    )
  )}"
}
