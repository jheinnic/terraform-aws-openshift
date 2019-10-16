//  Create an SSH keypair
resource "aws_key_pair" "keypair" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

//  Create the master userdata script.
data "template_file" "setup-master" {
  template = "${file("${path.module}/files/setup-master.sh")}"
  vars = {
    availability_zone = "${data.aws_availability_zones.azs.names[0]}"
  }
}

//  Launch configuration for the consul cluster auto-scaling group.
resource "aws_spot_instance_request" "master" {
  spot_price                  = var.master_spot_price
  spot_type                   = "persistent"
  wait_for_fulfillment        = true
  instance_interruption_behaviour = "stop"
  ami                  = "${data.aws_ami.rhel7_7.id}"
  # Master nodes require at least 16GB of memory.
  instance_type        = "${var.master_instance_type}"
  subnet_id            = "${data.aws_subnet.private-subnet.id}"
  # iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.setup-master.rendered}"

  vpc_security_group_ids = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  //  We need at least 30GB for OpenShift, let's be greedy...
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  # Storage for Docker, see:
  # https://docs.openshift.org/latest/install_config/install/host_preparation.html#configuring-docker-storage
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 80
    volume_type = "gp2"
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  provisioner "local-exec" {
    command = "./update_spotinstance_tags.sh ${var.region} ${aws_spot_instance_request.master.id} ${aws_spot_instance_request.master.spot_instance_id}"
  }

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "OpenShift Master"
    )
  )}"
}

//  Create the node userdata script.
data "template_file" "setup-node" {
  template = "${file("${path.module}/files/setup-node.sh")}"
  vars = {
    availability_zone = "${data.aws_availability_zones.azs.names[0]}"
  }
}

//  Create the two nodes. This would be better as a Launch Configuration and
//  autoscaling group, but I'm keeping it simple...
resource "aws_spot_instance_request" "node1" {
  spot_price                  = var.node_spot_price
  spot_type                   = "persistent"
  wait_for_fulfillment        = true
  instance_interruption_behaviour = "stop"
  ami                  = "${data.aws_ami.rhel7_7.id}"
  instance_type        = "${var.node_instance_type}"
  subnet_id            = "${data.aws_subnet.private-subnet.id}"
  # iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.setup-node.rendered}"

  vpc_security_group_ids = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  //  We need at least 30GB for OpenShift, let's be greedy...
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  # Storage for Docker, see:
  # https://docs.openshift.org/latest/install_config/install/host_preparation.html#configuring-docker-storage
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 80
    volume_type = "gp2"
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  provisioner "local-exec" {
    command = "./update_spotinstance_tags.sh ${var.region} ${aws_spot_instance_request.node1.id} ${aws_spot_instance_request.node1.spot_instance_id}"
  }

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "OpenShift Node 1"
    )
  )}"
}

resource "aws_spot_instance_request" "node2" {
  spot_price                  = var.node_spot_price
  spot_type                   = "persistent"
  wait_for_fulfillment        = true
  instance_interruption_behaviour = "stop"
  ami                  = "${data.aws_ami.rhel7_7.id}"
  instance_type        = "${var.node_instance_type}"
  subnet_id            = "${data.aws_subnet.private-subnet.id}"
  # iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.setup-node.rendered}"

  vpc_security_group_ids = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  //  We need at least 30GB for OpenShift, let's be greedy...
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  # Storage for Docker, see:
  # https://docs.openshift.org/latest/install_config/install/host_preparation.html#configuring-docker-storage
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 80
    volume_type = "gp2"
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  provisioner "local-exec" {
    command = "./update_spotinstance_tags.sh ${var.region} ${aws_spot_instance_request.node2.id} ${aws_spot_instance_request.node2.spot_instance_id}"
  }

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "OpenShift Node 2"
    )
  )}"
}

resource "aws_spot_instance_request" "node3" {
  spot_price                  = var.node_spot_price
  spot_type                   = "persistent"
  wait_for_fulfillment        = true
  instance_interruption_behaviour = "stop"
  ami                  = "${data.aws_ami.rhel7_7.id}"
  instance_type        = "${var.node_instance_type}"
  subnet_id            = "${aws_subnet.private-subnet.id}"
  # iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.setup-node.rendered}"

  vpc_security_group_ids = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  //  We need at least 30GB for OpenShift, let's be greedy...
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  # Storage for Docker, see:
  # https://docs.openshift.org/latest/install_config/install/host_preparation.html#configuring-docker-storage
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 80
    volume_type = "gp2"
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  provisioner "local-exec" {
    command = "./update_spotinstance_tags.sh ${var.region} ${aws_spot_instance_request.node3.id} ${aws_spot_instance_request.node3.spot_instance_id}"
  }

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "OpenShift Node 3"
    )
  )}"
}

resource "aws_spot_instance_request" "node4" {
  spot_price                  = var.node_spot_price
  spot_type                   = "persistent"
  wait_for_fulfillment        = true
  instance_interruption_behaviour = "stop"
  ami                  = "${data.aws_ami.rhel7_7.id}"
  instance_type        = "${var.node_instance_type}"
  subnet_id            = "${aws_subnet.private-subnet.id}"
  # iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.setup-node.rendered}"

  vpc_security_group_ids = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  //  We need at least 30GB for OpenShift, let's be greedy...
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  # Storage for Docker, see:
  # https://docs.openshift.org/latest/install_config/install/host_preparation.html#configuring-docker-storage
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 80
    volume_type = "gp2"
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  provisioner "local-exec" {
    command = "./update_spotinstance_tags.sh ${var.region} ${aws_spot_instance_request.node4.id} ${aws_spot_instance_request.node4.spot_instance_id}"
  }

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "OpenShift Node 4"
    )
  )}"
}

resource "aws_spot_instance_request" "node5" {
  spot_price                  = var.node_spot_price
  spot_type                   = "persistent"
  wait_for_fulfillment        = true
  instance_interruption_behaviour = "stop"
  ami                  = "${data.aws_ami.rhel7_7.id}"
  instance_type        = "${var.node_instance_type}"
  subnet_id            = "${aws_subnet.private-subnet.id}"
  # iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.setup-node.rendered}"

  vpc_security_group_ids = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  //  We need at least 30GB for OpenShift, let's be greedy...
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  # Storage for Docker, see:
  # https://docs.openshift.org/latest/install_config/install/host_preparation.html#configuring-docker-storage
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 80
    volume_type = "gp2"
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  provisioner "local-exec" {
    command = "./update_spotinstance_tags.sh ${var.region} ${aws_spot_instance_request.node5.id} ${aws_spot_instance_request.node5.spot_instance_id}"
  }

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "OpenShift Node 5"
    )
  )}"
}

resource "aws_spot_instance_request" "node6" {
  spot_price                  = var.node_spot_price
  spot_type                   = "persistent"
  wait_for_fulfillment        = true
  instance_interruption_behaviour = "stop"
  ami                  = "${data.aws_ami.rhel7_7.id}"
  instance_type        = "${var.node_instance_type}"
  subnet_id            = "${aws_subnet.private-subnet.id}"
  # iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.setup-node.rendered}"

  vpc_security_group_ids = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  //  We need at least 30GB for OpenShift, let's be greedy...
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  # Storage for Docker, see:
  # https://docs.openshift.org/latest/install_config/install/host_preparation.html#configuring-docker-storage
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 80
    volume_type = "gp2"
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  provisioner "local-exec" {
    command = "./update_spotinstance_tags.sh ${var.region} ${aws_spot_instance_request.node6.id} ${aws_spot_instance_request.node6.spot_instance_id}"
  }

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "OpenShift Node 6"
    )
  )}"
}

resource "aws_spot_instance_request" "node7" {
  spot_price                  = var.node_spot_price
  spot_type                   = "persistent"
  wait_for_fulfillment        = true
  instance_interruption_behaviour = "stop"
  ami                  = "${data.aws_ami.rhel7_7.id}"
  instance_type        = "${var.node_instance_type}"
  subnet_id            = "${aws_subnet.private-subnet.id}"
  # iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.setup-node.rendered}"

  vpc_security_group_ids = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  //  We need at least 30GB for OpenShift, let's be greedy...
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  # Storage for Docker, see:
  # https://docs.openshift.org/latest/install_config/install/host_preparation.html#configuring-docker-storage
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 80
    volume_type = "gp2"
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  provisioner "local-exec" {
    command = "./update_spotinstance_tags.sh ${var.region} ${aws_spot_instance_request.node7.id} ${aws_spot_instance_request.node7.spot_instance_id}"
  }

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "OpenShift Node 7"
    )
  )}"
}

resource "aws_spot_instance_request" "node8" {
  spot_price                  = var.node_spot_price
  spot_type                   = "persistent"
  wait_for_fulfillment        = true
  instance_interruption_behaviour = "stop"
  ami                  = "${data.aws_ami.rhel7_7.id}"
  instance_type        = "${var.node_instance_type}"
  subnet_id            = "${aws_subnet.private-subnet.id}"
  # iam_instance_profile = "${aws_iam_instance_profile.openshift-instance-profile.id}"
  user_data            = "${data.template_file.setup-node.rendered}"

  vpc_security_group_ids = [
    "${aws_security_group.openshift-vpc.id}",
    "${aws_security_group.openshift-public-ingress.id}",
    "${aws_security_group.openshift-public-egress.id}",
  ]

  //  We need at least 30GB for OpenShift, let's be greedy...
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  # Storage for Docker, see:
  # https://docs.openshift.org/latest/install_config/install/host_preparation.html#configuring-docker-storage
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 80
    volume_type = "gp2"
  }

  key_name = "${aws_key_pair.keypair.key_name}"

  provisioner "local-exec" {
    command = "./update_spotinstance_tags.sh ${var.region} ${aws_spot_instance_request.node8.id} ${aws_spot_instance_request.node8.spot_instance_id}"
  }

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "OpenShift Node 8"
    )
  )}"
}
