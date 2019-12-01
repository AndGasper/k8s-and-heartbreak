output "data_plane_vpc_arn" {
    description = "The Amazon Resource Number of the Data Plane VPC."
    value = "${aws_vpc.data_plane_vpc.arn}"
}

output "data_plane_vpc_subnets" {
    description = "The IDs of the subnets for the data plane."
    value = [
        "${aws_subnet.data_plane_subnet_1.id}",
        "${aws_subnet.data_plane_subnet_2.id}"
    ]
}

output "control_plane_vpc_arn" {
    description = "The ARN of the control plane VPC."
    value = "${aws_vpc.control_plane_vpc.arn}"
}

output "control_plane_vpc_subnets" {
    description = "The IDs of the subnets for the control plane."
    value = [
        "${aws_subnet.control_plane_subnet_1.id}",
        "${aws_subnet.control_plane_subnet_2.id}"
    ]
}