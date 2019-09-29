// //  Notes: We could make the internal domain a variable, but not sure it is
// //  really necessary.
// 
// //  Create the internal DNS.
// resource "aws_route53_zone" "internal" {
//   name = "openshift.local"
//   comment = "OpenShift Cluster Internal DNS"
//   vpc {
//     vpc_id = "${data.aws_vpc.openshift.id}"
//   }
//   tags = {
//     Name    = "OpenShift Internal DNS"
//     Project = "openshift"
//   }
// }
// 
// //  Routes for 'master', 'node1' and 'node2'.
// resource "aws_route53_record" "master-a-record" {
//     zone_id = "${aws_route53_zone.internal.zone_id}"
//     name = "master.openshift.local"
//     type = "A"
//     ttl  = 300
//     records = [
//         "${aws_spot_instance_request.master.private_ip}"
//     ]
// }
// resource "aws_route53_record" "node1-a-record" {
//     zone_id = "${aws_route53_zone.internal.zone_id}"
//     name = "node1.openshift.local"
//     type = "A"
//     ttl  = 300
//     records = [
//         "${aws_spot_instance_request.node1.private_ip}"
//     ]
// }
// resource "aws_route53_record" "node2-a-record" {
//     zone_id = "${aws_route53_zone.internal.zone_id}"
//     name = "node2.openshift.local"
//     type = "A"
//     ttl  = 300
//     records = [
//         "${aws_spot_instance_request.node2.private_ip}"
//     ]
// }
// resource "aws_route53_record" "node3-a-record" {
//     zone_id = "${aws_route53_zone.internal.zone_id}"
//     name = "node3.openshift.local"
//     type = "A"
//     ttl  = 300
//     records = [
//         "${aws_spot_instance_request.node3.private_ip}"
//     ]
// }
// resource "aws_route53_record" "node4-a-record" {
//     zone_id = "${aws_route53_zone.internal.zone_id}"
//     name = "node4.openshift.local"
//     type = "A"
//     ttl  = 300
//     records = [
//         "${aws_spot_instance_request.node4.private_ip}"
//     ]
// }
// resource "aws_route53_record" "node5-a-record" {
//     zone_id = "${aws_route53_zone.internal.zone_id}"
//     name = "node5.openshift.local"
//     type = "A"
//     ttl  = 300
//     records = [
//         "${aws_spot_instance_request.node5.private_ip}"
//     ]
// }
// resource "aws_route53_record" "node6-a-record" {
//     zone_id = "${aws_route53_zone.internal.zone_id}"
//     name = "node6.openshift.local"
//     type = "A"
//     ttl  = 300
//     records = [
//         "${aws_spot_instance_request.node6.private_ip}"
//     ]
// }
// resource "aws_route53_record" "node7-a-record" {
//     zone_id = "${aws_route53_zone.internal.zone_id}"
//     name = "node7.openshift.local"
//     type = "A"
//     ttl  = 300
//     records = [
//         "${aws_spot_instance_request.node7.private_ip}"
//     ]
// }
// resource "aws_route53_record" "node8-a-record" {
//     zone_id = "${aws_route53_zone.internal.zone_id}"
//     name = "node8.openshift.local"
//     type = "A"
//     ttl  = 300
//     records = [
//         "${aws_spot_instance_request.node8.private_ip}"
//     ]
// }
