//  Output some useful variables for quick SSH access etc.
output "master-private_dns" {
  value = "${aws_instance.master.private_dns}"
}
output "master-private_ip" {
  value = "${aws_spot_instance_request.master.private_ip}"
}

output "node1-private_dns" {
  value = "${aws_instance.node1.private_dns}"
}
output "node1-private_ip" {
  value = "${aws_spot_instance_request.node1.private_ip}"
}

output "node2-private_dns" {
  value = "${aws_instance.node2.private_dns}"
}
output "node2-private_ip" {
  value = "${aws_spot_instance_request.node2.private_ip}"
}

output "bastion-public_ip" {
  value = "${aws_eip.bastion_eip.public_ip}"
}
output "bastion-private_dns" {
  value = "${aws_instance.bastion.private_dns}"
}
output "bastion-private_ip" {
  value = "${aws_spot_instance_request.bastion.private_ip}"
}
