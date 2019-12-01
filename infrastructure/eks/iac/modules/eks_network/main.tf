resource "aws_vpc" "data_plane_vpc" {
    cidr_block = "${var.data_plane_vpc_cidr_block}"

    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "Worker Node VPC"
        Project = "k8s-and-heartbreak"
        Plane = "data"
        "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
}

# there's a more elegant solution for the cidrs other than just more variables but I am tired.

# Look at IP network functions for something a little more elegant
# VPCs have the potential to span all availability zones
# And subnets span a single availability zone (AZ)
# So for first principles, let's make 2 AZ's for availability
# These should be private subnets 
resource "aws_subnet" "data_plane_subnet_1" {
    vpc_id = "${aws_vpc.data_plane_vpc.id}"
    cidr_block = "${var.data_plane_subnet_1_vpc_cidr_block}"
    tags = {
        Name = "Data Plane Node Subnet 1"
        Project = "k8s-and-heartbreak"
        "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
}

resource "aws_subnet" "control_plane_subnet_1" {
    vpc_id = "${aws_vpc.control_plane_vpc.id}"
    cidr_block = "${var.control_plane_subnet_1_vpc_cidr_block}"
    tags = {
        Name = "Control Plane Subnet 1"
        Project = "k8s-and-heartbreak"
    }
}

resource "aws_subnet" "control_plane_subnet_2" {
    vpc_id = "${aws_vpc.control_plane_vpc.id}"
    cidr_block = "${var.control_plane_subnet_2_vpc_cidr_block}"
    tags = {
        Name = "Control Plane Subnet 2"
        Project = "k8s-and-heartbreak"
    }
}


resource "aws_subnet" "data_plane_subnet_2" {
    vpc_id = "${aws_vpc.data_plane_vpc.id}"
    cidr_block = "${var.data_plane_subnet_2_vpc_cidr_block}"
    tags = {
        Name = "Data Plane Node Subnet 2"
        Project = "k8s-and-heartbreak"
        "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
}

resource "aws_vpc" "control_plane_vpc" {
    cidr_block = "${var.control_plane_cidr_block}"

    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "EKS Control Plane VPC"
        Project = "k8s-and-heartbreak"
        Plane = "control"

        "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
}

# VPC Peering

resource "aws_route_table" "data_plane_route_table" {
    vpc_id = "${aws_vpc.data_plane_vpc.id}"
    tags = {
        Name = "Data Plane Route Table"
        Project = "k8s-and-heartbreak"
    }
}

resource "aws_route_table" "control_plane_route_table" {
    vpc_id = "${aws_vpc.control_plane_vpc.id}"
    tags = {
        Name = "Control Plane Route Table"
        Project = "k8s-and-heartbreak"
    }
}

# VPC Peering
# [x] VPC 1
# [x] VPC 2
# [x] VPC Peering Connection
# [x] VPC 1 Route With VPC2 CIDR Block and Target of VPC Peering Connection
# [x] VPC 2 Route with VPC1 CIDR Block and Target of VPC Peering Connection

# [x] VPC 1 Main Route Table is the table that has the VPC Peering connection configured.
resource "aws_main_route_table_association" "data_plane_main_route_table" {
    vpc_id = "${aws_vpc.data_plane_vpc.id}"
    route_table_id = "${aws_route_table.data_plane_route_table.id}"
  
}

# [x] VPC 2 Main Route table is the table that has the VPC Peering connection configured. 
resource "aws_main_route_table_association" "control_plane_main_route_table" {
    vpc_id = "${aws_vpc.control_plane_vpc.id}"
    route_table_id = "${aws_route_table.control_plane_route_table.id}"
}


resource "aws_route" "control_plane_to_data_plane_vpc_peering_route" {
    depends_on = [
        "aws_route_table.control_plane_route_table",
        "aws_vpc.data_plane_vpc",
        "aws_vpc_peering_connection.data_and_control_plane_peering"
    ]
    route_table_id = "${aws_route_table.control_plane_route_table.id}"
    destination_cidr_block = "${aws_vpc.data_plane_vpc.cidr_block}"
    # Route Target
    vpc_peering_connection_id = "${aws_vpc_peering_connection.data_and_control_plane_peering.id}"


}
resource "aws_route" "data_plane_to_control_plane_vpc_peering_route" {
    depends_on = [
        "aws_route_table.data_plane_route_table",
        "aws_vpc.control_plane_vpc",
        "aws_vpc_peering_connection.data_and_control_plane_peering"
    ]
    route_table_id = "${aws_route_table.data_plane_route_table.id}"
    destination_cidr_block = "${aws_vpc.control_plane_vpc.cidr_block}"
    # Route Target
    vpc_peering_connection_id = "${aws_vpc_peering_connection.data_and_control_plane_peering.id}"
}

# [ ] - Security Group Rules: DNS 
resource "aws_security_group" "data_plane_security_group" {
    name = "data_plane_security_group"
    description = "The security group for the data plane vpc."
    tags = {
        Name = "Data Plane Security Group"
        Project = "k8s-and-heartbreak"
        Plane = "Data"
    }
}

resource "aws_security_group" "control_plane_security_group" {
    name ="control_plane_security_group"
    description = "The security group for the control plane vpc."
    tags = {
        Name = "Control Plane Security Group"
        Project = "k8s-and-heartbreak"
        Plane = "Control"
    }
  
}

resource "aws_security_group_rule" "data_plane_tcp_dns_resolution" {
    security_group_id = "${aws_security_group.data_plane_security_group.id}"

    type = "ingress"
    from_port = 53
    to_port = 53
    protocol = "tcp"
    cidr_blocks = [
        "172.31.0.0/16"
    ]
}

resource "aws_security_group_rule" "control_plane_tcp_dns_resolution" {
    security_group_id = "${aws_security_group.control_plane_security_group.id}"
    type = "ingress"
    from_port = 53
    to_port = 53
    protocol = "tcp"
    cidr_blocks = [
        "172.31.0.0/16"
    ]
}

resource "aws_security_group_rule" "data_plane_udp_dns_resolution" {
    security_group_id = "${aws_security_group.data_plane_security_group.id}"
    type = "ingress"
    from_port = 53
    to_port = 53
    protocol = "udp"
    cidr_blocks = [
        "172.31.0.0/16"
    ]
}

resource "aws_security_group_rule" "control_plane_udp_dns_resolution" {
    security_group_id = "${aws_security_group.control_plane_security_group.id}"
    type = "ingress"
    from_port = 53
    to_port = 53
    protocol = "udp"
    cidr_blocks = [
        "172.31.0.0/16"
    ]
}
resource "aws_security_group_rule" "data_plane_egress_all" {
    security_group_id = "${aws_security_group.data_plane_security_group.id}"
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
        "${aws_vpc.control_plane_vpc.cidr_block}"
    ]
}
# The security groups could/should be much tighter for the egress
resource "aws_security_group_rule" "control_plane_egress_all" {
    security_group_id = "${aws_security_group.control_plane_security_group.id}"
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
        "${aws_vpc.data_plane_vpc.cidr_block}"
    ]
    
}

resource "aws_eip" "worker_nodes_eip" {
    vpc = true
    tags = {
        Name = "Worker Nodes Elastic IP"
        Project = "k8s-and-heartbreak"
    }
}
data "aws_caller_identity" "current" {}

locals {
    peer_owner_id = "${data.aws_caller_identity.current.account_id}"
}

# Peer the worker nodes (data plane) with the control plane (master node)
resource "aws_vpc_peering_connection" "data_and_control_plane_peering" {
    depends_on = [
        "aws_vpc.data_plane_vpc",
        "aws_vpc.control_plane_vpc"
    ]
    peer_owner_id = "${local.peer_owner_id}"
    peer_vpc_id = "${aws_vpc.data_plane_vpc.id}"
    vpc_id = "${aws_vpc.control_plane_vpc.id}"
    auto_accept = true

    tags = {
        Name = "VPC Peering Connection between data and control plane."
        Project = "k8s-and-heartbreak"
        Purpose = "network connectivity"
    }
}




# For this solution follow these steps
# [ ] - Create an inbound endpoint in the worker node VPC.
# By creating a Route 53 inbound endpoint in the worker node
# VPC, DNS queries are sent to the VPC DNS resolver 
# of worker node VPC. This endpoint is now capable 
# of resolving the cluster endpoint.



# [ ] - Create a security group rule to allow 
# inbound traffic from a peered network.
# TODO: These should/could be much, much tighter...
resource "aws_security_group_rule" "control_plane_in_to_data_plane_ingress" {
    security_group_id = "${aws_security_group.data_plane_security_group.id}"

    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
        "${aws_vpc.control_plane_vpc.cidr_block}"
    ]
}

resource "aws_security_group_rule" "data_plane_in_to_control_plane_ingress" {
    security_group_id = "${aws_security_group.control_plane_security_group.id}"

    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
        "${aws_vpc.data_plane_vpc.cidr_block}"
    ]
}


# [ ] - (Optional) Create a forwarding rule in your on-premises DNS for the Kubernetes cluster endpoint 
# N/A

