resource "aws_lb" "eks_control_plane_network_load_balancer" {
    name = "eks-network-load-balancer"
    load_balancer_type = "network"
    # Worker Node Subnet 1
    subnet_mapping {
        subnet_id = "${aws_subnet.data_plane_subnet_1}"
        allocation_id = "${aws_eip.worker_nodes_eip.id}"
    }
    # Worker Node Subnet 2
    subnet_mapping {
        subnet_id {
            subnet_id = "${aws_subnet.data_plane_subnet_2}"
            allocation_id = "${aws_eip.worker_nodes_eip.id}"
        }
    }
}
