//  Output some useful variables for quick SSH access etc.
output "master-private_ip" {
  value = "${aws_spot_instance_request.master.private_ip}"
}
output "master-private_dns" {
  value = "${aws_spot_instance_request.master.private_ip}.xip.io"
}

output "node1-private_dns" {
  value = "${aws_spot_instance_request.node1.private_ip}.xip.io"
}
output "node1-private_ip" {
  value = "${aws_spot_instance_request.node1.private_ip}"
}

output "node2-private_dns" {
  value = "${aws_spot_instance_request.node2.private_ip}.xip.io"
}
output "node2-private_ip" {
  value = "${aws_spot_instance_request.node2.private_ip}"
}

output "node3-private_dns" {
  value = "${aws_spot_instance_request.node3.private_dns}"
}
output "node3-private_ip" {
  value = "${aws_spot_instance_request.node3.private_ip}"
}

output "node4-private_dns" {
  value = "${aws_spot_instance_request.node4.private_dns}"
}
output "node4-private_ip" {
  value = "${aws_spot_instance_request.node4.private_ip}"
}

output "node5-private_dns" {
  value = "${aws_spot_instance_request.node5.private_dns}"
}
output "node5-private_ip" {
  value = "${aws_spot_instance_request.node5.private_ip}"
}

output "node6-private_dns" {
  value = "${aws_spot_instance_request.node6.private_dns}"
}
output "node6-private_ip" {
  value = "${aws_spot_instance_request.node6.private_ip}"
}

output "node7-private_dns" {
  value = "${aws_spot_instance_request.node7.private_dns}"
}
output "node7-private_ip" {
  value = "${aws_spot_instance_request.node7.private_ip}"
}

output "node8-private_dns" {
  value = "${aws_spot_instance_request.node8.private_dns}"
}
output "node8-private_ip" {
  value = "${aws_spot_instance_request.node8.private_ip}"
}

output "bastion-public_ip" {
  value = "${aws_eip.bastion_eip.public_ip}"
  // value = "${aws_spot_instance_request.bastion.public_ip}"
}
output "bastion-private_dns" {
  value = "${aws_spot_instance_request.bastion.private_ip}.xip.io"
}
output "bastion-private_ip" {
  value = "${aws_spot_instance_request.bastion.private_ip}"
}
