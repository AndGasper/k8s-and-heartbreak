output "data_plane_route53_endpoint_id" {
    description = "The ID of the Route 53 Resolver endpoint."
    value = "${aws_route53_resolver_endpoint.data_plane_inbound_endpoint.id}"
}

output "control_plane_route53_endpoint_id" {
    description = "The ID of the control plane Route 53 Resolver endpoint."
    value = "${aws_route53_resolver_endpoint.control_plane_outbound_endpoint.id}"

}