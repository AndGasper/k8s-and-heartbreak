resource "aws_route53_resolver_endpoint" "data_plane_inbound_endpoint" {
    name = "${var.cluster_name}_data_plane_inbound_endpoint"
    direction = "INBOUND"
    security_group_ids = [
        "${var.data_plane_security_group_id}"
    ]
    ip_address {
        subnet_id = "${var.data_plane_subnet_1_id}"
    }
    ip_address {
        subnet_id = "${var.data_plane_subnet_2_id}"
    }
    tags = {
        Name = "Data Plane Inbound Endpoint"
        Project = "k8s-and-heartbreak"
        Type = "route53 resolver endpoint"
        Plane = "Data"
    }
}

# Control Plane: Find me that worker node at workernode.com-> DNS Resolver
# DNS: Oh, I know where workernode.com is
# [ ] - Create an outbound endpoint in a peered VPC.
resource "aws_route53_resolver_endpoint" "control_plane_outbound_endpoint" {
    name = "${var.cluster_name}_control_plane_outbound_endpoint"
    direction = "OUTBOUND"
    security_group_ids = [
        "${var.control_plane_security_group_id}"
    ]
    tags = {
        Name = "Control Plane Outbound Endpoint"
        Project = "k8s-and-heartbreak"
        Type = "route53 resolver endpoint"
        Plane = "Control"
    }
}
# [ ] - Create a forwarding rule for the outbound endpoint that sends requests to the Route 53 resolver for the worker node VPC.
resource "aws_route53_resolver_rule" "control_plane_forward_to_data_plane" {
    # Probably not 100 % correct
    name = "${var.cluster_name}Rule"

    domain_name = "${var.domain_name}"
    rule_type = "FORWARD"
    # select the outbound endpoint to use to send DNS requests to the inbound endpoint of the worker (data plane) node VPC
    resolver_endpoint_id = "${aws_route53_resolver_endpoint.control_plane_outbound_endpoint.id}"
    # Under the Target IP addresses section, 
    # enter the IP addresses of the inbound endpoint 
    # that corresponds to the EKS endpoint that you entered 
    # in the Domain name field.
    target_ip {
        # I do not think that is quite right
        ip = "${aws_route53_resolver_endpoint.data_plane_inbound_endpoint.host_vpc_id}"
    }
    tags = {
        Name = "Route53 FORWARD Rule for Control Plane"
        Type = "route53 resolver rule"
        Project = "k8s-and-heartbreak"
    }
}

# AWS Enabling DNS Resolution for Amazon EKS Cluster Endpoints https://aws.amazon.com/blogs/compute/enabling-dns-resolution-for-amazon-eks-cluster-endpoints/