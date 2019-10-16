//  Collect together all of the output variables needed to build to the final
//  inventory from the inventory template.
data "template_file" "inventory" {
  template = "${file("${path.cwd}/inventory.template.cfg")}"
  vars = {
    access_key = "${aws_iam_access_key.openshift-aws-user.id}"
    secret_key = "${aws_iam_access_key.openshift-aws-user.secret}"
    master_inventory = "${aws_spot_instance_request.master.private_dns}"
    master_hostname = "${aws_spot_instance_request.master.private_dns}"
    node1_hostname = "${aws_spot_instance_request.node1.private_dns}"
    node2_hostname = "${aws_spot_instance_request.node2.private_dns}"
    node3_hostname = "${aws_spot_instance_request.node3.private_dns}"
    node4_hostname = "${aws_spot_instance_request.node4.private_dns}"
    node5_hostname = "${aws_spot_instance_request.node5.private_dns}"
    node6_hostname = "${aws_spot_instance_request.node6.private_dns}"
    node7_hostname = "${aws_spot_instance_request.node7.private_dns}"
    node8_hostname = "${aws_spot_instance_request.node8.private_dns}"
    public_hostname = "${aws_spot_instance_request.master.private_ip}.nip.io"
    cluster_id = "${var.cluster_id}"
  }
}

//  Create the inventory.
resource "local_file" "inventory" {
  content     = "${data.template_file.inventory.rendered}"
  filename = "${path.cwd}/inventory.cfg"
}
